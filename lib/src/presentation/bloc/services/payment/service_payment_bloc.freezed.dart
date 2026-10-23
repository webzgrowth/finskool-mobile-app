// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_payment_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServicePaymentEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicePaymentEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServicePaymentEvent()';
}


}

/// @nodoc
class $ServicePaymentEventCopyWith<$Res>  {
$ServicePaymentEventCopyWith(ServicePaymentEvent _, $Res Function(ServicePaymentEvent) __);
}


/// Adds pattern-matching-related methods to [ServicePaymentEvent].
extension ServicePaymentEventPatterns on ServicePaymentEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _StatesRequested value)?  statesRequested,TResult Function( _PayTapped value)?  payTapped,TResult Function( _CheckoutSucceeded value)?  checkoutSucceeded,TResult Function( _CheckoutFailed value)?  checkoutFailed,TResult Function( _CheckoutDismissed value)?  checkoutDismissed,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatesRequested() when statesRequested != null:
return statesRequested(_that);case _PayTapped() when payTapped != null:
return payTapped(_that);case _CheckoutSucceeded() when checkoutSucceeded != null:
return checkoutSucceeded(_that);case _CheckoutFailed() when checkoutFailed != null:
return checkoutFailed(_that);case _CheckoutDismissed() when checkoutDismissed != null:
return checkoutDismissed(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _StatesRequested value)  statesRequested,required TResult Function( _PayTapped value)  payTapped,required TResult Function( _CheckoutSucceeded value)  checkoutSucceeded,required TResult Function( _CheckoutFailed value)  checkoutFailed,required TResult Function( _CheckoutDismissed value)  checkoutDismissed,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _StatesRequested():
return statesRequested(_that);case _PayTapped():
return payTapped(_that);case _CheckoutSucceeded():
return checkoutSucceeded(_that);case _CheckoutFailed():
return checkoutFailed(_that);case _CheckoutDismissed():
return checkoutDismissed(_that);case _Reset():
return reset(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _StatesRequested value)?  statesRequested,TResult? Function( _PayTapped value)?  payTapped,TResult? Function( _CheckoutSucceeded value)?  checkoutSucceeded,TResult? Function( _CheckoutFailed value)?  checkoutFailed,TResult? Function( _CheckoutDismissed value)?  checkoutDismissed,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _StatesRequested() when statesRequested != null:
return statesRequested(_that);case _PayTapped() when payTapped != null:
return payTapped(_that);case _CheckoutSucceeded() when checkoutSucceeded != null:
return checkoutSucceeded(_that);case _CheckoutFailed() when checkoutFailed != null:
return checkoutFailed(_that);case _CheckoutDismissed() when checkoutDismissed != null:
return checkoutDismissed(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  statesRequested,TResult Function( String requestId,  ServiceQuoteModel quote,  BillingDetails billing)?  payTapped,TResult Function( PaymentProof proof)?  checkoutSucceeded,TResult Function( String message)?  checkoutFailed,TResult Function()?  checkoutDismissed,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatesRequested() when statesRequested != null:
return statesRequested();case _PayTapped() when payTapped != null:
return payTapped(_that.requestId,_that.quote,_that.billing);case _CheckoutSucceeded() when checkoutSucceeded != null:
return checkoutSucceeded(_that.proof);case _CheckoutFailed() when checkoutFailed != null:
return checkoutFailed(_that.message);case _CheckoutDismissed() when checkoutDismissed != null:
return checkoutDismissed();case _Reset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  statesRequested,required TResult Function( String requestId,  ServiceQuoteModel quote,  BillingDetails billing)  payTapped,required TResult Function( PaymentProof proof)  checkoutSucceeded,required TResult Function( String message)  checkoutFailed,required TResult Function()  checkoutDismissed,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _StatesRequested():
return statesRequested();case _PayTapped():
return payTapped(_that.requestId,_that.quote,_that.billing);case _CheckoutSucceeded():
return checkoutSucceeded(_that.proof);case _CheckoutFailed():
return checkoutFailed(_that.message);case _CheckoutDismissed():
return checkoutDismissed();case _Reset():
return reset();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  statesRequested,TResult? Function( String requestId,  ServiceQuoteModel quote,  BillingDetails billing)?  payTapped,TResult? Function( PaymentProof proof)?  checkoutSucceeded,TResult? Function( String message)?  checkoutFailed,TResult? Function()?  checkoutDismissed,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _StatesRequested() when statesRequested != null:
return statesRequested();case _PayTapped() when payTapped != null:
return payTapped(_that.requestId,_that.quote,_that.billing);case _CheckoutSucceeded() when checkoutSucceeded != null:
return checkoutSucceeded(_that.proof);case _CheckoutFailed() when checkoutFailed != null:
return checkoutFailed(_that.message);case _CheckoutDismissed() when checkoutDismissed != null:
return checkoutDismissed();case _Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _StatesRequested implements ServicePaymentEvent {
  const _StatesRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatesRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServicePaymentEvent.statesRequested()';
}


}




