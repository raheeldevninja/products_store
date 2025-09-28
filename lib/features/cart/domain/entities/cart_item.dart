import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final String id;
  final String productId;
  final String name;
  final double price;
  final String currency;
  final String imageUrl;
  final int quantity;
  final DateTime addedAt;
  final bool isUpdating;


  const CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.currency,
    required this.imageUrl,
    required this.quantity,
    required this.addedAt,
    this.isUpdating = false,
  });

  CartItem copyWith({
    String? id,
    String? productId,
    String? name,
    double? price,
    String? currency,
    String? imageUrl,
    int? quantity,
    DateTime? addedAt,
    bool? isUpdating,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
      isUpdating: isUpdating ?? this.isUpdating,
    );
  }

  @override
  List<Object?> get props =>
      [id, productId, name, price, currency, imageUrl, quantity, addedAt, isUpdating];
}
