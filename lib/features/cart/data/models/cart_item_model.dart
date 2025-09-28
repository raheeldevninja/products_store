import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:products_store/features/cart/domain/entities/cart_item.dart';

part 'cart_item_model.freezed.dart';
part 'cart_item_model.g.dart';

@freezed
abstract class CartItemModel with _$CartItemModel {
  const factory CartItemModel({
    required String id,
    required String productId,
    required String name,
    required double price,
    required String currency,
    required String imageUrl,
    required int quantity,
    required DateTime addedAt,
  }) = _CartItemModel;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  factory CartItemModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final addedRaw = data['addedAt'];
    DateTime addedAt;
    if (addedRaw is Timestamp) {
      addedAt = addedRaw.toDate();
    } else {
      addedAt = DateTime.now();
    }
    return CartItemModel(
      id: doc.id,
      productId: data['productId'] ?? '',
      name: data['name'] ?? '',
      price: (data['price'] is int)
          ? (data['price'] as int).toDouble()
          : (data['price'] ?? 0.0),
      currency: data['currency'] ?? 'USD',
      imageUrl: data['imageUrl'] ?? '',
      quantity: (data['quantity'] is int)
          ? data['quantity'] as int
          : (data['quantity'] is double
          ? (data['quantity'] as double).toInt()
          : 0),
      addedAt: addedAt,
    );
  }

}

extension CartItemModelX on CartItemModel {

  /// Map to domain entity
  CartItem toEntity() => CartItem(
    id: id,
    productId: productId,
    name: name,
    price: price,
    currency: currency,
    imageUrl: imageUrl,
    quantity: quantity,
    addedAt: addedAt,
  );

  static CartItemModel fromEntity(CartItem item) => CartItemModel(
    id: item.id,
    productId: item.productId,
    name: item.name,
    price: item.price,
    currency: item.currency,
    imageUrl: item.imageUrl,
    quantity: item.quantity,
    addedAt: item.addedAt,
  );
}
