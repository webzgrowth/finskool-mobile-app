// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'google_signin_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GoogleSigninEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is GoogleSigninEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'GoogleSigninEvent()';
}


}

/// @nodoc
class $GoogleSigninEventCopyWith<$Res>  {
$GoogleSigninEventCopyWith(GoogleSigninEvent _, $Res Function(GoogleSigninEvent) __);
}


/// Adds pattern-matching-related methods to [GoogleSigninEvent].
extension GoogleSigninEventPatterns on GoogleSigninEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Signin value)?  signin,TResult Function( _Initial value)?  initial,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Signin() when signin != null:
return signin(_that);case _Initial() when initial != null:
return initial(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Signin value)  signin,required TResult Function( _Initial value)  initial,}){
final _that = this;
switch (_that) {
case _Signin():
return signin(_that);case _Initial():
return initial(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Signin value)?  signin,TResult? Function( _Initial value)?  initial,}){
final _that = this;
switch (_that) {
case _Signin() when signin != null:
return signin(_that);case _Initial() when initial != null:
return initial(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  signin,TResult Function()?  initial,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Signin() when signin != null:
return signin();case _Initial() when initial != null:
return initial();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  signin,required TResult Function()  initial,}) {final _that = this;
switch (_that) {
case _Signin():
return signin();case _Initial():
return initial();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  signin,TResult? Function()?  initial,}) {final _that = this;
switch (_that) {
case _Signin() when signin != null:
return signin();case _Initial() when initial != null:
return initial();case _:
  return null;

}
}

}

/// @nodoc


class _Signin implements GoogleSigninEvent {
  const _Signin();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Signin);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'GoogleSigninEvent.signin()';
}


}




/// @nodoc


class _Initial implements GoogleSigninEvent {
  const _Initial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'GoogleSigninEvent.initial()';
}


}




/// @nodoc
mixin _$GoogleSigninState {

 RequestState get requestState; String get message; AuthFlow get authFlow; String? get email;
/// Create a copy of GoogleSigninState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoogleSigninStateCopyWith<GoogleSigninState> get copyWith => _$GoogleSigninStateCopyWithImpl<GoogleSigninState>(this as GoogleSigninState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GoogleSigninState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoogleSigninState&&(identical(other.requestState, _this.requestState) || other.requestState == _this.requestState)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.authFlow, _this.authFlow) || other.authFlow == _this.authFlow)&&(identical(other.email, _this.email) || other.email == _this.email));
}


@override
int get hashCode {
  final _this = this as GoogleSigninState;
  return Object.hash(runtimeType,_this.requestState,_this.message,_this.authFlow,_this.email);
}

@override
String toString() {
  final _this = this as GoogleSigninState;
  return 'GoogleSigninState(requestState: ${_this.requestState}, message: ${_this.message}, authFlow: ${_this.authFlow}, email: ${_this.email})';
}


}

/// @nodoc
abstract mixin class $GoogleSigninStateCopyWith<$Res>  {
  factory $GoogleSigninStateCopyWith(GoogleSigninState value, $Res Function(GoogleSigninState) _then) = _$GoogleSigninStateCopyWithImpl;
@useResult
$Res call({
 RequestState requestState, String message, AuthFlow authFlow, String? email
});




}
/// @nodoc
class _$GoogleSigninStateCopyWithImpl<$Res>
    implements $GoogleSigninStateCopyWith<$Res> {
  _$GoogleSigninStateCopyWithImpl(this._self, this._then);

  final GoogleSigninState _self;
  final $Res Function(GoogleSigninState) _then;

/// Create a copy of GoogleSigninState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requestState = null,Object? message = null,Object? authFlow = null,Object? email = freezed,}) {
  return _then(GoogleSigninState(
requestState: null == requestState ? _self.requestState : requestState // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,authFlow: null == authFlow ? _self.authFlow : authFlow // ignore: cast_nullable_to_non_nullable
as AuthFlow,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GoogleSigninState].
extension GoogleSigninStatePatterns on GoogleSigninState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoogleSigninState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoogleSigninState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoogleSigninState value)  $default,){
final _that = this;
switch (_that) {
case _GoogleSigninState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoogleSigninState value)?  $default,){
final _that = this;
switch (_that) {
case _GoogleSigninState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState requestState,  String message,  AuthFlow authFlow,  String? email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoogleSigninState() when $default != null:
return $default(_that.requestState,_that.message,_that.authFlow,_that.email);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState requestState,  String message,  AuthFlow authFlow,  String? email)  $default,) {final _that = this;
switch (_that) {
case _GoogleSigninState():
return $default(_that.requestState,_that.message,_that.authFlow,_that.email);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState requestState,  String message,  AuthFlow authFlow,  String? email)?  $default,) {final _that = this;
switch (_that) {
case _GoogleSigninState() when $default != null:
return $default(_that.requestState,_that.message,_that.authFlow,_that.email);case _:
  return null;

}
}

}

/// @nodoc


class _GoogleSigninState implements GoogleSigninState {
  const _GoogleSigninState({required this.requestState, required this.message, required this.authFlow, required this.email});
  

@override final  RequestState requestState;
@override final  String message;
@override final  AuthFlow authFlow;
@override final  String? email;

/// Create a copy of GoogleSigninState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoogleSigninStateCopyWith<_GoogleSigninState> get copyWith => __$GoogleSigninStateCopyWithImpl<_GoogleSigninState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoogleSigninState&&(identical(other.requestState, requestState) || other.requestState == requestState)&&(identical(other.message, message) || other.message == message)&&(identical(other.authFlow, authFlow) || other.authFlow == authFlow)&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode {
    return Object.hash(runtimeType,requestState,message,authFlow,email);
}

@override
String toString() {
    return 'GoogleSigninState(requestState: $requestState, message: $message, authFlow: $authFlow, email: $email)';
}


}

/// @nodoc
abstract mixin class _$GoogleSigninStateCopyWith<$Res> implements $GoogleSigninStateCopyWith<$Res> {
  factory _$GoogleSigninStateCopyWith(_GoogleSigninState value, $Res Function(_GoogleSigninState) _then) = __$GoogleSigninStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState requestState, String message, AuthFlow authFlow, String? email
});




}
/// @nodoc
class __$GoogleSigninStateCopyWithImpl<$Res>
    implements _$GoogleSigninStateCopyWith<$Res> {
  __$GoogleSigninStateCopyWithImpl(this._self, this._then);

  final _GoogleSigninState _self;
  final $Res Function(_GoogleSigninState) _then;

/// Create a copy of GoogleSigninState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requestState = null,Object? message = null,Object? authFlow = null,Object? email = freezed,}) {
  return _then(_GoogleSigninState(
requestState: null == requestState ? _self.requestState : requestState // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,authFlow: null == authFlow ? _self.authFlow : authFlow // ignore: cast_nullable_to_non_nullable
as AuthFlow,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
