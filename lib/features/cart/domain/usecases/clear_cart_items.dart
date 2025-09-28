import 'package:products_store/features/cart/domain/repositories/cart_repository.dart';

class ClearCartItems {

  final CartRepository repository;

  ClearCartItems(this.repository);

  Future<void> call({required String userId}) => repository.clearCartItems(userId: userId);

}