// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_purchase_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommunityPurchaseEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityPurchaseEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CommunityPurchaseEvent()';
}


}

/// @nodoc
class $CommunityPurchaseEventCopyWith<$Res>  {
$CommunityPurchaseEventCopyWith(CommunityPurchaseEvent _, $Res Function(CommunityPurchaseEvent) __);
}


/// Adds pattern-matching-related methods to [CommunityPurchaseEvent].
extension CommunityPurchaseEventPatterns on CommunityPurchaseEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _Cleared value)?  cleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _Cleared() when cleared != null:
return cleared(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _Cleared value)  cleared,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _Cleared():
return cleared(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _Cleared value)?  cleared,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _Cleared() when cleared != null:
return cleared(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( CommunityModel community,  CommunityPlanModel plan)?  started,TResult Function()?  cleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.community,_that.plan);case _Cleared() when cleared != null:
return cleared();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( CommunityModel community,  CommunityPlanModel plan)  started,required TResult Function()  cleared,}) {final _that = this;
switch (_that) {
case _Started():
return started(_that.community,_that.plan);case _Cleared():
return cleared();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( CommunityModel community,  CommunityPlanModel plan)?  started,TResult? Function()?  cleared,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.community,_that.plan);case _Cleared() when cleared != null:
return cleared();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements CommunityPurchaseEvent {
  const _Started({required this.community, required this.plan});
  

 final  CommunityModel community;
 final  CommunityPlanModel plan;

/// Create a copy of CommunityPurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartedCopyWith<_Started> get copyWith => __$StartedCopyWithImpl<_Started>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started&&(identical(other.community, community) || other.community == community)&&(identical(other.plan, plan) || other.plan == plan));
}


@override
int get hashCode {
    return Object.hash(runtimeType,community,plan);
}

@override
String toString() {
    return 'CommunityPurchaseEvent.started(community: $community, plan: $plan)';
}


}

/// @nodoc
abstract mixin class _$StartedCopyWith<$Res> implements $CommunityPurchaseEventCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) _then) = __$StartedCopyWithImpl;
@useResult
$Res call({
 CommunityModel community, CommunityPlanModel plan
});




}
/// @nodoc
class __$StartedCopyWithImpl<$Res>
    implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(this._self, this._then);

  final _Started _self;
  final $Res Function(_Started) _then;

/// Create a copy of CommunityPurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? community = null,Object? plan = null,}) {
  return _then(_Started(
community: null == community ? _self.community : community // ignore: cast_nullable_to_non_nullable
as CommunityModel,plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as CommunityPlanModel,
  ));
}


}

/// @nodoc


class _Cleared implements CommunityPurchaseEvent {
  const _Cleared();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CommunityPurchaseEvent.cleared()';
}


}




/// @nodoc
mixin _$CommunityPurchaseState {

 CommunityModel? get community; CommunityPlanModel? get plan; String? get transactionId; DateTime? get paidAt; String? get paymentMethod;
/// Create a copy of CommunityPurchaseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityPurchaseStateCopyWith<CommunityPurchaseState> get copyWith => _$CommunityPurchaseStateCopyWithImpl<CommunityPurchaseState>(this as CommunityPurchaseState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CommunityPurchaseState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityPurchaseState&&(identical(other.community, _this.community) || other.community == _this.community)&&(identical(other.plan, _this.plan) || other.plan == _this.plan)&&(identical(other.transactionId, _this.transactionId) || other.transactionId == _this.transactionId)&&(identical(other.paidAt, _this.paidAt) || other.paidAt == _this.paidAt)&&(identical(other.paymentMethod, _this.paymentMethod) || other.paymentMethod == _this.paymentMethod));
}


@override
int get hashCode {
  final _this = this as CommunityPurchaseState;
  return Object.hash(runtimeType,_this.community,_this.plan,_this.transactionId,_this.paidAt,_this.paymentMethod);
}

@override
String toString() {
  final _this = this as CommunityPurchaseState;
  return 'CommunityPurchaseState(community: ${_this.community}, plan: ${_this.plan}, transactionId: ${_this.transactionId}, paidAt: ${_this.paidAt}, paymentMethod: ${_this.paymentMethod})';
}


}

