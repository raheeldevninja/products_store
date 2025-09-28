// functions/index.js
const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { logger } = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

// Trigger on checkout creation
exports.sendCheckoutNotification = onDocumentCreated(
  "checkouts/{checkoutId}",
  async (event) => {
    const snap = event.data;
    if (!snap) return null;

    const checkout = snap.data();
    const checkoutId = event.params.checkoutId;
    const userId = checkout.userId;
    const items = checkout.items || [];
    const currency = checkout.currency || "USD";
    const total = items.reduce(
      (sum, it) => sum + (it.price * it.quantity),
      0
    );

    // Title/Body + optional image
    const title = "Order received";
    const body = `Your order ${checkoutId} • ${currency} ${total.toFixed(2)}`;
    const image = items.length && items[0].imageUrl ? items[0].imageUrl : null;

    // Get user tokens
    const userDoc = await admin.firestore().collection("users").doc(userId).get();
    if (!userDoc.exists) return null;
    const userData = userDoc.data();
    const tokens = userData?.fcmTokens ?? [];

    if (!tokens || tokens.length === 0) {
      logger.info("No tokens for user", { userId });
      return null;
    }

    const message = {
      tokens: tokens,
      notification: {
        title,
        body,
        ...(image ? { image } : {}),
      },
      data: {
        checkoutId: checkoutId,
        total: total.toString(),
      },
      android: {
        notification: {
          image: image || undefined,
          click_action: "FLUTTER_NOTIFICATION_CLICK",
        },
      },
      apns: {
        payload: {
          aps: {
            "mutable-content": 1,
            alert: { title, body },
          },
        },
        fcm_options: {
          image: image || undefined,
        },
      },
      webpush: {
        headers: { TTL: "86400" },
        notification: {
          title,
          body,
          ...(image ? { image } : {}),
        },
      },
    };

    try {
      const response = await admin.messaging().sendEachForMulticast(message);
      logger.info("Sent checkout notification", { response });

      // Remove invalid tokens
      const invalidTokens = [];
      response.responses.forEach((r, idx) => {
        if (!r.success) {
          const err = r.error;
          logger.warn("Failed to send token", {
            token: tokens[idx],
            err: err.toString(),
          });
          if (
            err.code === "messaging/registration-token-not-registered" ||
            err.code === "messaging/invalid-argument"
          ) {
            invalidTokens.push(tokens[idx]);
          }
        }
      });

      if (invalidTokens.length) {
        await admin
          .firestore()
          .collection("users")
          .doc(userId)
          .set(
            {
              fcmTokens: admin.firestore.FieldValue.arrayRemove(...invalidTokens),
            },
            { merge: true }
          );
      }

      return response;
    } catch (err) {
      logger.error("Error sending message", err);
      return null;
    }
  }
);
