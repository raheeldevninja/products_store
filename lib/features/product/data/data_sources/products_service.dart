import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsService {

  final FirebaseFirestore _firestore;

  ProductsService({FirebaseFirestore? firestore}) :
        _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference get productsRef => _firestore.collection('products');

  Future<QuerySnapshot> fetchProductsPage({
    required int pageSize,
    DocumentSnapshot? startAfter,
  }) {
    Query q = productsRef
        .where('isActive', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .limit(pageSize);

    if (startAfter != null) q = q.startAfterDocument(startAfter);

    return q.get();
  }



}