part of 'checkout_bloc.dart';

sealed class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class CheckoutStarted extends CheckoutEvent {
  final String userId;

  const CheckoutStarted(this.userId);

  @override
  List<Object?> get props => [userId];
}

class CheckoutCreated extends CheckoutEvent {
  final String userId;
  final List<CheckoutItem> items;
  final String currency;

  const CheckoutCreated({
    required this.userId,
    required this.items,
    required this.currency,
  });

  @override
  List<Object?> get props => [userId, items, currency];
}

class CheckoutConfirmed extends CheckoutEvent {
  final String checkoutId;

  const CheckoutConfirmed(this.checkoutId);

  @override
  List<Object?> get props => [checkoutId];
}

class CheckoutCancelled extends CheckoutEvent {
  final String checkoutId;

  const CheckoutCancelled(this.checkoutId);

  @override
  List<Object?> get props => [checkoutId];
}

class CheckoutItemsUpdated extends CheckoutEvent {

  final List<Checkout> items;

  const CheckoutItemsUpdated(this.items);

  @override
  List<Object?> get props => [items];
}
