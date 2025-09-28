import 'package:products_store/features/checkout/domain/entities/checkout.dart';

abstract class CheckoutRepository {
  Future<Checkout> createCheckout({
    required String userId,
    required List<CheckoutItem> items,
    required String currency,
  });

  Future<void> confirmCheckout(String checkoutId);

  Future<void> cancelCheckout(String checkoutId);

  Stream<List<Checkout>> getUserCheckouts(String userId);

  Future<void> clearCartItems(String userId);

}
