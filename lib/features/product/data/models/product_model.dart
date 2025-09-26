import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:products_store/features/product/domain/entity/product.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const factory ProductModel({
    required String id,
    required String name,
    required String description,
    required double price,
    required String currency,
    required String imageUrl,
    required DateTime createdAt,
    required bool isActive,
    required int quantity,
  }) = _ProductModel;

  /// JSON converter
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  /// Firestore converter
  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] is int)
          ? (data['price'] as int).toDouble()
          : (data['price'] ?? 0.0),
      currency: data['currency'] ?? 'USD',
      imageUrl: data['imageUrl'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      isActive: data['isActive'] ?? true,
      quantity: data['quantity'] ?? 0,
    );
  }
}

extension ProductModelX on ProductModel {
  /// Map to domain entity
  Product toEntity() => Product(
    id: id,
    name: name,
    description: description,
    price: price,
    currency: currency,
    imageUrl: imageUrl,
    createdAt: createdAt,
    isActive: isActive,
    quantity: quantity,
  );

  /// Create from domain entity
  static ProductModel fromEntity(Product product) => ProductModel(
    id: product.id,
    name: product.name,
    description: product.description,
    price: product.price,
    currency: product.currency,
    imageUrl: product.imageUrl,
    createdAt: product.createdAt,
    isActive: product.isActive,
    quantity: product.quantity,
  );
}
