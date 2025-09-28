import 'package:products_store/features/cart/domain/repositories/cart_repository.dart';

class UpdateCartQuantity {

  final CartRepository repository;

  UpdateCartQuantity(this.repository);

  Future<void> call({required String userId, required String cartItemId, required int quantity}) =>
      repository.updateCartItemQuantity(userId: userId, cartItemId: cartItemId, quantity: quantity);

}
