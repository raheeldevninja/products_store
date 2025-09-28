import 'package:products_store/features/cart/domain/repositories/cart_repository.dart';

class ClearCart {

  final CartRepository repository;

  ClearCart(this.repository);

  Future<void> call({required String userId}) => repository.clearCart(userId: userId);

}