/// @nodoc


class _PayTapped implements ServicePaymentEvent {
  const _PayTapped({required this.requestId, required this.quote, required this.billing});
  

 final  String requestId;
 final  ServiceQuoteModel quote;
 final  BillingDetails billing;

/// Create a copy of ServicePaymentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayTappedCopyWith<_PayTapped> get copyWith => __$PayTappedCopyWithImpl<_PayTapped>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PayTapped&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.quote, quote) || other.quote == quote)&&(identical(other.billing, billing) || other.billing == billing));
}


@override
int get hashCode {
    return Object.hash(runtimeType,requestId,quote,billing);
}

@override
String toString() {
    return 'ServicePaymentEvent.payTapped(requestId: $requestId, quote: $quote, billing: $billing)';
}


}

/// @nodoc
abstract mixin class _$PayTappedCopyWith<$Res> implements $ServicePaymentEventCopyWith<$Res> {
  factory _$PayTappedCopyWith(_PayTapped value, $Res Function(_PayTapped) _then) = __$PayTappedCopyWithImpl;
@useResult
$Res call({
 String requestId, ServiceQuoteModel quote, BillingDetails billing
});




}
/// @nodoc
class __$PayTappedCopyWithImpl<$Res>
    implements _$PayTappedCopyWith<$Res> {
  __$PayTappedCopyWithImpl(this._self, this._then);

  final _PayTapped _self;
  final $Res Function(_PayTapped) _then;

/// Create a copy of ServicePaymentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? requestId = null,Object? quote = null,Object? billing = null,}) {
  return _then(_PayTapped(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,quote: null == quote ? _self.quote : quote // ignore: cast_nullable_to_non_nullable
as ServiceQuoteModel,billing: null == billing ? _self.billing : billing // ignore: cast_nullable_to_non_nullable
as BillingDetails,
  ));
}


}

/// @nodoc


class _CheckoutSucceeded implements ServicePaymentEvent {
  const _CheckoutSucceeded(this.proof);
  

 final  PaymentProof proof;

/// Create a copy of ServicePaymentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutSucceededCopyWith<_CheckoutSucceeded> get copyWith => __$CheckoutSucceededCopyWithImpl<_CheckoutSucceeded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutSucceeded&&(identical(other.proof, proof) || other.proof == proof));
}


@override
int get hashCode {
    return Object.hash(runtimeType,proof);
}

@override
String toString() {
    return 'ServicePaymentEvent.checkoutSucceeded(proof: $proof)';
}


}

/// @nodoc
abstract mixin class _$CheckoutSucceededCopyWith<$Res> implements $ServicePaymentEventCopyWith<$Res> {
  factory _$CheckoutSucceededCopyWith(_CheckoutSucceeded value, $Res Function(_CheckoutSucceeded) _then) = __$CheckoutSucceededCopyWithImpl;
@useResult
$Res call({
 PaymentProof proof
});




}
/// @nodoc
class __$CheckoutSucceededCopyWithImpl<$Res>
    implements _$CheckoutSucceededCopyWith<$Res> {
  __$CheckoutSucceededCopyWithImpl(this._self, this._then);

  final _CheckoutSucceeded _self;
  final $Res Function(_CheckoutSucceeded) _then;

/// Create a copy of ServicePaymentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? proof = null,}) {
  return _then(_CheckoutSucceeded(
null == proof ? _self.proof : proof // ignore: cast_nullable_to_non_nullable
as PaymentProof,
  ));
}


}

