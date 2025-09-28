import 'package:products_store/features/checkout/domain/repositories/checkout_repository.dart';

class CancelCheckout {
  final CheckoutRepository repository;

  CancelCheckout(this.repository);

  Future<void> call(String checkoutId) {
    return repository.cancelCheckout(checkoutId);
  }
}
