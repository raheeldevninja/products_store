// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CheckoutModel {

 String get id; String get userId; double get total; String get currency; String get status; DateTime get createdAt; List<CheckoutItemModel> get items;
/// Create a copy of CheckoutModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutModelCopyWith<CheckoutModel> get copyWith => _$CheckoutModelCopyWithImpl<CheckoutModel>(this as CheckoutModel, _$identity);

  /// Serializes this CheckoutModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.total, total) || other.total == total)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,total,currency,status,createdAt,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'CheckoutModel(id: $id, userId: $userId, total: $total, currency: $currency, status: $status, createdAt: $createdAt, items: $items)';
}


}

/// @nodoc
abstract mixin class $CheckoutModelCopyWith<$Res>  {
  factory $CheckoutModelCopyWith(CheckoutModel value, $Res Function(CheckoutModel) _then) = _$CheckoutModelCopyWithImpl;
@useResult
$Res call({
 String id, String userId, double total, String currency, String status, DateTime createdAt, List<CheckoutItemModel> items
});




}
/// @nodoc
class _$CheckoutModelCopyWithImpl<$Res>
    implements $CheckoutModelCopyWith<$Res> {
  _$CheckoutModelCopyWithImpl(this._self, this._then);

  final CheckoutModel _self;
  final $Res Function(CheckoutModel) _then;

/// Create a copy of CheckoutModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? total = null,Object? currency = null,Object? status = null,Object? createdAt = null,Object? items = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CheckoutItemModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckoutModel].
extension CheckoutModelPatterns on CheckoutModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutModel value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutModel value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  double total,  String currency,  String status,  DateTime createdAt,  List<CheckoutItemModel> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutModel() when $default != null:
return $default(_that.id,_that.userId,_that.total,_that.currency,_that.status,_that.createdAt,_that.items);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  double total,  String currency,  String status,  DateTime createdAt,  List<CheckoutItemModel> items)  $default,) {final _that = this;
switch (_that) {
case _CheckoutModel():
return $default(_that.id,_that.userId,_that.total,_that.currency,_that.status,_that.createdAt,_that.items);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  double total,  String currency,  String status,  DateTime createdAt,  List<CheckoutItemModel> items)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutModel() when $default != null:
return $default(_that.id,_that.userId,_that.total,_that.currency,_that.status,_that.createdAt,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckoutModel implements CheckoutModel {
  const _CheckoutModel({required this.id, required this.userId, required this.total, required this.currency, required this.status, required this.createdAt, required final  List<CheckoutItemModel> items}): _items = items;
  factory _CheckoutModel.fromJson(Map<String, dynamic> json) => _$CheckoutModelFromJson(json);

@override final  String id;
@override final  String userId;
@override final  double total;
@override final  String currency;
@override final  String status;
@override final  DateTime createdAt;
 final  List<CheckoutItemModel> _items;
@override List<CheckoutItemModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of CheckoutModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutModelCopyWith<_CheckoutModel> get copyWith => __$CheckoutModelCopyWithImpl<_CheckoutModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckoutModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.total, total) || other.total == total)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,total,currency,status,createdAt,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'CheckoutModel(id: $id, userId: $userId, total: $total, currency: $currency, status: $status, createdAt: $createdAt, items: $items)';
}


}

/// @nodoc
abstract mixin class _$CheckoutModelCopyWith<$Res> implements $CheckoutModelCopyWith<$Res> {
  factory _$CheckoutModelCopyWith(_CheckoutModel value, $Res Function(_CheckoutModel) _then) = __$CheckoutModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, double total, String currency, String status, DateTime createdAt, List<CheckoutItemModel> items
});




}
/// @nodoc
class __$CheckoutModelCopyWithImpl<$Res>
    implements _$CheckoutModelCopyWith<$Res> {
  __$CheckoutModelCopyWithImpl(this._self, this._then);

  final _CheckoutModel _self;
  final $Res Function(_CheckoutModel) _then;

/// Create a copy of CheckoutModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? total = null,Object? currency = null,Object? status = null,Object? createdAt = null,Object? items = null,}) {
  return _then(_CheckoutModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CheckoutItemModel>,
  ));
}


}