/// @nodoc


class _CheckoutFailed implements ServicePaymentEvent {
  const _CheckoutFailed(this.message);
  

 final  String message;

/// Create a copy of ServicePaymentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutFailedCopyWith<_CheckoutFailed> get copyWith => __$CheckoutFailedCopyWithImpl<_CheckoutFailed>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'ServicePaymentEvent.checkoutFailed(message: $message)';
}


}

/// @nodoc
abstract mixin class _$CheckoutFailedCopyWith<$Res> implements $ServicePaymentEventCopyWith<$Res> {
  factory _$CheckoutFailedCopyWith(_CheckoutFailed value, $Res Function(_CheckoutFailed) _then) = __$CheckoutFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$CheckoutFailedCopyWithImpl<$Res>
    implements _$CheckoutFailedCopyWith<$Res> {
  __$CheckoutFailedCopyWithImpl(this._self, this._then);

  final _CheckoutFailed _self;
  final $Res Function(_CheckoutFailed) _then;

/// Create a copy of ServicePaymentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_CheckoutFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CheckoutDismissed implements ServicePaymentEvent {
  const _CheckoutDismissed();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutDismissed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServicePaymentEvent.checkoutDismissed()';
}


}




/// @nodoc


class _Reset implements ServicePaymentEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServicePaymentEvent.reset()';
}


}




/// @nodoc
mixin _$ServicePaymentState {

 PaymentStep get step; RequestState get statesLoad; List<GstState> get states; String get message; Map<String, String> get billingErrors;/// The quote was replaced, expired or already paid while the sheet was
/// open — the chat should refetch so the card says so.
 bool get staleQuote; PaymentOrder? get order; PaymentProof? get pendingProof;/// The request as the server now has it: `paid`, with its invoice.
 ServiceRequestModel? get paid;
/// Create a copy of ServicePaymentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServicePaymentStateCopyWith<ServicePaymentState> get copyWith => _$ServicePaymentStateCopyWithImpl<ServicePaymentState>(this as ServicePaymentState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ServicePaymentState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicePaymentState&&(identical(other.step, _this.step) || other.step == _this.step)&&(identical(other.statesLoad, _this.statesLoad) || other.statesLoad == _this.statesLoad)&&const DeepCollectionEquality().equals(other.states, _this.states)&&(identical(other.message, _this.message) || other.message == _this.message)&&const DeepCollectionEquality().equals(other.billingErrors, _this.billingErrors)&&(identical(other.staleQuote, _this.staleQuote) || other.staleQuote == _this.staleQuote)&&(identical(other.order, _this.order) || other.order == _this.order)&&(identical(other.pendingProof, _this.pendingProof) || other.pendingProof == _this.pendingProof)&&(identical(other.paid, _this.paid) || other.paid == _this.paid));
}


@override
int get hashCode {
  final _this = this as ServicePaymentState;
  return Object.hash(runtimeType,_this.step,_this.statesLoad,const DeepCollectionEquality().hash(_this.states),_this.message,const DeepCollectionEquality().hash(_this.billingErrors),_this.staleQuote,_this.order,_this.pendingProof,_this.paid);
}

@override
String toString() {
  final _this = this as ServicePaymentState;
  return 'ServicePaymentState(step: ${_this.step}, statesLoad: ${_this.statesLoad}, states: ${_this.states}, message: ${_this.message}, billingErrors: ${_this.billingErrors}, staleQuote: ${_this.staleQuote}, order: ${_this.order}, pendingProof: ${_this.pendingProof}, paid: ${_this.paid})';
}


}

