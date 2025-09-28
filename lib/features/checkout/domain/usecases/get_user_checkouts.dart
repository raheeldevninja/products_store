import 'package:products_store/features/checkout/domain/entities/checkout.dart';
import 'package:products_store/features/checkout/domain/repositories/checkout_repository.dart';

class GetUserCheckouts {
  final CheckoutRepository repository;

  GetUserCheckouts(this.repository);

  Stream<List<Checkout>> call(String userId) {
    return repository.getUserCheckouts(userId);
  }
}