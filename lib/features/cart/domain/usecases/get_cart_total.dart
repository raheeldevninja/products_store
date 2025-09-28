import 'package:products_store/features/cart/domain/repositories/cart_repository.dart';

class GetCartTotal {

  final CartRepository repository;

  GetCartTotal(this.repository);

  Future<double> call({required String userId}) => repository.getCartTotal(userId: userId);

}