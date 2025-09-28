import 'package:products_store/features/cart/domain/repositories/cart_repository.dart';

class AddToCart {

  final CartRepository repository;

  AddToCart(this.repository);

  Future<void> call({required String userId, required String productId, int quantity = 1}) {
    return repository.addToCart(userId: userId, productId: productId, quantity: quantity);
  }
}
