import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';


class NotificationService {
  NotificationService._();
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;

  final _fcm = FirebaseMessaging.instance;
  final _firestore = FirebaseFirestore.instance;
  final FlutterLocalNotificationsPlugin _local = FlutterLocalNotificationsPlugin();

  Future<void> init({required String? currentUserId}) async {
    // local notifications init
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final ios = DarwinInitializationSettings();
    await _local.initialize(
      InitializationSettings(android: android, iOS: ios),
      // onDidReceiveNotificationResponse: ... // optional
    );

    // Request permissions (iOS)
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    debugPrint('FCM permission: ${settings.authorizationStatus}');

    // handle foreground messages - we show local notification (with image) for better control
    FirebaseMessaging.onMessage.listen((RemoteMessage msg) async {
      debugPrint('Foreground message: ${msg.notification?.title}');
      await _showRemoteMessageAsLocalNotification(msg);
    });

    // token refresh -> save it (call your repository to persist)
    _fcm.onTokenRefresh.listen((token) async {
      debugPrint('FCM token refreshed: $token');
      if (currentUserId != null) {
        await saveTokenForUser(userId: currentUserId, token: token);
      }
    });
  }

  Future<String?> getToken() => _fcm.getToken();

  Future<void> saveTokenForUser({required String userId, required String token}) async {
    final doc = _firestore.collection('users').doc(userId);
    // store tokens array to allow multiple devices
    await doc.set({
      'fcmTokens': FieldValue.arrayUnion([token]),
      'lastFCM': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> removeTokenForUser({required String userId, required String token}) async {
    final doc = _firestore.collection('users').doc(userId);
    await doc.set({
      'fcmTokens': FieldValue.arrayRemove([token]),
    }, SetOptions(merge: true));
  }

  // Show message with image (if present) via flutter_local_notifications
  Future<void> _showRemoteMessageAsLocalNotification(RemoteMessage msg) async {
    final notification = msg.notification;

    // If the message has a notification with image URL in notification?.android?.image or msg.data['image']
    String? imageUrl = notification?.android?.imageUrl ?? notification?.apple?.imageUrl ?? msg.data['image'];

    if (imageUrl != null && imageUrl.isNotEmpty) {
      try {
        final bigPicturePath = await _downloadAndSaveFile(imageUrl, 'notif_img');
        final bigPictureStyle = BigPictureStyleInformation(
          FilePathAndroidBitmap(bigPicturePath),
          contentTitle: notification?.title ?? '',
          summaryText: notification?.body ?? '',
        );

        final androidDetails = AndroidNotificationDetails(
          'default_channel',
          'Default',
          channelDescription: 'General notifications',
          styleInformation: bigPictureStyle,
          importance: Importance.max,
          priority: Priority.high,
        );

        final iosDetails = DarwinNotificationDetails(attachments: [
          if (bigPicturePath.isNotEmpty)
            DarwinNotificationAttachment(bigPicturePath)
        ]);

        await _local.show(
          msg.hashCode,
          notification?.title,
          notification?.body,
          NotificationDetails(android: androidDetails, iOS: iosDetails),
          payload: msg.data['checkoutId'] ?? '',
        );
        return;
      } catch (e) {
        debugPrint('Error showing big picture notification: $e');
      }
    }

    // fallback: simple notification
    final androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default',
      channelDescription: 'General notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    final iosDetails = DarwinNotificationDetails();

    await _local.show(
      msg.hashCode,
      notification?.title ?? msg.data['title'],
      notification?.body ?? msg.data['body'],
      NotificationDetails(android: androidDetails, iOS: iosDetails),
      payload: msg.data['checkoutId'] ?? '',
    );
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes);
    return file.path;
  }
}
