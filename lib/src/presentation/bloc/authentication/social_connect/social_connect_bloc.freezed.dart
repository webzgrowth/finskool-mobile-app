// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_connect_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SocialConnectEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialConnectEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SocialConnectEvent()';
}


}

/// @nodoc
class $SocialConnectEventCopyWith<$Res>  {
$SocialConnectEventCopyWith(SocialConnectEvent _, $Res Function(SocialConnectEvent) __);
}


/// Adds pattern-matching-related methods to [SocialConnectEvent].
extension SocialConnectEventPatterns on SocialConnectEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Requested value)?  requested,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Requested() when requested != null:
return requested(_that);case _Reset() when reset != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Requested value)  requested,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _Requested():
return requested(_that);case _Reset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Requested value)?  requested,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _Requested() when requested != null:
return requested(_that);case _Reset() when reset != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( SocialProvider provider)?  requested,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Requested() when requested != null:
return requested(_that.provider);case _Reset() when reset != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( SocialProvider provider)  requested,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _Requested():
return requested(_that.provider);case _Reset():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( SocialProvider provider)?  requested,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _Requested() when requested != null:
return requested(_that.provider);case _Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _Requested implements SocialConnectEvent {
  const _Requested(this.provider);
  

 final  SocialProvider provider;

/// Create a copy of SocialConnectEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestedCopyWith<_Requested> get copyWith => __$RequestedCopyWithImpl<_Requested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Requested&&(identical(other.provider, provider) || other.provider == provider));
}


@override
int get hashCode {
    return Object.hash(runtimeType,provider);
}

@override
String toString() {
    return 'SocialConnectEvent.requested(provider: $provider)';
}


}

/// @nodoc
abstract mixin class _$RequestedCopyWith<$Res> implements $SocialConnectEventCopyWith<$Res> {
  factory _$RequestedCopyWith(_Requested value, $Res Function(_Requested) _then) = __$RequestedCopyWithImpl;
@useResult
$Res call({
 SocialProvider provider
});




}
/// @nodoc
class __$RequestedCopyWithImpl<$Res>
    implements _$RequestedCopyWith<$Res> {
  __$RequestedCopyWithImpl(this._self, this._then);

  final _Requested _self;
  final $Res Function(_Requested) _then;

/// Create a copy of SocialConnectEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? provider = null,}) {
  return _then(_Requested(
null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as SocialProvider,
  ));
}


}

/// @nodoc


class _Reset implements SocialConnectEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SocialConnectEvent.reset()';
}


}




/// @nodoc
mixin _$SocialConnectState {

 RequestState get state;/// The server's words for a failure (`SOCIAL_ALREADY_LINKED`,
/// `SOCIAL_PROVIDER_ALREADY_LINKED`, `SOCIAL_TOKEN_INVALID`…), verbatim.
 String get message;/// Which row is busy — only that Connect button shows a spinner.
 SocialProvider? get provider;
/// Create a copy of SocialConnectState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialConnectStateCopyWith<SocialConnectState> get copyWith => _$SocialConnectStateCopyWithImpl<SocialConnectState>(this as SocialConnectState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SocialConnectState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialConnectState&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.provider, _this.provider) || other.provider == _this.provider));
}


@override
int get hashCode {
  final _this = this as SocialConnectState;
  return Object.hash(runtimeType,_this.state,_this.message,_this.provider);
}

@override
String toString() {
  final _this = this as SocialConnectState;
  return 'SocialConnectState(state: ${_this.state}, message: ${_this.message}, provider: ${_this.provider})';
}


}

/// @nodoc
abstract mixin class $SocialConnectStateCopyWith<$Res>  {
  factory $SocialConnectStateCopyWith(SocialConnectState value, $Res Function(SocialConnectState) _then) = _$SocialConnectStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, String message, SocialProvider? provider
});




}
/// @nodoc
class _$SocialConnectStateCopyWithImpl<$Res>
    implements $SocialConnectStateCopyWith<$Res> {
  _$SocialConnectStateCopyWithImpl(this._self, this._then);

  final SocialConnectState _self;
  final $Res Function(SocialConnectState) _then;

/// Create a copy of SocialConnectState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? message = null,Object? provider = freezed,}) {
  return _then(SocialConnectState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as SocialProvider?,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialConnectState].
extension SocialConnectStatePatterns on SocialConnectState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialConnectState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialConnectState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialConnectState value)  $default,){
final _that = this;
switch (_that) {
case _SocialConnectState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialConnectState value)?  $default,){
final _that = this;
switch (_that) {
case _SocialConnectState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  String message,  SocialProvider? provider)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialConnectState() when $default != null:
return $default(_that.state,_that.message,_that.provider);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  String message,  SocialProvider? provider)  $default,) {final _that = this;
switch (_that) {
case _SocialConnectState():
return $default(_that.state,_that.message,_that.provider);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  String message,  SocialProvider? provider)?  $default,) {final _that = this;
switch (_that) {
case _SocialConnectState() when $default != null:
return $default(_that.state,_that.message,_that.provider);case _:
  return null;

}
}

}

/// @nodoc


class _SocialConnectState implements SocialConnectState {
  const _SocialConnectState({this.state = RequestState.empty, this.message = '', this.provider});
  

@override@JsonKey() final  RequestState state;
/// The server's words for a failure (`SOCIAL_ALREADY_LINKED`,
/// `SOCIAL_PROVIDER_ALREADY_LINKED`, `SOCIAL_TOKEN_INVALID`…), verbatim.
@override@JsonKey() final  String message;
/// Which row is busy — only that Connect button shows a spinner.
@override final  SocialProvider? provider;

/// Create a copy of SocialConnectState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialConnectStateCopyWith<_SocialConnectState> get copyWith => __$SocialConnectStateCopyWithImpl<_SocialConnectState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialConnectState&&(identical(other.state, state) || other.state == state)&&(identical(other.message, message) || other.message == message)&&(identical(other.provider, provider) || other.provider == provider));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state,message,provider);
}

@override
String toString() {
    return 'SocialConnectState(state: $state, message: $message, provider: $provider)';
}


}

/// @nodoc
abstract mixin class _$SocialConnectStateCopyWith<$Res> implements $SocialConnectStateCopyWith<$Res> {
  factory _$SocialConnectStateCopyWith(_SocialConnectState value, $Res Function(_SocialConnectState) _then) = __$SocialConnectStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, String message, SocialProvider? provider
});




}
/// @nodoc
class __$SocialConnectStateCopyWithImpl<$Res>
    implements _$SocialConnectStateCopyWith<$Res> {
  __$SocialConnectStateCopyWithImpl(this._self, this._then);

  final _SocialConnectState _self;
  final $Res Function(_SocialConnectState) _then;

/// Create a copy of SocialConnectState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? message = null,Object? provider = freezed,}) {
  return _then(_SocialConnectState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as SocialProvider?,
  ));
}


}

// dart format on
