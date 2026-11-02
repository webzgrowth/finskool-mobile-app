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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _PaymentReported value)?  paymentReported,TResult Function( _CheckoutDismissed value)?  checkoutDismissed,TResult Function( _Recheck value)?  recheck,TResult Function( _Cleared value)?  cleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _PaymentReported() when paymentReported != null:
return paymentReported(_that);case _CheckoutDismissed() when checkoutDismissed != null:
return checkoutDismissed(_that);case _Recheck() when recheck != null:
return recheck(_that);case _Cleared() when cleared != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _PaymentReported value)  paymentReported,required TResult Function( _CheckoutDismissed value)  checkoutDismissed,required TResult Function( _Recheck value)  recheck,required TResult Function( _Cleared value)  cleared,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _PaymentReported():
return paymentReported(_that);case _CheckoutDismissed():
return checkoutDismissed(_that);case _Recheck():
return recheck(_that);case _Cleared():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _PaymentReported value)?  paymentReported,TResult? Function( _CheckoutDismissed value)?  checkoutDismissed,TResult? Function( _Recheck value)?  recheck,TResult? Function( _Cleared value)?  cleared,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _PaymentReported() when paymentReported != null:
return paymentReported(_that);case _CheckoutDismissed() when checkoutDismissed != null:
return checkoutDismissed(_that);case _Recheck() when recheck != null:
return recheck(_that);case _Cleared() when cleared != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( CommunityModel community,  CommunityPlanModel plan)?  started,TResult Function( PaymentOutcome outcome)?  paymentReported,TResult Function()?  checkoutDismissed,TResult Function()?  recheck,TResult Function()?  cleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.community,_that.plan);case _PaymentReported() when paymentReported != null:
return paymentReported(_that.outcome);case _CheckoutDismissed() when checkoutDismissed != null:
return checkoutDismissed();case _Recheck() when recheck != null:
return recheck();case _Cleared() when cleared != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( CommunityModel community,  CommunityPlanModel plan)  started,required TResult Function( PaymentOutcome outcome)  paymentReported,required TResult Function()  checkoutDismissed,required TResult Function()  recheck,required TResult Function()  cleared,}) {final _that = this;
switch (_that) {
case _Started():
return started(_that.community,_that.plan);case _PaymentReported():
return paymentReported(_that.outcome);case _CheckoutDismissed():
return checkoutDismissed();case _Recheck():
return recheck();case _Cleared():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( CommunityModel community,  CommunityPlanModel plan)?  started,TResult? Function( PaymentOutcome outcome)?  paymentReported,TResult? Function()?  checkoutDismissed,TResult? Function()?  recheck,TResult? Function()?  cleared,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.community,_that.plan);case _PaymentReported() when paymentReported != null:
return paymentReported(_that.outcome);case _CheckoutDismissed() when checkoutDismissed != null:
return checkoutDismissed();case _Recheck() when recheck != null:
return recheck();case _Cleared() when cleared != null:
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


class _PaymentReported implements CommunityPurchaseEvent {
  const _PaymentReported(this.outcome);
  

 final  PaymentOutcome outcome;

/// Create a copy of CommunityPurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentReportedCopyWith<_PaymentReported> get copyWith => __$PaymentReportedCopyWithImpl<_PaymentReported>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentReported&&(identical(other.outcome, outcome) || other.outcome == outcome));
}


@override
int get hashCode {
    return Object.hash(runtimeType,outcome);
}

@override
String toString() {
    return 'CommunityPurchaseEvent.paymentReported(outcome: $outcome)';
}


}

/// @nodoc
abstract mixin class _$PaymentReportedCopyWith<$Res> implements $CommunityPurchaseEventCopyWith<$Res> {
  factory _$PaymentReportedCopyWith(_PaymentReported value, $Res Function(_PaymentReported) _then) = __$PaymentReportedCopyWithImpl;
@useResult
$Res call({
 PaymentOutcome outcome
});




}
/// @nodoc
class __$PaymentReportedCopyWithImpl<$Res>
    implements _$PaymentReportedCopyWith<$Res> {
  __$PaymentReportedCopyWithImpl(this._self, this._then);

  final _PaymentReported _self;
  final $Res Function(_PaymentReported) _then;

/// Create a copy of CommunityPurchaseEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? outcome = null,}) {
  return _then(_PaymentReported(
null == outcome ? _self.outcome : outcome // ignore: cast_nullable_to_non_nullable
as PaymentOutcome,
  ));
}


}

