import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_item.freezed.dart';

@freezed
abstract class CartItem with _$CartItem {
  const factory CartItem({
    required String id,
    required String productId,
    required String name,
    required double price,
    required String currency,
    required String imageUrl,
    required int quantity,
    required DateTime addedAt,
    @Default(false) bool isUpdating,
  }) = _CartItem;
}
