import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String currency;
  final String imageUrl;
  final DateTime createdAt;
  final bool isActive;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.currency,
    required this.imageUrl,
    required this.createdAt,
    required this.isActive,
  });

  @override
  List<Object?> get props => [id, name, price, quantity, currency, imageUrl, isActive];
}
