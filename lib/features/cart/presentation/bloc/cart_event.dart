part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {

  const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartStarted extends CartEvent {
  final String userId;

  const CartStarted(this.userId);

  @override
  List<Object?> get props => [userId];
}

class CartItemsUpdated extends CartEvent {

  final List<CartItem> items;

  const CartItemsUpdated(this.items);

  @override
  List<Object?> get props => [items];
}

class CartItemsUpdatedError extends CartEvent {

  final String message;

  const CartItemsUpdatedError(this.message);

  @override
  List<Object?> get props => [message];
}

class CartAddRequested extends CartEvent {
  final String userId;
  final String productId;
  final String name;
  final double price;
  final String currency;
  final String imageUrl;
  final int quantity;

  const CartAddRequested({
    required this.userId,
    required this.productId,
    required this.name,
    required this.price,
    required this.currency,
    required this.imageUrl,
    this.quantity = 1,
  });

  @override
  List<Object?> get props =>
      [userId, productId, name, price, currency, imageUrl, quantity];
}


class CartRemoveRequested extends CartEvent {
  final String userId;
  final String cartItemId;

  const CartRemoveRequested({required this.userId, required this.cartItemId});

  @override
  List<Object?> get props => [userId, cartItemId];
}

class CartQuantityUpdated extends CartEvent {

  final String userId;
  final String cartItemId;
  final int newQuantity;

  const CartQuantityUpdated({required this.userId, required this.cartItemId, required this.newQuantity});

  @override
  List<Object?> get props => [userId, cartItemId, newQuantity];
}

class CartCleared extends CartEvent {}

class CartItemsCleared extends CartEvent {
  final String userId;

  const CartItemsCleared(this.userId);

  @override
  List<Object?> get props => [userId];
}

