import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:products_store/features/cart/domain/entities/cart_item.dart';

class CartItemModel {
  final String id;
  final String productId;
  final String name;
  final double price;
  final String currency;
  final String imageUrl;
  final int quantity;
  final DateTime addedAt;

  CartItemModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.currency,
    required this.imageUrl,
    required this.quantity,
    required this.addedAt,
  });

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
      price: (data['price'] is int) ? (data['price'] as int).toDouble() : (data['price'] ?? 0.0),
      currency: data['currency'] ?? 'USD',
      imageUrl: data['imageUrl'] ?? '',
      quantity: (data['quantity'] is int) ? data['quantity'] as int : (data['quantity'] is double ? (data['quantity'] as double).toInt() : 0),
      addedAt: addedAt,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'currency': currency,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'addedAt': FieldValue.serverTimestamp(),
    };
  }

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
}
