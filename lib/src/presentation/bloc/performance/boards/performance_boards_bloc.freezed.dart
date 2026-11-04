// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'performance_boards_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PerformanceBoardsEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceBoardsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PerformanceBoardsEvent()';
}


}

/// @nodoc
class $PerformanceBoardsEventCopyWith<$Res>  {
$PerformanceBoardsEventCopyWith(PerformanceBoardsEvent _, $Res Function(PerformanceBoardsEvent) __);
}


/// Adds pattern-matching-related methods to [PerformanceBoardsEvent].
extension PerformanceBoardsEventPatterns on PerformanceBoardsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Load value)?  load,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _Reset() when reset != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Load value)  load,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _Load():
return load(_that);case _Reset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Load value)?  load,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _Reset() when reset != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  load,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load();case _Reset() when reset != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  load,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _Load():
return load();case _Reset():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  load,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load();case _Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _Load implements PerformanceBoardsEvent {
  const _Load();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Load);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PerformanceBoardsEvent.load()';
}


}




/// @nodoc


class _Reset implements PerformanceBoardsEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PerformanceBoardsEvent.reset()';
}


}




/// @nodoc
mixin _$PerformanceBoardsState {

 RequestState get state; List<PerformanceBoardEntry> get boards; String get message;
/// Create a copy of PerformanceBoardsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceBoardsStateCopyWith<PerformanceBoardsState> get copyWith => _$PerformanceBoardsStateCopyWithImpl<PerformanceBoardsState>(this as PerformanceBoardsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PerformanceBoardsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceBoardsState&&(identical(other.state, _this.state) || other.state == _this.state)&&const DeepCollectionEquality().equals(other.boards, _this.boards)&&(identical(other.message, _this.message) || other.message == _this.message));
}


@override
int get hashCode {
  final _this = this as PerformanceBoardsState;
  return Object.hash(runtimeType,_this.state,const DeepCollectionEquality().hash(_this.boards),_this.message);
}

@override
String toString() {
  final _this = this as PerformanceBoardsState;
  return 'PerformanceBoardsState(state: ${_this.state}, boards: ${_this.boards}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $PerformanceBoardsStateCopyWith<$Res>  {
  factory $PerformanceBoardsStateCopyWith(PerformanceBoardsState value, $Res Function(PerformanceBoardsState) _then) = _$PerformanceBoardsStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, List<PerformanceBoardEntry> boards, String message
});




}
/// @nodoc
class _$PerformanceBoardsStateCopyWithImpl<$Res>
    implements $PerformanceBoardsStateCopyWith<$Res> {
  _$PerformanceBoardsStateCopyWithImpl(this._self, this._then);

  final PerformanceBoardsState _self;
  final $Res Function(PerformanceBoardsState) _then;

/// Create a copy of PerformanceBoardsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? boards = null,Object? message = null,}) {
  return _then(PerformanceBoardsState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,boards: null == boards ? _self.boards : boards // ignore: cast_nullable_to_non_nullable
as List<PerformanceBoardEntry>,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PerformanceBoardsState].
extension PerformanceBoardsStatePatterns on PerformanceBoardsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PerformanceBoardsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PerformanceBoardsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PerformanceBoardsState value)  $default,){
final _that = this;
switch (_that) {
case _PerformanceBoardsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PerformanceBoardsState value)?  $default,){
final _that = this;
switch (_that) {
case _PerformanceBoardsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  List<PerformanceBoardEntry> boards,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PerformanceBoardsState() when $default != null:
return $default(_that.state,_that.boards,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  List<PerformanceBoardEntry> boards,  String message)  $default,) {final _that = this;
switch (_that) {
case _PerformanceBoardsState():
return $default(_that.state,_that.boards,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  List<PerformanceBoardEntry> boards,  String message)?  $default,) {final _that = this;
switch (_that) {
case _PerformanceBoardsState() when $default != null:
return $default(_that.state,_that.boards,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _PerformanceBoardsState extends PerformanceBoardsState {
  const _PerformanceBoardsState({this.state = RequestState.empty,  List<PerformanceBoardEntry> boards = const <PerformanceBoardEntry>[], this.message = ''}): _boards = boards,super._();
  

@override@JsonKey() final  RequestState state;
 final  List<PerformanceBoardEntry> _boards;
@override@JsonKey() List<PerformanceBoardEntry> get boards {
  if (_boards is EqualUnmodifiableListView) return _boards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_boards);
}

@override@JsonKey() final  String message;

/// Create a copy of PerformanceBoardsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PerformanceBoardsStateCopyWith<_PerformanceBoardsState> get copyWith => __$PerformanceBoardsStateCopyWithImpl<_PerformanceBoardsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PerformanceBoardsState&&(identical(other.state, state) || other.state == state)&&const DeepCollectionEquality().equals(other.boards, _boards)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state,const DeepCollectionEquality().hash(_boards),message);
}

@override
String toString() {
    return 'PerformanceBoardsState(state: $state, boards: $boards, message: $message)';
}


}

/// @nodoc
abstract mixin class _$PerformanceBoardsStateCopyWith<$Res> implements $PerformanceBoardsStateCopyWith<$Res> {
  factory _$PerformanceBoardsStateCopyWith(_PerformanceBoardsState value, $Res Function(_PerformanceBoardsState) _then) = __$PerformanceBoardsStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, List<PerformanceBoardEntry> boards, String message
});




}
/// @nodoc
class __$PerformanceBoardsStateCopyWithImpl<$Res>
    implements _$PerformanceBoardsStateCopyWith<$Res> {
  __$PerformanceBoardsStateCopyWithImpl(this._self, this._then);

  final _PerformanceBoardsState _self;
  final $Res Function(_PerformanceBoardsState) _then;

/// Create a copy of PerformanceBoardsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? boards = null,Object? message = null,}) {
  return _then(_PerformanceBoardsState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,boards: null == boards ? _self._boards : boards // ignore: cast_nullable_to_non_nullable
as List<PerformanceBoardEntry>,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
