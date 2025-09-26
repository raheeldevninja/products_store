import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:products_store/features/product/domain/entity/product.dart';

class ProductPage {
  final List<Product> products;
  final DocumentSnapshot? lastDoc;
  final bool hasMore;

  ProductPage({
    required this.products,
    required this.lastDoc,
    required this.hasMore,
  });
}