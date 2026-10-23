// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'services_unread_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServicesUnreadEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicesUnreadEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServicesUnreadEvent()';
}


}

/// @nodoc
class $ServicesUnreadEventCopyWith<$Res>  {
$ServicesUnreadEventCopyWith(ServicesUnreadEvent _, $Res Function(ServicesUnreadEvent) __);
}


/// Adds pattern-matching-related methods to [ServicesUnreadEvent].
extension ServicesUnreadEventPatterns on ServicesUnreadEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _Refresh value)?  refresh,TResult Function( _Stopped value)?  stopped,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _Refresh() when refresh != null:
return refresh(_that);case _Stopped() when stopped != null:
return stopped(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _Refresh value)  refresh,required TResult Function( _Stopped value)  stopped,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _Refresh():
return refresh(_that);case _Stopped():
return stopped(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _Refresh value)?  refresh,TResult? Function( _Stopped value)?  stopped,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _Refresh() when refresh != null:
return refresh(_that);case _Stopped() when stopped != null:
return stopped(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  refresh,TResult Function()?  stopped,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _Refresh() when refresh != null:
return refresh();case _Stopped() when stopped != null:
return stopped();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  refresh,required TResult Function()  stopped,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _Refresh():
return refresh();case _Stopped():
return stopped();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  refresh,TResult? Function()?  stopped,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _Refresh() when refresh != null:
return refresh();case _Stopped() when stopped != null:
return stopped();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements ServicesUnreadEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServicesUnreadEvent.started()';
}


}




/// @nodoc


class _Refresh implements ServicesUnreadEvent {
  const _Refresh();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Refresh);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServicesUnreadEvent.refresh()';
}


}




/// @nodoc


class _Stopped implements ServicesUnreadEvent {
  const _Stopped();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Stopped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServicesUnreadEvent.stopped()';
}


}




/// @nodoc
mixin _$ServicesUnreadState {

 int get count;
/// Create a copy of ServicesUnreadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServicesUnreadStateCopyWith<ServicesUnreadState> get copyWith => _$ServicesUnreadStateCopyWithImpl<ServicesUnreadState>(this as ServicesUnreadState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ServicesUnreadState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicesUnreadState&&(identical(other.count, _this.count) || other.count == _this.count));
}


@override
int get hashCode {
  final _this = this as ServicesUnreadState;
  return Object.hash(runtimeType,_this.count);
}

@override
String toString() {
  final _this = this as ServicesUnreadState;
  return 'ServicesUnreadState(count: ${_this.count})';
}


}

/// @nodoc
abstract mixin class $ServicesUnreadStateCopyWith<$Res>  {
  factory $ServicesUnreadStateCopyWith(ServicesUnreadState value, $Res Function(ServicesUnreadState) _then) = _$ServicesUnreadStateCopyWithImpl;
@useResult
$Res call({
 int count
});




}
/// @nodoc
class _$ServicesUnreadStateCopyWithImpl<$Res>
    implements $ServicesUnreadStateCopyWith<$Res> {
  _$ServicesUnreadStateCopyWithImpl(this._self, this._then);

  final ServicesUnreadState _self;
  final $Res Function(ServicesUnreadState) _then;

/// Create a copy of ServicesUnreadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,}) {
  return _then(ServicesUnreadState(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ServicesUnreadState].
extension ServicesUnreadStatePatterns on ServicesUnreadState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServicesUnreadState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServicesUnreadState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServicesUnreadState value)  $default,){
final _that = this;
switch (_that) {
case _ServicesUnreadState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServicesUnreadState value)?  $default,){
final _that = this;
switch (_that) {
case _ServicesUnreadState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServicesUnreadState() when $default != null:
return $default(_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count)  $default,) {final _that = this;
switch (_that) {
case _ServicesUnreadState():
return $default(_that.count);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count)?  $default,) {final _that = this;
switch (_that) {
case _ServicesUnreadState() when $default != null:
return $default(_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _ServicesUnreadState implements ServicesUnreadState {
  const _ServicesUnreadState({required this.count});
  

@override final  int count;

/// Create a copy of ServicesUnreadState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServicesUnreadStateCopyWith<_ServicesUnreadState> get copyWith => __$ServicesUnreadStateCopyWithImpl<_ServicesUnreadState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServicesUnreadState&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode {
    return Object.hash(runtimeType,count);
}

@override
String toString() {
    return 'ServicesUnreadState(count: $count)';
}


}

/// @nodoc
abstract mixin class _$ServicesUnreadStateCopyWith<$Res> implements $ServicesUnreadStateCopyWith<$Res> {
  factory _$ServicesUnreadStateCopyWith(_ServicesUnreadState value, $Res Function(_ServicesUnreadState) _then) = __$ServicesUnreadStateCopyWithImpl;
@override @useResult
$Res call({
 int count
});




}
/// @nodoc
class __$ServicesUnreadStateCopyWithImpl<$Res>
    implements _$ServicesUnreadStateCopyWith<$Res> {
  __$ServicesUnreadStateCopyWithImpl(this._self, this._then);

  final _ServicesUnreadState _self;
  final $Res Function(_ServicesUnreadState) _then;

/// Create a copy of ServicesUnreadState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,}) {
  return _then(_ServicesUnreadState(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
