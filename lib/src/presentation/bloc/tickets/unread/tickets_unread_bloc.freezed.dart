// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tickets_unread_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TicketsUnreadEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketsUnreadEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TicketsUnreadEvent()';
}


}

/// @nodoc
class $TicketsUnreadEventCopyWith<$Res>  {
$TicketsUnreadEventCopyWith(TicketsUnreadEvent _, $Res Function(TicketsUnreadEvent) __);
}


/// Adds pattern-matching-related methods to [TicketsUnreadEvent].
extension TicketsUnreadEventPatterns on TicketsUnreadEvent {
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


class _Started implements TicketsUnreadEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TicketsUnreadEvent.started()';
}


}




/// @nodoc


class _Refresh implements TicketsUnreadEvent {
  const _Refresh();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Refresh);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TicketsUnreadEvent.refresh()';
}


}




/// @nodoc


class _Stopped implements TicketsUnreadEvent {
  const _Stopped();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Stopped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TicketsUnreadEvent.stopped()';
}


}




/// @nodoc
mixin _$TicketsUnreadState {

 int get count;
/// Create a copy of TicketsUnreadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketsUnreadStateCopyWith<TicketsUnreadState> get copyWith => _$TicketsUnreadStateCopyWithImpl<TicketsUnreadState>(this as TicketsUnreadState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TicketsUnreadState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketsUnreadState&&(identical(other.count, _this.count) || other.count == _this.count));
}


@override
int get hashCode {
  final _this = this as TicketsUnreadState;
  return Object.hash(runtimeType,_this.count);
}

@override
String toString() {
  final _this = this as TicketsUnreadState;
  return 'TicketsUnreadState(count: ${_this.count})';
}


}

/// @nodoc
abstract mixin class $TicketsUnreadStateCopyWith<$Res>  {
  factory $TicketsUnreadStateCopyWith(TicketsUnreadState value, $Res Function(TicketsUnreadState) _then) = _$TicketsUnreadStateCopyWithImpl;
@useResult
$Res call({
 int count
});




}
/// @nodoc
class _$TicketsUnreadStateCopyWithImpl<$Res>
    implements $TicketsUnreadStateCopyWith<$Res> {
  _$TicketsUnreadStateCopyWithImpl(this._self, this._then);

  final TicketsUnreadState _self;
  final $Res Function(TicketsUnreadState) _then;

/// Create a copy of TicketsUnreadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,}) {
  return _then(TicketsUnreadState(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketsUnreadState].
extension TicketsUnreadStatePatterns on TicketsUnreadState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketsUnreadState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketsUnreadState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketsUnreadState value)  $default,){
final _that = this;
switch (_that) {
case _TicketsUnreadState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketsUnreadState value)?  $default,){
final _that = this;
switch (_that) {
case _TicketsUnreadState() when $default != null:
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
case _TicketsUnreadState() when $default != null:
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
case _TicketsUnreadState():
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
case _TicketsUnreadState() when $default != null:
return $default(_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _TicketsUnreadState implements TicketsUnreadState {
  const _TicketsUnreadState({required this.count});
  

@override final  int count;

/// Create a copy of TicketsUnreadState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketsUnreadStateCopyWith<_TicketsUnreadState> get copyWith => __$TicketsUnreadStateCopyWithImpl<_TicketsUnreadState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketsUnreadState&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode {
    return Object.hash(runtimeType,count);
}

@override
String toString() {
    return 'TicketsUnreadState(count: $count)';
}


}

/// @nodoc
abstract mixin class _$TicketsUnreadStateCopyWith<$Res> implements $TicketsUnreadStateCopyWith<$Res> {
  factory _$TicketsUnreadStateCopyWith(_TicketsUnreadState value, $Res Function(_TicketsUnreadState) _then) = __$TicketsUnreadStateCopyWithImpl;
@override @useResult
$Res call({
 int count
});




}
/// @nodoc
class __$TicketsUnreadStateCopyWithImpl<$Res>
    implements _$TicketsUnreadStateCopyWith<$Res> {
  __$TicketsUnreadStateCopyWithImpl(this._self, this._then);

  final _TicketsUnreadState _self;
  final $Res Function(_TicketsUnreadState) _then;

/// Create a copy of TicketsUnreadState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,}) {
  return _then(_TicketsUnreadState(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
