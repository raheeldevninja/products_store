// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    _CartItemModel(
      id: json['id'] as String,
      productId: json['productId'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      imageUrl: json['imageUrl'] as String,
      quantity: (json['quantity'] as num).toInt(),
      addedAt: DateTime.parse(json['addedAt'] as String),
    );

Map<String, dynamic> _$CartItemModelToJson(_CartItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'name': instance.name,
      'price': instance.price,
      'currency': instance.currency,
      'imageUrl': instance.imageUrl,
      'quantity': instance.quantity,
      'addedAt': instance.addedAt.toIso8601String(),
    };
