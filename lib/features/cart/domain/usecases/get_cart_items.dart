import 'package:products_store/features/cart/domain/entities/cart_item.dart';
import 'package:products_store/features/cart/domain/repositories/cart_repository.dart';

class GetCartItems {
  final CartRepository repository;

  GetCartItems(this.repository);

  Stream<List<CartItem>> call(String userId) => repository.cartStream(userId);

}