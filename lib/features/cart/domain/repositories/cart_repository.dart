import 'package:products_store/features/cart/domain/entities/cart_item.dart';

abstract class CartRepository {

  /// Real-time stream of cart items for [userId]
  Stream<List<CartItem>> cartStream(String userId);

  /// Add a product to user's cart. Should check stock & run transaction.
  Future<void> addToCart({required String userId, required String productId, required int quantity});

  /// Remove cart item by doc id
  Future<void> removeFromCart({required String userId, required String cartItemId});

  /// Update quantity of a cart item (should validate stock)
  Future<void> updateCartItemQuantity({required String userId, required String cartItemId, required int quantity});

  /// Clear all cart items for user
  Future<void> clearCart({required String userId});

  /// Compute cart total for user (can be implemented by summing stream items)
  Future<double> getCartTotal({required String userId});

}