/// @nodoc
abstract mixin class $ServicePaymentStateCopyWith<$Res>  {
  factory $ServicePaymentStateCopyWith(ServicePaymentState value, $Res Function(ServicePaymentState) _then) = _$ServicePaymentStateCopyWithImpl;
@useResult
$Res call({
 PaymentStep step, RequestState statesLoad, List<GstState> states, String message, Map<String, String> billingErrors, bool staleQuote, PaymentOrder? order, PaymentProof? pendingProof, ServiceRequestModel? paid
});




}
/// @nodoc
class _$ServicePaymentStateCopyWithImpl<$Res>
    implements $ServicePaymentStateCopyWith<$Res> {
  _$ServicePaymentStateCopyWithImpl(this._self, this._then);

  final ServicePaymentState _self;
  final $Res Function(ServicePaymentState) _then;

/// Create a copy of ServicePaymentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? statesLoad = null,Object? states = null,Object? message = null,Object? billingErrors = null,Object? staleQuote = null,Object? order = freezed,Object? pendingProof = freezed,Object? paid = freezed,}) {
  return _then(ServicePaymentState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as PaymentStep,statesLoad: null == statesLoad ? _self.statesLoad : statesLoad // ignore: cast_nullable_to_non_nullable
as RequestState,states: null == states ? _self.states : states // ignore: cast_nullable_to_non_nullable
as List<GstState>,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,billingErrors: null == billingErrors ? _self.billingErrors : billingErrors // ignore: cast_nullable_to_non_nullable
as Map<String, String>,staleQuote: null == staleQuote ? _self.staleQuote : staleQuote // ignore: cast_nullable_to_non_nullable
as bool,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as PaymentOrder?,pendingProof: freezed == pendingProof ? _self.pendingProof : pendingProof // ignore: cast_nullable_to_non_nullable
as PaymentProof?,paid: freezed == paid ? _self.paid : paid // ignore: cast_nullable_to_non_nullable
as ServiceRequestModel?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServicePaymentState].
extension ServicePaymentStatePatterns on ServicePaymentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServicePaymentState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServicePaymentState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServicePaymentState value)  $default,){
final _that = this;
switch (_that) {
case _ServicePaymentState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServicePaymentState value)?  $default,){
final _that = this;
switch (_that) {
case _ServicePaymentState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PaymentStep step,  RequestState statesLoad,  List<GstState> states,  String message,  Map<String, String> billingErrors,  bool staleQuote,  PaymentOrder? order,  PaymentProof? pendingProof,  ServiceRequestModel? paid)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServicePaymentState() when $default != null:
return $default(_that.step,_that.statesLoad,_that.states,_that.message,_that.billingErrors,_that.staleQuote,_that.order,_that.pendingProof,_that.paid);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PaymentStep step,  RequestState statesLoad,  List<GstState> states,  String message,  Map<String, String> billingErrors,  bool staleQuote,  PaymentOrder? order,  PaymentProof? pendingProof,  ServiceRequestModel? paid)  $default,) {final _that = this;
switch (_that) {
case _ServicePaymentState():
return $default(_that.step,_that.statesLoad,_that.states,_that.message,_that.billingErrors,_that.staleQuote,_that.order,_that.pendingProof,_that.paid);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PaymentStep step,  RequestState statesLoad,  List<GstState> states,  String message,  Map<String, String> billingErrors,  bool staleQuote,  PaymentOrder? order,  PaymentProof? pendingProof,  ServiceRequestModel? paid)?  $default,) {final _that = this;
switch (_that) {
case _ServicePaymentState() when $default != null:
return $default(_that.step,_that.statesLoad,_that.states,_that.message,_that.billingErrors,_that.staleQuote,_that.order,_that.pendingProof,_that.paid);case _:
  return null;

}
}

}

/// @nodoc


class _ServicePaymentState implements ServicePaymentState {
  const _ServicePaymentState({required this.step, required this.statesLoad, required  List<GstState> states, required this.message, required  Map<String, String> billingErrors, required this.staleQuote, this.order, this.pendingProof, this.paid}): _states = states,_billingErrors = billingErrors;
  

@override final  PaymentStep step;
@override final  RequestState statesLoad;
 final  List<GstState> _states;
@override List<GstState> get states {
  if (_states is EqualUnmodifiableListView) return _states;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_states);
}

