import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:products_store/features/cart/data/models/cart_item_model.dart';
import 'package:products_store/features/product/data/data_sources/products_service.dart';

class CartRemoteDataSource {

  final FirebaseFirestore _firestore;
  final ProductsService _productsService;

  CartRemoteDataSource({FirebaseFirestore? firestore, required ProductsService productsService})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _productsService = productsService;

  CollectionReference _userCartRef(String userId) =>
      _firestore.collection('users').doc(userId).collection('cart');

  Stream<List<CartItemModel>> cartStream(String userId) {

    return _userCartRef(userId)
        .orderBy('addedAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => CartItemModel.fromFirestore(d)).toList());
  }

  Future<void> addToCart({
    required String userId,
    required String productId,
    int quantity = 1,
  }) async {

    final productRef = _productsService.productsRef.doc(productId);
    final cartCollection = _userCartRef(userId);

    await _firestore.runTransaction((tx) async {
      // ✅ Read product inside transaction
      final prodSnap = await tx.get(productRef);
      if (!prodSnap.exists) throw Exception('Product not found');

      final prodData = prodSnap.data() as Map<String, dynamic>;

      int stock = 0;
      final qtyRaw = prodData['quantity'];
      if (qtyRaw is int) {
        stock = qtyRaw;
      } else if (qtyRaw is double) {
        stock = qtyRaw.toInt();
      }

      // ✅ Instead of .get() outside, use tx.get on cart doc
      // Use deterministic docId: e.g., productId as key in user's cart
      final cartDocRef = cartCollection.doc(productId);
      final cartSnap = await tx.get(cartDocRef);

      if (cartSnap.exists) {
        final existingQty = (cartSnap.data() as Map<String, dynamic>)['quantity'];

        if (stock < existingQty + quantity) {
          throw Exception('Insufficient stock');
        }

        tx.update(cartDocRef, {'quantity': existingQty + quantity});
      } else {
        if (stock < quantity) throw Exception('Insufficient stock');

        // Read product fields for cart snapshot
        final name = prodData['name'] ?? '';
        final price = (prodData['price'] is int)
            ? (prodData['price'] as int).toDouble()
            : (prodData['price'] ?? 0.0);
        final currency = prodData['currency'] ?? 'USD';
        final imageUrl = prodData['imageUrl'] ?? '';

        tx.set(cartDocRef, {
          'productId': productId,
          'name': name,
          'price': price,
          'currency': currency,
          'imageUrl': imageUrl,
          'quantity': quantity,
          'addedAt': FieldValue.serverTimestamp(),
        });
      }

      // ✅ Decrement stock inside same transaction
      tx.update(productRef, {'quantity': stock - quantity});
    });
  }


  Future<void> removeFromCart({required String userId, required String cartItemId}) async {

    final cartRef = _userCartRef(userId).doc(cartItemId);

    // If you want to restore stock, you should increment product.quantity by cartItem.quantity in a transaction
    final cartSnap = await cartRef.get();

    if (!cartSnap.exists) {
      return;
    }

    final cartData = cartSnap.data() as Map<String, dynamic>;
    final prodId = cartData['productId'] as String?;
    final qty = (cartData['quantity'] as int?) ?? 0;

    if (prodId != null && qty > 0) {

      final productRef = _productsService.productsRef.doc(prodId);

      await _firestore.runTransaction((tx) async {

        final prodSnap = await tx.get(productRef);

        tx.delete(cartRef);

        if (prodSnap.exists) {

          final prodData = prodSnap.data() as Map<String, dynamic>;

          int stock = (prodData['quantity'] is int) ?
            prodData['quantity'] as int :
              ((prodData['quantity'] as double?)?.toInt() ?? 0);

          tx.update(productRef, {'quantity': stock + qty});
        }
      });

    } else {
      await cartRef.delete();
    }
  }

  Future<void> updateCartItemQuantity({
    required String userId,
    required String cartItemId,
    required int quantity,
  }) async {
    final cartRef = _userCartRef(userId).doc(cartItemId);

    await _firestore.runTransaction((tx) async {
      // ✅ Read cart inside the transaction
      final cartSnap = await tx.get(cartRef);
      if (!cartSnap.exists) throw Exception('Cart item not found');

      final cartData = cartSnap.data() as Map<String, dynamic>;
      final productId = cartData['productId'] as String;
      final oldQty = (cartData['quantity'] as int);

      final productRef = _productsService.productsRef.doc(productId);

      // ✅ Read product inside the transaction
      final prodSnap = await tx.get(productRef);
      if (!prodSnap.exists) throw Exception('Product not found');

      final prodData = prodSnap.data() as Map<String, dynamic>;
      int stock = (prodData['quantity'] is int)
          ? prodData['quantity'] as int
          : ((prodData['quantity'] as double?)?.toInt() ?? 0);

      final diff = quantity - oldQty;

      if (diff > 0) {
        // increase quantity in cart => need to reduce stock
        if (stock < diff) throw Exception('Insufficient stock');
        tx.update(cartRef, {'quantity': quantity});
        tx.update(productRef, {'quantity': stock - diff});
      } else if (diff < 0) {
        // decrease quantity in cart => increase stock
        tx.update(cartRef, {'quantity': quantity});
        tx.update(productRef, {'quantity': stock - diff}); // diff is negative, so -diff = +restore
      } else {
        // no change
      }
    });
  }

  Future<void> clearCart({required String userId}) async {

    final cartCollection = _userCartRef(userId);

    final snap = await cartCollection.get();

    // Optionally, restore stock for each item. Here we simply delete cart docs
    final batch = _firestore.batch();

    for (final doc in snap.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  Future<double> computeCartTotal(String userId) async {

    final snap = await _userCartRef(userId).get();
    double total = 0;

    for (final d in snap.docs) {
      final data = d.data() as Map<String, dynamic>;
      final price = (data['price'] is int) ? (data['price'] as int).toDouble() : (data['price'] ?? 0.0);
      final quantity = (data['quantity'] as int?) ?? 0;
      total += price * quantity;
    }

    return total;
  }

}
