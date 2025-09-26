import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:products_store/features/product/data/models/product_page.dart';

abstract class ProductRepository {
  /// Fetches a page of products ordered by createdAt desc.
  /// [pageSize] items per page, [startAfter] optional DocumentSnapshot from last page.
  Future<ProductPage> fetchProducts({
    int pageSize = 20,
    DocumentSnapshot? startAfter,
  });
}