@override final  String message;
 final  Map<String, String> _billingErrors;
@override Map<String, String> get billingErrors {
  if (_billingErrors is EqualUnmodifiableMapView) return _billingErrors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_billingErrors);
}

/// The quote was replaced, expired or already paid while the sheet was
/// open — the chat should refetch so the card says so.
@override final  bool staleQuote;
@override final  PaymentOrder? order;
@override final  PaymentProof? pendingProof;
/// The request as the server now has it: `paid`, with its invoice.
@override final  ServiceRequestModel? paid;

/// Create a copy of ServicePaymentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServicePaymentStateCopyWith<_ServicePaymentState> get copyWith => __$ServicePaymentStateCopyWithImpl<_ServicePaymentState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServicePaymentState&&(identical(other.step, step) || other.step == step)&&(identical(other.statesLoad, statesLoad) || other.statesLoad == statesLoad)&&const DeepCollectionEquality().equals(other.states, _states)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.billingErrors, _billingErrors)&&(identical(other.staleQuote, staleQuote) || other.staleQuote == staleQuote)&&(identical(other.order, order) || other.order == order)&&(identical(other.pendingProof, pendingProof) || other.pendingProof == pendingProof)&&(identical(other.paid, paid) || other.paid == paid));
}


@override
int get hashCode {
    return Object.hash(runtimeType,step,statesLoad,const DeepCollectionEquality().hash(_states),message,const DeepCollectionEquality().hash(_billingErrors),staleQuote,order,pendingProof,paid);
}

@override
String toString() {
    return 'ServicePaymentState(step: $step, statesLoad: $statesLoad, states: $states, message: $message, billingErrors: $billingErrors, staleQuote: $staleQuote, order: $order, pendingProof: $pendingProof, paid: $paid)';
}


}

/// @nodoc
abstract mixin class _$ServicePaymentStateCopyWith<$Res> implements $ServicePaymentStateCopyWith<$Res> {
  factory _$ServicePaymentStateCopyWith(_ServicePaymentState value, $Res Function(_ServicePaymentState) _then) = __$ServicePaymentStateCopyWithImpl;
@override @useResult
$Res call({
 PaymentStep step, RequestState statesLoad, List<GstState> states, String message, Map<String, String> billingErrors, bool staleQuote, PaymentOrder? order, PaymentProof? pendingProof, ServiceRequestModel? paid
});




}
/// @nodoc
class __$ServicePaymentStateCopyWithImpl<$Res>
    implements _$ServicePaymentStateCopyWith<$Res> {
  __$ServicePaymentStateCopyWithImpl(this._self, this._then);

  final _ServicePaymentState _self;
  final $Res Function(_ServicePaymentState) _then;

/// Create a copy of ServicePaymentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? statesLoad = null,Object? states = null,Object? message = null,Object? billingErrors = null,Object? staleQuote = null,Object? order = freezed,Object? pendingProof = freezed,Object? paid = freezed,}) {
  return _then(_ServicePaymentState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as PaymentStep,statesLoad: null == statesLoad ? _self.statesLoad : statesLoad // ignore: cast_nullable_to_non_nullable
as RequestState,states: null == states ? _self._states : states // ignore: cast_nullable_to_non_nullable
as List<GstState>,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,billingErrors: null == billingErrors ? _self._billingErrors : billingErrors // ignore: cast_nullable_to_non_nullable
as Map<String, String>,staleQuote: null == staleQuote ? _self.staleQuote : staleQuote // ignore: cast_nullable_to_non_nullable
as bool,order: freezed == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as PaymentOrder?,pendingProof: freezed == pendingProof ? _self.pendingProof : pendingProof // ignore: cast_nullable_to_non_nullable
as PaymentProof?,paid: freezed == paid ? _self.paid : paid // ignore: cast_nullable_to_non_nullable
as ServiceRequestModel?,
  ));
}


}

// dart format on
