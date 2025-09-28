import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:products_store/features/checkout/domain/entities/checkout.dart';

part 'checkout_model.freezed.dart';
part 'checkout_model.g.dart';

@freezed
abstract class CheckoutModel with _$CheckoutModel {
  const factory CheckoutModel({
    required String id,
    required String userId,
    required double total,
    required String currency,
    required String status,
    required DateTime createdAt,
    required List<CheckoutItemModel> items,
  }) = _CheckoutModel;

  factory CheckoutModel.fromJson(Map<String, dynamic> json) =>
      _$CheckoutModelFromJson(json);
}

@freezed
abstract class CheckoutItemModel with _$CheckoutItemModel {
  const factory CheckoutItemModel({
    required String productId,
    required String name,
    required double price,
    required int quantity,
    required String imageUrl,
  }) = _CheckoutItemModel;

  factory CheckoutItemModel.fromJson(Map<String, dynamic> json) =>
      _$CheckoutItemModelFromJson(json);
}

// entity → model
extension CheckoutItemEntityX on CheckoutItem {
  CheckoutItemModel toModel() => CheckoutItemModel(
    productId: productId,
    name: name,
    price: price,
    quantity: quantity,
    imageUrl: imageUrl,
  );
}

// model → entity
extension CheckoutItemModelX on CheckoutItemModel {
  CheckoutItem toEntity() => CheckoutItem(
    productId: productId,
    name: name,
    price: price,
    quantity: quantity,
    imageUrl: imageUrl,
  );
}

extension CheckoutModelX on CheckoutModel {
  Checkout toEntity() => Checkout(
    id: id,
    userId: userId,
    total: total,
    currency: currency,
    status: status,
    createdAt: createdAt,
    items: items.map((i) => i.toEntity()).toList(),
  );
}
