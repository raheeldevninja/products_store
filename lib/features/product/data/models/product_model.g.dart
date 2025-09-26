// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductModel _$ProductModelFromJson(Map<String, dynamic> json) =>
    _ProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String,
      imageUrl: json['imageUrl'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isActive: json['isActive'] as bool,
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$ProductModelToJson(_ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'currency': instance.currency,
      'imageUrl': instance.imageUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'isActive': instance.isActive,
      'quantity': instance.quantity,
    };
