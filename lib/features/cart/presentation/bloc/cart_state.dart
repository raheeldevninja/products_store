part of 'cart_bloc.dart';

sealed class CartState extends Equatable {

  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartLoadInProgress extends CartState {}

class CartLoadSuccess extends CartState {
  final List<CartItem> items;
  final double total;
  final bool outOfStock;

  const CartLoadSuccess({
    required this.items,
    required this.total,
    this.outOfStock = false,
  });

  CartLoadSuccess copyWith({
    List<CartItem>? items,
    double? total,
    bool? outOfStock,
  }) {
    return CartLoadSuccess(
      items: items ?? this.items,
      total: total ?? this.total,
      outOfStock: outOfStock ?? this.outOfStock,
    );
  }

  @override
  List<Object?> get props => [items, total, outOfStock];
}

class CartOperationFailure extends CartState {

  final String message;

  const CartOperationFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