/// @nodoc


class _CheckoutDismissed implements CommunityPurchaseEvent {
  const _CheckoutDismissed();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutDismissed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CommunityPurchaseEvent.checkoutDismissed()';
}


}




/// @nodoc


class _Recheck implements CommunityPurchaseEvent {
  const _Recheck();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Recheck);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CommunityPurchaseEvent.recheck()';
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

 CommunityModel? get community; CommunityPlanModel? get plan; PurchaseStatus get status;/// Handed to the webview and nowhere else. Holds a single-use token, so it
/// is never logged, persisted or put in a route.
 String? get checkoutUrl; String get message;/// Access end *before* this purchase — a renewal is only confirmed once
/// `/me` reports a later date than this.
 DateTime? get previousExpiry; DateTime? get expiresAt; DateTime? get paidAt;
/// Create a copy of CommunityPurchaseState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityPurchaseStateCopyWith<CommunityPurchaseState> get copyWith => _$CommunityPurchaseStateCopyWithImpl<CommunityPurchaseState>(this as CommunityPurchaseState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CommunityPurchaseState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityPurchaseState&&(identical(other.community, _this.community) || other.community == _this.community)&&(identical(other.plan, _this.plan) || other.plan == _this.plan)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.checkoutUrl, _this.checkoutUrl) || other.checkoutUrl == _this.checkoutUrl)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.previousExpiry, _this.previousExpiry) || other.previousExpiry == _this.previousExpiry)&&(identical(other.expiresAt, _this.expiresAt) || other.expiresAt == _this.expiresAt)&&(identical(other.paidAt, _this.paidAt) || other.paidAt == _this.paidAt));
}


@override
int get hashCode {
  final _this = this as CommunityPurchaseState;
  return Object.hash(runtimeType,_this.community,_this.plan,_this.status,_this.checkoutUrl,_this.message,_this.previousExpiry,_this.expiresAt,_this.paidAt);
}

@override
String toString() {
  final _this = this as CommunityPurchaseState;
  return 'CommunityPurchaseState(community: ${_this.community}, plan: ${_this.plan}, status: ${_this.status}, checkoutUrl: ${_this.checkoutUrl}, message: ${_this.message}, previousExpiry: ${_this.previousExpiry}, expiresAt: ${_this.expiresAt}, paidAt: ${_this.paidAt})';
}


}

