import 'package:products_store/features/checkout/data/data_sources/checkout_remote_data_source.dart';
import 'package:products_store/features/checkout/data/models/checkout_model.dart';

import 'package:products_store/features/checkout/domain/entities/checkout.dart';
import 'package:products_store/features/checkout/domain/repositories/checkout_repository.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSource remote;

  CheckoutRepositoryImpl(this.remote);

  @override
  Future<Checkout> createCheckout({
    required String userId,
    required List<CheckoutItem> items,
    required String currency,
  }) async {

    final itemModels = items.map((e) => e.toModel()).toList();

    final model = await remote.createCheckout(
      userId: userId,
      items: itemModels,
      currency: currency,
    );

    return model.toEntity();

   }

  @override
  Future<void> confirmCheckout(String checkoutId) {
    return remote.confirmCheckout(checkoutId);
  }

  @override
  Future<void> cancelCheckout(String checkoutId) {
    return remote.cancelCheckout(checkoutId);
  }

  @override
  Stream<List<Checkout>> getUserCheckouts(String userId) {
    return remote
        .getUserCheckouts(userId)
        .map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Future<void> clearCartItems(String userId) {
    return remote.clearCartItems(userId);
  }

}
