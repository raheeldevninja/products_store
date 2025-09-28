import 'package:products_store/features/checkout/domain/repositories/checkout_repository.dart';

class ConfirmCheckout {
  final CheckoutRepository repository;

  ConfirmCheckout(this.repository);

  Future<void> call(String checkoutId) {
    return repository.confirmCheckout(checkoutId);
  }
}