/// @nodoc
abstract mixin class $CommunityPurchaseStateCopyWith<$Res>  {
  factory $CommunityPurchaseStateCopyWith(CommunityPurchaseState value, $Res Function(CommunityPurchaseState) _then) = _$CommunityPurchaseStateCopyWithImpl;
@useResult
$Res call({
 CommunityModel? community, CommunityPlanModel? plan, PurchaseStatus status, String? checkoutUrl, String message, DateTime? previousExpiry, DateTime? expiresAt, DateTime? paidAt
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
@pragma('vm:prefer-inline') @override $Res call({Object? community = freezed,Object? plan = freezed,Object? status = null,Object? checkoutUrl = freezed,Object? message = null,Object? previousExpiry = freezed,Object? expiresAt = freezed,Object? paidAt = freezed,}) {
  return _then(CommunityPurchaseState(
community: freezed == community ? _self.community : community // ignore: cast_nullable_to_non_nullable
as CommunityModel?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as CommunityPlanModel?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PurchaseStatus,checkoutUrl: freezed == checkoutUrl ? _self.checkoutUrl : checkoutUrl // ignore: cast_nullable_to_non_nullable
as String?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,previousExpiry: freezed == previousExpiry ? _self.previousExpiry : previousExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CommunityModel? community,  CommunityPlanModel? plan,  PurchaseStatus status,  String? checkoutUrl,  String message,  DateTime? previousExpiry,  DateTime? expiresAt,  DateTime? paidAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityPurchaseState() when $default != null:
return $default(_that.community,_that.plan,_that.status,_that.checkoutUrl,_that.message,_that.previousExpiry,_that.expiresAt,_that.paidAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CommunityModel? community,  CommunityPlanModel? plan,  PurchaseStatus status,  String? checkoutUrl,  String message,  DateTime? previousExpiry,  DateTime? expiresAt,  DateTime? paidAt)  $default,) {final _that = this;
switch (_that) {
case _CommunityPurchaseState():
return $default(_that.community,_that.plan,_that.status,_that.checkoutUrl,_that.message,_that.previousExpiry,_that.expiresAt,_that.paidAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CommunityModel? community,  CommunityPlanModel? plan,  PurchaseStatus status,  String? checkoutUrl,  String message,  DateTime? previousExpiry,  DateTime? expiresAt,  DateTime? paidAt)?  $default,) {final _that = this;
switch (_that) {
case _CommunityPurchaseState() when $default != null:
return $default(_that.community,_that.plan,_that.status,_that.checkoutUrl,_that.message,_that.previousExpiry,_that.expiresAt,_that.paidAt);case _:
  return null;

}
}

}

/// @nodoc


class _CommunityPurchaseState extends CommunityPurchaseState {
  const _CommunityPurchaseState({this.community, this.plan, this.status = PurchaseStatus.idle, this.checkoutUrl, this.message = '', this.previousExpiry, this.expiresAt, this.paidAt}): super._();
  

@override final  CommunityModel? community;
@override final  CommunityPlanModel? plan;
@override@JsonKey() final  PurchaseStatus status;
/// Handed to the webview and nowhere else. Holds a single-use token, so it
/// is never logged, persisted or put in a route.
@override final  String? checkoutUrl;
@override@JsonKey() final  String message;
/// Access end *before* this purchase — a renewal is only confirmed once
/// `/me` reports a later date than this.
@override final  DateTime? previousExpiry;
@override final  DateTime? expiresAt;
@override final  DateTime? paidAt;

/// Create a copy of CommunityPurchaseState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityPurchaseStateCopyWith<_CommunityPurchaseState> get copyWith => __$CommunityPurchaseStateCopyWithImpl<_CommunityPurchaseState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityPurchaseState&&(identical(other.community, community) || other.community == community)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.status, status) || other.status == status)&&(identical(other.checkoutUrl, checkoutUrl) || other.checkoutUrl == checkoutUrl)&&(identical(other.message, message) || other.message == message)&&(identical(other.previousExpiry, previousExpiry) || other.previousExpiry == previousExpiry)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,community,plan,status,checkoutUrl,message,previousExpiry,expiresAt,paidAt);
}

@override
String toString() {
    return 'CommunityPurchaseState(community: $community, plan: $plan, status: $status, checkoutUrl: $checkoutUrl, message: $message, previousExpiry: $previousExpiry, expiresAt: $expiresAt, paidAt: $paidAt)';
}


}

/// @nodoc
abstract mixin class _$CommunityPurchaseStateCopyWith<$Res> implements $CommunityPurchaseStateCopyWith<$Res> {
  factory _$CommunityPurchaseStateCopyWith(_CommunityPurchaseState value, $Res Function(_CommunityPurchaseState) _then) = __$CommunityPurchaseStateCopyWithImpl;
@override @useResult
$Res call({
 CommunityModel? community, CommunityPlanModel? plan, PurchaseStatus status, String? checkoutUrl, String message, DateTime? previousExpiry, DateTime? expiresAt, DateTime? paidAt
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
@override @pragma('vm:prefer-inline') $Res call({Object? community = freezed,Object? plan = freezed,Object? status = null,Object? checkoutUrl = freezed,Object? message = null,Object? previousExpiry = freezed,Object? expiresAt = freezed,Object? paidAt = freezed,}) {
  return _then(_CommunityPurchaseState(
community: freezed == community ? _self.community : community // ignore: cast_nullable_to_non_nullable
as CommunityModel?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as CommunityPlanModel?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PurchaseStatus,checkoutUrl: freezed == checkoutUrl ? _self.checkoutUrl : checkoutUrl // ignore: cast_nullable_to_non_nullable
as String?,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,previousExpiry: freezed == previousExpiry ? _self.previousExpiry : previousExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
