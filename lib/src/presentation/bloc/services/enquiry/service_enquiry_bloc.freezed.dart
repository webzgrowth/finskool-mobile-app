// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_enquiry_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServiceEnquiryEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceEnquiryEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServiceEnquiryEvent()';
}


}

/// @nodoc
class $ServiceEnquiryEventCopyWith<$Res>  {
$ServiceEnquiryEventCopyWith(ServiceEnquiryEvent _, $Res Function(ServiceEnquiryEvent) __);
}


/// Adds pattern-matching-related methods to [ServiceEnquiryEvent].
extension ServiceEnquiryEventPatterns on ServiceEnquiryEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Submitted value)?  submitted,TResult Function( _Dismissed value)?  dismissed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Submitted() when submitted != null:
return submitted(_that);case _Dismissed() when dismissed != null:
return dismissed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Submitted value)  submitted,required TResult Function( _Dismissed value)  dismissed,}){
final _that = this;
switch (_that) {
case _Submitted():
return submitted(_that);case _Dismissed():
return dismissed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Submitted value)?  submitted,TResult? Function( _Dismissed value)?  dismissed,}){
final _that = this;
switch (_that) {
case _Submitted() when submitted != null:
return submitted(_that);case _Dismissed() when dismissed != null:
return dismissed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ServiceModel service)?  submitted,TResult Function()?  dismissed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Submitted() when submitted != null:
return submitted(_that.service);case _Dismissed() when dismissed != null:
return dismissed();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ServiceModel service)  submitted,required TResult Function()  dismissed,}) {final _that = this;
switch (_that) {
case _Submitted():
return submitted(_that.service);case _Dismissed():
return dismissed();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ServiceModel service)?  submitted,TResult? Function()?  dismissed,}) {final _that = this;
switch (_that) {
case _Submitted() when submitted != null:
return submitted(_that.service);case _Dismissed() when dismissed != null:
return dismissed();case _:
  return null;

}
}

}

/// @nodoc


class _Submitted implements ServiceEnquiryEvent {
  const _Submitted(this.service);
  

 final  ServiceModel service;

/// Create a copy of ServiceEnquiryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmittedCopyWith<_Submitted> get copyWith => __$SubmittedCopyWithImpl<_Submitted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submitted&&(identical(other.service, service) || other.service == service));
}


@override
int get hashCode {
    return Object.hash(runtimeType,service);
}

@override
String toString() {
    return 'ServiceEnquiryEvent.submitted(service: $service)';
}


}

/// @nodoc
abstract mixin class _$SubmittedCopyWith<$Res> implements $ServiceEnquiryEventCopyWith<$Res> {
  factory _$SubmittedCopyWith(_Submitted value, $Res Function(_Submitted) _then) = __$SubmittedCopyWithImpl;
@useResult
$Res call({
 ServiceModel service
});




}
/// @nodoc
class __$SubmittedCopyWithImpl<$Res>
    implements _$SubmittedCopyWith<$Res> {
  __$SubmittedCopyWithImpl(this._self, this._then);

  final _Submitted _self;
  final $Res Function(_Submitted) _then;

/// Create a copy of ServiceEnquiryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? service = null,}) {
  return _then(_Submitted(
null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as ServiceModel,
  ));
}


}

/// @nodoc


class _Dismissed implements ServiceEnquiryEvent {
  const _Dismissed();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Dismissed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServiceEnquiryEvent.dismissed()';
}


}




/// @nodoc
mixin _$ServiceEnquiryState {

 RequestState get submit; String get message;/// True when the request is one the member **already had** open, found
/// after a 409 — the popup then says so instead of "submitted".
 bool get existing; ServiceRequestModel? get request;
/// Create a copy of ServiceEnquiryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceEnquiryStateCopyWith<ServiceEnquiryState> get copyWith => _$ServiceEnquiryStateCopyWithImpl<ServiceEnquiryState>(this as ServiceEnquiryState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ServiceEnquiryState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceEnquiryState&&(identical(other.submit, _this.submit) || other.submit == _this.submit)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.existing, _this.existing) || other.existing == _this.existing)&&(identical(other.request, _this.request) || other.request == _this.request));
}


@override
int get hashCode {
  final _this = this as ServiceEnquiryState;
  return Object.hash(runtimeType,_this.submit,_this.message,_this.existing,_this.request);
}

