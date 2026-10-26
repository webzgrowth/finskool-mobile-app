// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'welcome_kit_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WelcomeKitEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is WelcomeKitEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'WelcomeKitEvent()';
}


}

/// @nodoc
class $WelcomeKitEventCopyWith<$Res>  {
$WelcomeKitEventCopyWith(WelcomeKitEvent _, $Res Function(WelcomeKitEvent) __);
}


/// Adds pattern-matching-related methods to [WelcomeKitEvent].
extension WelcomeKitEventPatterns on WelcomeKitEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Load value)?  load,TResult Function( _Retried value)?  retried,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _Retried() when retried != null:
return retried(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Load value)  load,required TResult Function( _Retried value)  retried,}){
final _that = this;
switch (_that) {
case _Load():
return load(_that);case _Retried():
return retried(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Load value)?  load,TResult? Function( _Retried value)?  retried,}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _Retried() when retried != null:
return retried(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String communityId)?  load,TResult Function()?  retried,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.communityId);case _Retried() when retried != null:
return retried();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String communityId)  load,required TResult Function()  retried,}) {final _that = this;
switch (_that) {
case _Load():
return load(_that.communityId);case _Retried():
return retried();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String communityId)?  load,TResult? Function()?  retried,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.communityId);case _Retried() when retried != null:
return retried();case _:
  return null;

}
}

}

/// @nodoc


class _Load implements WelcomeKitEvent {
  const _Load(this.communityId);
  

 final  String communityId;

/// Create a copy of WelcomeKitEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadCopyWith<_Load> get copyWith => __$LoadCopyWithImpl<_Load>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Load&&(identical(other.communityId, communityId) || other.communityId == communityId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,communityId);
}

@override
String toString() {
    return 'WelcomeKitEvent.load(communityId: $communityId)';
}


}

/// @nodoc
abstract mixin class _$LoadCopyWith<$Res> implements $WelcomeKitEventCopyWith<$Res> {
  factory _$LoadCopyWith(_Load value, $Res Function(_Load) _then) = __$LoadCopyWithImpl;
@useResult
$Res call({
 String communityId
});




}
/// @nodoc
class __$LoadCopyWithImpl<$Res>
    implements _$LoadCopyWith<$Res> {
  __$LoadCopyWithImpl(this._self, this._then);

  final _Load _self;
  final $Res Function(_Load) _then;

/// Create a copy of WelcomeKitEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,}) {
  return _then(_Load(
null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Retried implements WelcomeKitEvent {
  const _Retried();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Retried);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'WelcomeKitEvent.retried()';
}


}




/// @nodoc
mixin _$WelcomeKitState {

 RequestState get state; String get message; String get communityId; WelcomeKit? get kit;
/// Create a copy of WelcomeKitState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WelcomeKitStateCopyWith<WelcomeKitState> get copyWith => _$WelcomeKitStateCopyWithImpl<WelcomeKitState>(this as WelcomeKitState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as WelcomeKitState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WelcomeKitState&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.communityId, _this.communityId) || other.communityId == _this.communityId)&&(identical(other.kit, _this.kit) || other.kit == _this.kit));
}


@override
int get hashCode {
  final _this = this as WelcomeKitState;
  return Object.hash(runtimeType,_this.state,_this.message,_this.communityId,_this.kit);
}

@override
String toString() {
  final _this = this as WelcomeKitState;
  return 'WelcomeKitState(state: ${_this.state}, message: ${_this.message}, communityId: ${_this.communityId}, kit: ${_this.kit})';
}


}

/// @nodoc
abstract mixin class $WelcomeKitStateCopyWith<$Res>  {
  factory $WelcomeKitStateCopyWith(WelcomeKitState value, $Res Function(WelcomeKitState) _then) = _$WelcomeKitStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, String message, String communityId, WelcomeKit? kit
});




}
/// @nodoc
class _$WelcomeKitStateCopyWithImpl<$Res>
    implements $WelcomeKitStateCopyWith<$Res> {
  _$WelcomeKitStateCopyWithImpl(this._self, this._then);

  final WelcomeKitState _self;
  final $Res Function(WelcomeKitState) _then;

/// Create a copy of WelcomeKitState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? message = null,Object? communityId = null,Object? kit = freezed,}) {
  return _then(WelcomeKitState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,kit: freezed == kit ? _self.kit : kit // ignore: cast_nullable_to_non_nullable
as WelcomeKit?,
  ));
}

}


/// Adds pattern-matching-related methods to [WelcomeKitState].
extension WelcomeKitStatePatterns on WelcomeKitState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WelcomeKitState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WelcomeKitState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WelcomeKitState value)  $default,){
final _that = this;
switch (_that) {
case _WelcomeKitState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WelcomeKitState value)?  $default,){
final _that = this;
switch (_that) {
case _WelcomeKitState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  String message,  String communityId,  WelcomeKit? kit)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WelcomeKitState() when $default != null:
return $default(_that.state,_that.message,_that.communityId,_that.kit);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  String message,  String communityId,  WelcomeKit? kit)  $default,) {final _that = this;
switch (_that) {
case _WelcomeKitState():
return $default(_that.state,_that.message,_that.communityId,_that.kit);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  String message,  String communityId,  WelcomeKit? kit)?  $default,) {final _that = this;
switch (_that) {
case _WelcomeKitState() when $default != null:
return $default(_that.state,_that.message,_that.communityId,_that.kit);case _:
  return null;

}
}

}

/// @nodoc


class _WelcomeKitState implements WelcomeKitState {
  const _WelcomeKitState({required this.state, required this.message, required this.communityId, this.kit});
  

@override final  RequestState state;
@override final  String message;
@override final  String communityId;
@override final  WelcomeKit? kit;

/// Create a copy of WelcomeKitState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WelcomeKitStateCopyWith<_WelcomeKitState> get copyWith => __$WelcomeKitStateCopyWithImpl<_WelcomeKitState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WelcomeKitState&&(identical(other.state, state) || other.state == state)&&(identical(other.message, message) || other.message == message)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.kit, kit) || other.kit == kit));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state,message,communityId,kit);
}

@override
String toString() {
    return 'WelcomeKitState(state: $state, message: $message, communityId: $communityId, kit: $kit)';
}


}

/// @nodoc
abstract mixin class _$WelcomeKitStateCopyWith<$Res> implements $WelcomeKitStateCopyWith<$Res> {
  factory _$WelcomeKitStateCopyWith(_WelcomeKitState value, $Res Function(_WelcomeKitState) _then) = __$WelcomeKitStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, String message, String communityId, WelcomeKit? kit
});




}
/// @nodoc
class __$WelcomeKitStateCopyWithImpl<$Res>
    implements _$WelcomeKitStateCopyWith<$Res> {
  __$WelcomeKitStateCopyWithImpl(this._self, this._then);

  final _WelcomeKitState _self;
  final $Res Function(_WelcomeKitState) _then;

/// Create a copy of WelcomeKitState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? message = null,Object? communityId = null,Object? kit = freezed,}) {
  return _then(_WelcomeKitState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,kit: freezed == kit ? _self.kit : kit // ignore: cast_nullable_to_non_nullable
as WelcomeKit?,
  ));
}


}

// dart format on
