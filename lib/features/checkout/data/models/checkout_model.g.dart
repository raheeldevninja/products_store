// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CheckoutModel _$CheckoutModelFromJson(Map<String, dynamic> json) =>
    _CheckoutModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      total: (json['total'] as num).toDouble(),
      currency: json['currency'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      items: (json['items'] as List<dynamic>)
          .map((e) => CheckoutItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckoutModelToJson(_CheckoutModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'total': instance.total,
      'currency': instance.currency,
      'status': instance.status,
      'createdAt': instance.createdAt.toIso8601String(),
      'items': instance.items,
    };

_CheckoutItemModel _$CheckoutItemModelFromJson(Map<String, dynamic> json) =>
    _CheckoutItemModel(
      productId: json['productId'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$CheckoutItemModelToJson(_CheckoutItemModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'imageUrl': instance.imageUrl,
    };
