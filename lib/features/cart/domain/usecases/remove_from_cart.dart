import 'package:products_store/features/cart/domain/repositories/cart_repository.dart';

class RemoveFromCart {

  final CartRepository repository;

  RemoveFromCart(this.repository);

  Future<void> call({required String userId, required String cartItemId}) =>
      repository.removeFromCart(userId: userId, cartItemId: cartItemId);

}
