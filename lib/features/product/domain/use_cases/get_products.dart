import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:products_store/features/product/data/models/product_page.dart';
import 'package:products_store/features/product/domain/repositories/product_repository.dart';

class GetProducts {

  final ProductRepository repository;

  GetProducts(this.repository);

  Future<ProductPage> call({int pageSize = 10, DocumentSnapshot? startAfter}) {
    return repository.fetchProducts(pageSize: pageSize, startAfter: startAfter);
  }

}