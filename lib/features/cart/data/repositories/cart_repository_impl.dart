import 'package:products_store/features/cart/domain/entities/cart_item.dart';
import 'package:products_store/features/cart/domain/repositories/cart_repository.dart';
import '../data_sources/cart_remote_data_source.dart';

class CartRepositoryImpl implements CartRepository {

  final CartRemoteDataSource remote;

  CartRepositoryImpl(this.remote);

  @override
  Stream<List<CartItem>> cartStream(String userId) {
    return remote.cartStream(userId).map((models) => models.map((m) => m.toEntity()).toList());
  }

  @override
  Future<void> addToCart({required String userId, required String productId, required int quantity}) {
    return remote.addToCart(userId: userId, productId: productId, quantity: quantity);
  }

  @override
  Future<void> removeFromCart({required String userId, required String cartItemId}) {
    return remote.removeFromCart(userId: userId, cartItemId: cartItemId);
  }

  @override
  Future<void> updateCartItemQuantity({required String userId, required String cartItemId, required int quantity}) {
    return remote.updateCartItemQuantity(userId: userId, cartItemId: cartItemId, quantity: quantity);
  }

  @override
  Future<void> clearCart({required String userId}) => remote.clearCart(userId: userId);

  @override
  Future<double> getCartTotal({required String userId}) => remote.computeCartTotal(userId);
}
