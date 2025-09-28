part of 'checkout_bloc.dart';

sealed class CheckoutState extends Equatable {
  const CheckoutState();

  @override
  List<Object?> get props => [];
}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoadInProgress extends CheckoutState {}

class CheckoutLoadSuccess extends CheckoutState {
  final List<Checkout> checkouts;

  const CheckoutLoadSuccess(this.checkouts);

  @override
  List<Object?> get props => [checkouts];
}

class CheckoutOperationSuccess extends CheckoutState {
  final Checkout checkout;

  const CheckoutOperationSuccess(this.checkout);

  @override
  List<Object?> get props => [checkout];
}

class CheckoutFailure extends CheckoutState {
  final String message;

  const CheckoutFailure(this.message);

  @override
  List<Object?> get props => [message];
}
