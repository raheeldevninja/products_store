import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:products_store/features/checkout/data/models/checkout_model.dart';

class CheckoutRemoteDataSource {
  final FirebaseFirestore _firestore;

  CheckoutRemoteDataSource({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;


  Future<CheckoutModel> createCheckout({
    required String userId,
    required List<CheckoutItemModel> items,
    required String currency,
  }) async {
    final ref = _firestore.collection('checkouts').doc();

    final model = CheckoutModel(
      id: ref.id,
      userId: userId,
      total: items.fold(0, (add, i) => add + (i.price * i.quantity)),
      currency: currency,
      status: "pending",
      createdAt: DateTime.now(),
      items: items,
    );


    // FIX: convert nested models to JSON
    await ref.set(model.toJson()
      ..['items'] = items.map((i) => i.toJson()).toList());

    return model;
  }

  Future<void> confirmCheckout(String checkoutId) {
    return _firestore.collection('checkouts').doc(checkoutId).update({
      'status': 'success',
    });
  }

  Future<void> cancelCheckout(String checkoutId) {
    return _firestore.collection('checkouts').doc(checkoutId).update({
      'status': 'cancelled',
    });
  }

  Stream<List<CheckoutModel>> getUserCheckouts(String userId) {
    return _firestore
        .collection('checkouts')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snap) => snap.docs
        .map((doc) => CheckoutModel.fromJson(doc.data()))
        .toList());
  }

  Future<void> clearCartItems(String userId) async {

    final cartRef = _firestore.collection('carts').doc(userId).collection('items');

    final batch = _firestore.batch();
    final snapshots = await cartRef.get();

    for (final doc in snapshots.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

}