/// @nodoc
mixin _$CheckoutItemModel {

 String get productId; String get name; double get price; int get quantity; String get imageUrl;
/// Create a copy of CheckoutItemModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutItemModelCopyWith<CheckoutItemModel> get copyWith => _$CheckoutItemModelCopyWithImpl<CheckoutItemModel>(this as CheckoutItemModel, _$identity);

  /// Serializes this CheckoutItemModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutItemModel&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,name,price,quantity,imageUrl);

@override
String toString() {
  return 'CheckoutItemModel(productId: $productId, name: $name, price: $price, quantity: $quantity, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $CheckoutItemModelCopyWith<$Res>  {
  factory $CheckoutItemModelCopyWith(CheckoutItemModel value, $Res Function(CheckoutItemModel) _then) = _$CheckoutItemModelCopyWithImpl;
@useResult
$Res call({
 String productId, String name, double price, int quantity, String imageUrl
});




}
/// @nodoc
class _$CheckoutItemModelCopyWithImpl<$Res>
    implements $CheckoutItemModelCopyWith<$Res> {
  _$CheckoutItemModelCopyWithImpl(this._self, this._then);

  final CheckoutItemModel _self;
  final $Res Function(CheckoutItemModel) _then;

/// Create a copy of CheckoutItemModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? name = null,Object? price = null,Object? quantity = null,Object? imageUrl = null,}) {
  return _then(_self.copyWith(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckoutItemModel].
extension CheckoutItemModelPatterns on CheckoutItemModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutItemModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutItemModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutItemModel value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutItemModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutItemModel value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutItemModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String productId,  String name,  double price,  int quantity,  String imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutItemModel() when $default != null:
return $default(_that.productId,_that.name,_that.price,_that.quantity,_that.imageUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String productId,  String name,  double price,  int quantity,  String imageUrl)  $default,) {final _that = this;
switch (_that) {
case _CheckoutItemModel():
return $default(_that.productId,_that.name,_that.price,_that.quantity,_that.imageUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String productId,  String name,  double price,  int quantity,  String imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutItemModel() when $default != null:
return $default(_that.productId,_that.name,_that.price,_that.quantity,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckoutItemModel implements CheckoutItemModel {
  const _CheckoutItemModel({required this.productId, required this.name, required this.price, required this.quantity, required this.imageUrl});
  factory _CheckoutItemModel.fromJson(Map<String, dynamic> json) => _$CheckoutItemModelFromJson(json);

@override final  String productId;
@override final  String name;
@override final  double price;
@override final  int quantity;
@override final  String imageUrl;

/// Create a copy of CheckoutItemModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutItemModelCopyWith<_CheckoutItemModel> get copyWith => __$CheckoutItemModelCopyWithImpl<_CheckoutItemModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckoutItemModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutItemModel&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,productId,name,price,quantity,imageUrl);

@override
String toString() {
  return 'CheckoutItemModel(productId: $productId, name: $name, price: $price, quantity: $quantity, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$CheckoutItemModelCopyWith<$Res> implements $CheckoutItemModelCopyWith<$Res> {
  factory _$CheckoutItemModelCopyWith(_CheckoutItemModel value, $Res Function(_CheckoutItemModel) _then) = __$CheckoutItemModelCopyWithImpl;
@override @useResult
$Res call({
 String productId, String name, double price, int quantity, String imageUrl
});




}
/// @nodoc
class __$CheckoutItemModelCopyWithImpl<$Res>
    implements _$CheckoutItemModelCopyWith<$Res> {
  __$CheckoutItemModelCopyWithImpl(this._self, this._then);

  final _CheckoutItemModel _self;
  final $Res Function(_CheckoutItemModel) _then;

/// Create a copy of CheckoutItemModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? name = null,Object? price = null,Object? quantity = null,Object? imageUrl = null,}) {
  return _then(_CheckoutItemModel(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
