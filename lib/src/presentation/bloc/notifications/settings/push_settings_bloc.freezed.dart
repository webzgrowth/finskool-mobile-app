// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_settings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PushSettingsEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PushSettingsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PushSettingsEvent()';
}


}

/// @nodoc
class $PushSettingsEventCopyWith<$Res>  {
$PushSettingsEventCopyWith(PushSettingsEvent _, $Res Function(PushSettingsEvent) __);
}


/// Adds pattern-matching-related methods to [PushSettingsEvent].
extension PushSettingsEventPatterns on PushSettingsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Load value)?  load,TResult Function( _Toggled value)?  toggled,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _Toggled() when toggled != null:
return toggled(_that);case _Reset() when reset != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Load value)  load,required TResult Function( _Toggled value)  toggled,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _Load():
return load(_that);case _Toggled():
return toggled(_that);case _Reset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Load value)?  load,TResult? Function( _Toggled value)?  toggled,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _Toggled() when toggled != null:
return toggled(_that);case _Reset() when reset != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  load,TResult Function( bool enabled)?  toggled,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load();case _Toggled() when toggled != null:
return toggled(_that.enabled);case _Reset() when reset != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  load,required TResult Function( bool enabled)  toggled,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _Load():
return load();case _Toggled():
return toggled(_that.enabled);case _Reset():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  load,TResult? Function( bool enabled)?  toggled,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load();case _Toggled() when toggled != null:
return toggled(_that.enabled);case _Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _Load implements PushSettingsEvent {
  const _Load();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Load);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PushSettingsEvent.load()';
}


}




/// @nodoc


class _Toggled implements PushSettingsEvent {
  const _Toggled(this.enabled);
  

 final  bool enabled;

/// Create a copy of PushSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggledCopyWith<_Toggled> get copyWith => __$ToggledCopyWithImpl<_Toggled>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Toggled&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode {
    return Object.hash(runtimeType,enabled);
}

@override
String toString() {
    return 'PushSettingsEvent.toggled(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$ToggledCopyWith<$Res> implements $PushSettingsEventCopyWith<$Res> {
  factory _$ToggledCopyWith(_Toggled value, $Res Function(_Toggled) _then) = __$ToggledCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class __$ToggledCopyWithImpl<$Res>
    implements _$ToggledCopyWith<$Res> {
  __$ToggledCopyWithImpl(this._self, this._then);

  final _Toggled _self;
  final $Res Function(_Toggled) _then;

/// Create a copy of PushSettingsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(_Toggled(
null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _Reset implements PushSettingsEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PushSettingsEvent.reset()';
}


}




/// @nodoc
mixin _$PushSettingsState {

/// The master switch; `true` is the server's default until we hear back.
 bool get enabled; bool get saving; String get message;
/// Create a copy of PushSettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PushSettingsStateCopyWith<PushSettingsState> get copyWith => _$PushSettingsStateCopyWithImpl<PushSettingsState>(this as PushSettingsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PushSettingsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PushSettingsState&&(identical(other.enabled, _this.enabled) || other.enabled == _this.enabled)&&(identical(other.saving, _this.saving) || other.saving == _this.saving)&&(identical(other.message, _this.message) || other.message == _this.message));
}


@override
int get hashCode {
  final _this = this as PushSettingsState;
  return Object.hash(runtimeType,_this.enabled,_this.saving,_this.message);
}

@override
String toString() {
  final _this = this as PushSettingsState;
  return 'PushSettingsState(enabled: ${_this.enabled}, saving: ${_this.saving}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $PushSettingsStateCopyWith<$Res>  {
  factory $PushSettingsStateCopyWith(PushSettingsState value, $Res Function(PushSettingsState) _then) = _$PushSettingsStateCopyWithImpl;
@useResult
$Res call({
 bool enabled, bool saving, String message
});




}
/// @nodoc
class _$PushSettingsStateCopyWithImpl<$Res>
    implements $PushSettingsStateCopyWith<$Res> {
  _$PushSettingsStateCopyWithImpl(this._self, this._then);

  final PushSettingsState _self;
  final $Res Function(PushSettingsState) _then;

/// Create a copy of PushSettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? saving = null,Object? message = null,}) {
  return _then(PushSettingsState(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PushSettingsState].
extension PushSettingsStatePatterns on PushSettingsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PushSettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PushSettingsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PushSettingsState value)  $default,){
final _that = this;
switch (_that) {
case _PushSettingsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PushSettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _PushSettingsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  bool saving,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PushSettingsState() when $default != null:
return $default(_that.enabled,_that.saving,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  bool saving,  String message)  $default,) {final _that = this;
switch (_that) {
case _PushSettingsState():
return $default(_that.enabled,_that.saving,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  bool saving,  String message)?  $default,) {final _that = this;
switch (_that) {
case _PushSettingsState() when $default != null:
return $default(_that.enabled,_that.saving,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _PushSettingsState implements PushSettingsState {
  const _PushSettingsState({this.enabled = true, this.saving = false, this.message = ''});
  

/// The master switch; `true` is the server's default until we hear back.
@override@JsonKey() final  bool enabled;
@override@JsonKey() final  bool saving;
@override@JsonKey() final  String message;

/// Create a copy of PushSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PushSettingsStateCopyWith<_PushSettingsState> get copyWith => __$PushSettingsStateCopyWithImpl<_PushSettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PushSettingsState&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,enabled,saving,message);
}

@override
String toString() {
    return 'PushSettingsState(enabled: $enabled, saving: $saving, message: $message)';
}


}

/// @nodoc
abstract mixin class _$PushSettingsStateCopyWith<$Res> implements $PushSettingsStateCopyWith<$Res> {
  factory _$PushSettingsStateCopyWith(_PushSettingsState value, $Res Function(_PushSettingsState) _then) = __$PushSettingsStateCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, bool saving, String message
});




}
/// @nodoc
class __$PushSettingsStateCopyWithImpl<$Res>
    implements _$PushSettingsStateCopyWith<$Res> {
  __$PushSettingsStateCopyWithImpl(this._self, this._then);

  final _PushSettingsState _self;
  final $Res Function(_PushSettingsState) _then;

/// Create a copy of PushSettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? saving = null,Object? message = null,}) {
  return _then(_PushSettingsState(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
