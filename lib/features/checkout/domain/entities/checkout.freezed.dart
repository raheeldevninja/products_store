// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Checkout {

 String get id; String get userId; double get total; String get currency; String get status;// e.g. pending, success, failed
 DateTime get createdAt; List<CheckoutItem> get items;
/// Create a copy of Checkout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutCopyWith<Checkout> get copyWith => _$CheckoutCopyWithImpl<Checkout>(this as Checkout, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Checkout&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.total, total) || other.total == total)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,total,currency,status,createdAt,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'Checkout(id: $id, userId: $userId, total: $total, currency: $currency, status: $status, createdAt: $createdAt, items: $items)';
}


}

/// @nodoc
abstract mixin class $CheckoutCopyWith<$Res>  {
  factory $CheckoutCopyWith(Checkout value, $Res Function(Checkout) _then) = _$CheckoutCopyWithImpl;
@useResult
$Res call({
 String id, String userId, double total, String currency, String status, DateTime createdAt, List<CheckoutItem> items
});




}
/// @nodoc
class _$CheckoutCopyWithImpl<$Res>
    implements $CheckoutCopyWith<$Res> {
  _$CheckoutCopyWithImpl(this._self, this._then);

  final Checkout _self;
  final $Res Function(Checkout) _then;

/// Create a copy of Checkout
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
as List<CheckoutItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [Checkout].
extension CheckoutPatterns on Checkout {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Checkout value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Checkout() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Checkout value)  $default,){
final _that = this;
switch (_that) {
case _Checkout():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Checkout value)?  $default,){
final _that = this;
switch (_that) {
case _Checkout() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  double total,  String currency,  String status,  DateTime createdAt,  List<CheckoutItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Checkout() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  double total,  String currency,  String status,  DateTime createdAt,  List<CheckoutItem> items)  $default,) {final _that = this;
switch (_that) {
case _Checkout():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  double total,  String currency,  String status,  DateTime createdAt,  List<CheckoutItem> items)?  $default,) {final _that = this;
switch (_that) {
case _Checkout() when $default != null:
return $default(_that.id,_that.userId,_that.total,_that.currency,_that.status,_that.createdAt,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _Checkout implements Checkout {
  const _Checkout({required this.id, required this.userId, required this.total, required this.currency, required this.status, required this.createdAt, required final  List<CheckoutItem> items}): _items = items;
  

@override final  String id;
@override final  String userId;
@override final  double total;
@override final  String currency;
@override final  String status;
// e.g. pending, success, failed
@override final  DateTime createdAt;
 final  List<CheckoutItem> _items;
@override List<CheckoutItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of Checkout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutCopyWith<_Checkout> get copyWith => __$CheckoutCopyWithImpl<_Checkout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Checkout&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.total, total) || other.total == total)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,total,currency,status,createdAt,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'Checkout(id: $id, userId: $userId, total: $total, currency: $currency, status: $status, createdAt: $createdAt, items: $items)';
}


}

/// @nodoc
abstract mixin class _$CheckoutCopyWith<$Res> implements $CheckoutCopyWith<$Res> {
  factory _$CheckoutCopyWith(_Checkout value, $Res Function(_Checkout) _then) = __$CheckoutCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, double total, String currency, String status, DateTime createdAt, List<CheckoutItem> items
});




}
/// @nodoc
class __$CheckoutCopyWithImpl<$Res>
    implements _$CheckoutCopyWith<$Res> {
  __$CheckoutCopyWithImpl(this._self, this._then);

  final _Checkout _self;
  final $Res Function(_Checkout) _then;

/// Create a copy of Checkout
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? total = null,Object? currency = null,Object? status = null,Object? createdAt = null,Object? items = null,}) {
  return _then(_Checkout(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CheckoutItem>,
  ));
}


}

/// @nodoc
mixin _$CheckoutItem {

 String get productId; String get name; double get price; int get quantity; String get imageUrl;
/// Create a copy of CheckoutItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutItemCopyWith<CheckoutItem> get copyWith => _$CheckoutItemCopyWithImpl<CheckoutItem>(this as CheckoutItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutItem&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,productId,name,price,quantity,imageUrl);

@override
String toString() {
  return 'CheckoutItem(productId: $productId, name: $name, price: $price, quantity: $quantity, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $CheckoutItemCopyWith<$Res>  {
  factory $CheckoutItemCopyWith(CheckoutItem value, $Res Function(CheckoutItem) _then) = _$CheckoutItemCopyWithImpl;
@useResult
$Res call({
 String productId, String name, double price, int quantity, String imageUrl
});




}
/// @nodoc
class _$CheckoutItemCopyWithImpl<$Res>
    implements $CheckoutItemCopyWith<$Res> {
  _$CheckoutItemCopyWithImpl(this._self, this._then);

  final CheckoutItem _self;
  final $Res Function(CheckoutItem) _then;

/// Create a copy of CheckoutItem
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


/// Adds pattern-matching-related methods to [CheckoutItem].
extension CheckoutItemPatterns on CheckoutItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutItem value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutItem value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutItem() when $default != null:
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
case _CheckoutItem() when $default != null:
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
case _CheckoutItem():
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
case _CheckoutItem() when $default != null:
return $default(_that.productId,_that.name,_that.price,_that.quantity,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc


class _CheckoutItem implements CheckoutItem {
  const _CheckoutItem({required this.productId, required this.name, required this.price, required this.quantity, required this.imageUrl});
  

@override final  String productId;
@override final  String name;
@override final  double price;
@override final  int quantity;
@override final  String imageUrl;

/// Create a copy of CheckoutItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutItemCopyWith<_CheckoutItem> get copyWith => __$CheckoutItemCopyWithImpl<_CheckoutItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutItem&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.name, name) || other.name == name)&&(identical(other.price, price) || other.price == price)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,productId,name,price,quantity,imageUrl);

@override
String toString() {
  return 'CheckoutItem(productId: $productId, name: $name, price: $price, quantity: $quantity, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$CheckoutItemCopyWith<$Res> implements $CheckoutItemCopyWith<$Res> {
  factory _$CheckoutItemCopyWith(_CheckoutItem value, $Res Function(_CheckoutItem) _then) = __$CheckoutItemCopyWithImpl;
@override @useResult
$Res call({
 String productId, String name, double price, int quantity, String imageUrl
});




}
/// @nodoc
class __$CheckoutItemCopyWithImpl<$Res>
    implements _$CheckoutItemCopyWith<$Res> {
  __$CheckoutItemCopyWithImpl(this._self, this._then);

  final _CheckoutItem _self;
  final $Res Function(_CheckoutItem) _then;

/// Create a copy of CheckoutItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? name = null,Object? price = null,Object? quantity = null,Object? imageUrl = null,}) {
  return _then(_CheckoutItem(
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
