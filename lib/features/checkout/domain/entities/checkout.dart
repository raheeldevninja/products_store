import 'package:freezed_annotation/freezed_annotation.dart';

part 'checkout.freezed.dart';

@freezed
abstract class Checkout with _$Checkout {
  const factory Checkout({
    required String id,
    required String userId,
    required double total,
    required String currency,
    required String status, // e.g. pending, success, failed
    required DateTime createdAt,
    required List<CheckoutItem> items,
  }) = _Checkout;
}

@freezed
abstract class CheckoutItem with _$CheckoutItem {
  const factory CheckoutItem({
    required String productId,
    required String name,
    required double price,
    required int quantity,
    required String imageUrl,
  }) = _CheckoutItem;
}

