import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:products_store/features/product/data/data_sources/products_service.dart';
import 'package:products_store/features/product/data/models/product_page.dart';
import 'package:products_store/features/product/data/models/product_model.dart';
import 'package:products_store/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {

  final ProductsService _service;

  ProductRepositoryImpl(this._service);

  @override
  Future<ProductPage> fetchProducts({
    int pageSize = 20,
    DocumentSnapshot? startAfter,
  }) async {

    final snap = await _service.fetchProductsPage(pageSize: pageSize, startAfter: startAfter);

    final products = snap.docs
        .map((d) => ProductModel.fromFirestore(d).toEntity())
        .toList();

    return ProductPage(
      products: products,
      lastDoc: snap.docs.isNotEmpty ? snap.docs.last : null,
      hasMore: products.length == pageSize,
    );

  }

}