@override
String toString() {
  final _this = this as ServiceEnquiryState;
  return 'ServiceEnquiryState(submit: ${_this.submit}, message: ${_this.message}, existing: ${_this.existing}, request: ${_this.request})';
}


}

/// @nodoc
abstract mixin class $ServiceEnquiryStateCopyWith<$Res>  {
  factory $ServiceEnquiryStateCopyWith(ServiceEnquiryState value, $Res Function(ServiceEnquiryState) _then) = _$ServiceEnquiryStateCopyWithImpl;
@useResult
$Res call({
 RequestState submit, String message, bool existing, ServiceRequestModel? request
});




}
/// @nodoc
class _$ServiceEnquiryStateCopyWithImpl<$Res>
    implements $ServiceEnquiryStateCopyWith<$Res> {
  _$ServiceEnquiryStateCopyWithImpl(this._self, this._then);

  final ServiceEnquiryState _self;
  final $Res Function(ServiceEnquiryState) _then;

/// Create a copy of ServiceEnquiryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? submit = null,Object? message = null,Object? existing = null,Object? request = freezed,}) {
  return _then(ServiceEnquiryState(
submit: null == submit ? _self.submit : submit // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,existing: null == existing ? _self.existing : existing // ignore: cast_nullable_to_non_nullable
as bool,request: freezed == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as ServiceRequestModel?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceEnquiryState].
extension ServiceEnquiryStatePatterns on ServiceEnquiryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceEnquiryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceEnquiryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceEnquiryState value)  $default,){
final _that = this;
switch (_that) {
case _ServiceEnquiryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceEnquiryState value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceEnquiryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState submit,  String message,  bool existing,  ServiceRequestModel? request)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceEnquiryState() when $default != null:
return $default(_that.submit,_that.message,_that.existing,_that.request);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState submit,  String message,  bool existing,  ServiceRequestModel? request)  $default,) {final _that = this;
switch (_that) {
case _ServiceEnquiryState():
return $default(_that.submit,_that.message,_that.existing,_that.request);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState submit,  String message,  bool existing,  ServiceRequestModel? request)?  $default,) {final _that = this;
switch (_that) {
case _ServiceEnquiryState() when $default != null:
return $default(_that.submit,_that.message,_that.existing,_that.request);case _:
  return null;

}
}

}

/// @nodoc


class _ServiceEnquiryState implements ServiceEnquiryState {
  const _ServiceEnquiryState({required this.submit, required this.message, required this.existing, this.request});
  

@override final  RequestState submit;
@override final  String message;
/// True when the request is one the member **already had** open, found
/// after a 409 — the popup then says so instead of "submitted".
@override final  bool existing;
@override final  ServiceRequestModel? request;

/// Create a copy of ServiceEnquiryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceEnquiryStateCopyWith<_ServiceEnquiryState> get copyWith => __$ServiceEnquiryStateCopyWithImpl<_ServiceEnquiryState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceEnquiryState&&(identical(other.submit, submit) || other.submit == submit)&&(identical(other.message, message) || other.message == message)&&(identical(other.existing, existing) || other.existing == existing)&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode {
    return Object.hash(runtimeType,submit,message,existing,request);
}

@override
String toString() {
    return 'ServiceEnquiryState(submit: $submit, message: $message, existing: $existing, request: $request)';
}


}

/// @nodoc
abstract mixin class _$ServiceEnquiryStateCopyWith<$Res> implements $ServiceEnquiryStateCopyWith<$Res> {
  factory _$ServiceEnquiryStateCopyWith(_ServiceEnquiryState value, $Res Function(_ServiceEnquiryState) _then) = __$ServiceEnquiryStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState submit, String message, bool existing, ServiceRequestModel? request
});




}
/// @nodoc
class __$ServiceEnquiryStateCopyWithImpl<$Res>
    implements _$ServiceEnquiryStateCopyWith<$Res> {
  __$ServiceEnquiryStateCopyWithImpl(this._self, this._then);

  final _ServiceEnquiryState _self;
  final $Res Function(_ServiceEnquiryState) _then;

/// Create a copy of ServiceEnquiryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? submit = null,Object? message = null,Object? existing = null,Object? request = freezed,}) {
  return _then(_ServiceEnquiryState(
submit: null == submit ? _self.submit : submit // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,existing: null == existing ? _self.existing : existing // ignore: cast_nullable_to_non_nullable
as bool,request: freezed == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as ServiceRequestModel?,
  ));
}


}

// dart format on
