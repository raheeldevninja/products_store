import 'package:products_store/features/checkout/domain/entities/checkout.dart';
import 'package:products_store/features/checkout/domain/repositories/checkout_repository.dart';

class CreateCheckout {
  final CheckoutRepository repository;

  CreateCheckout(this.repository);

  Future<Checkout> call({
    required String userId,
    required List<CheckoutItem> items,
    required String currency,
  }) {
    return repository.createCheckout(
      userId: userId,
      items: items,
      currency: currency,
    );
  }
}