/// @nodoc
abstract mixin class $CommunityPurchaseStateCopyWith<$Res>  {
  factory $CommunityPurchaseStateCopyWith(CommunityPurchaseState value, $Res Function(CommunityPurchaseState) _then) = _$CommunityPurchaseStateCopyWithImpl;
@useResult
$Res call({
 CommunityModel? community, CommunityPlanModel? plan, String? transactionId, DateTime? paidAt, String? paymentMethod
});




}
/// @nodoc
class _$CommunityPurchaseStateCopyWithImpl<$Res>
    implements $CommunityPurchaseStateCopyWith<$Res> {
  _$CommunityPurchaseStateCopyWithImpl(this._self, this._then);

  final CommunityPurchaseState _self;
  final $Res Function(CommunityPurchaseState) _then;

/// Create a copy of CommunityPurchaseState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? community = freezed,Object? plan = freezed,Object? transactionId = freezed,Object? paidAt = freezed,Object? paymentMethod = freezed,}) {
  return _then(CommunityPurchaseState(
community: freezed == community ? _self.community : community // ignore: cast_nullable_to_non_nullable
as CommunityModel?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as CommunityPlanModel?,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityPurchaseState].
extension CommunityPurchaseStatePatterns on CommunityPurchaseState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityPurchaseState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityPurchaseState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityPurchaseState value)  $default,){
final _that = this;
switch (_that) {
case _CommunityPurchaseState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityPurchaseState value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityPurchaseState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommunityModel? community,  CommunityPlanModel? plan,  String? transactionId,  DateTime? paidAt,  String? paymentMethod)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityPurchaseState() when $default != null:
return $default(_that.community,_that.plan,_that.transactionId,_that.paidAt,_that.paymentMethod);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommunityModel? community,  CommunityPlanModel? plan,  String? transactionId,  DateTime? paidAt,  String? paymentMethod)  $default,) {final _that = this;
switch (_that) {
case _CommunityPurchaseState():
return $default(_that.community,_that.plan,_that.transactionId,_that.paidAt,_that.paymentMethod);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommunityModel? community,  CommunityPlanModel? plan,  String? transactionId,  DateTime? paidAt,  String? paymentMethod)?  $default,) {final _that = this;
switch (_that) {
case _CommunityPurchaseState() when $default != null:
return $default(_that.community,_that.plan,_that.transactionId,_that.paidAt,_that.paymentMethod);case _:
  return null;

}
}

}

/// @nodoc


class _CommunityPurchaseState extends CommunityPurchaseState {
  const _CommunityPurchaseState({this.community, this.plan, this.transactionId, this.paidAt, this.paymentMethod}): super._();
  

@override final  CommunityModel? community;
@override final  CommunityPlanModel? plan;
@override final  String? transactionId;
@override final  DateTime? paidAt;
@override final  String? paymentMethod;

/// Create a copy of CommunityPurchaseState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityPurchaseStateCopyWith<_CommunityPurchaseState> get copyWith => __$CommunityPurchaseStateCopyWithImpl<_CommunityPurchaseState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityPurchaseState&&(identical(other.community, community) || other.community == community)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod));
}


@override
int get hashCode {
    return Object.hash(runtimeType,community,plan,transactionId,paidAt,paymentMethod);
}

@override
String toString() {
    return 'CommunityPurchaseState(community: $community, plan: $plan, transactionId: $transactionId, paidAt: $paidAt, paymentMethod: $paymentMethod)';
}


}

/// @nodoc
abstract mixin class _$CommunityPurchaseStateCopyWith<$Res> implements $CommunityPurchaseStateCopyWith<$Res> {
  factory _$CommunityPurchaseStateCopyWith(_CommunityPurchaseState value, $Res Function(_CommunityPurchaseState) _then) = __$CommunityPurchaseStateCopyWithImpl;
@override @useResult
$Res call({
 CommunityModel? community, CommunityPlanModel? plan, String? transactionId, DateTime? paidAt, String? paymentMethod
});




}
/// @nodoc
class __$CommunityPurchaseStateCopyWithImpl<$Res>
    implements _$CommunityPurchaseStateCopyWith<$Res> {
  __$CommunityPurchaseStateCopyWithImpl(this._self, this._then);

  final _CommunityPurchaseState _self;
  final $Res Function(_CommunityPurchaseState) _then;

/// Create a copy of CommunityPurchaseState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? community = freezed,Object? plan = freezed,Object? transactionId = freezed,Object? paidAt = freezed,Object? paymentMethod = freezed,}) {
  return _then(_CommunityPurchaseState(
community: freezed == community ? _self.community : community // ignore: cast_nullable_to_non_nullable
as CommunityModel?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as CommunityPlanModel?,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
