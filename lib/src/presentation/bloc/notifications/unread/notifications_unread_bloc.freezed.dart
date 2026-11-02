// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_unread_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationsUnreadEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsUnreadEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NotificationsUnreadEvent()';
}


}

/// @nodoc
class $NotificationsUnreadEventCopyWith<$Res>  {
$NotificationsUnreadEventCopyWith(NotificationsUnreadEvent _, $Res Function(NotificationsUnreadEvent) __);
}


/// Adds pattern-matching-related methods to [NotificationsUnreadEvent].
extension NotificationsUnreadEventPatterns on NotificationsUnreadEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _Refresh value)?  refresh,TResult Function( _Decremented value)?  decremented,TResult Function( _AllRead value)?  allRead,TResult Function( _Received value)?  received,TResult Function( _Stopped value)?  stopped,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _Refresh() when refresh != null:
return refresh(_that);case _Decremented() when decremented != null:
return decremented(_that);case _AllRead() when allRead != null:
return allRead(_that);case _Received() when received != null:
return received(_that);case _Stopped() when stopped != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _Refresh value)  refresh,required TResult Function( _Decremented value)  decremented,required TResult Function( _AllRead value)  allRead,required TResult Function( _Received value)  received,required TResult Function( _Stopped value)  stopped,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _Refresh():
return refresh(_that);case _Decremented():
return decremented(_that);case _AllRead():
return allRead(_that);case _Received():
return received(_that);case _Stopped():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _Refresh value)?  refresh,TResult? Function( _Decremented value)?  decremented,TResult? Function( _AllRead value)?  allRead,TResult? Function( _Received value)?  received,TResult? Function( _Stopped value)?  stopped,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _Refresh() when refresh != null:
return refresh(_that);case _Decremented() when decremented != null:
return decremented(_that);case _AllRead() when allRead != null:
return allRead(_that);case _Received() when received != null:
return received(_that);case _Stopped() when stopped != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  refresh,TResult Function( int by)?  decremented,TResult Function()?  allRead,TResult Function( NotificationEvent event)?  received,TResult Function()?  stopped,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _Refresh() when refresh != null:
return refresh();case _Decremented() when decremented != null:
return decremented(_that.by);case _AllRead() when allRead != null:
return allRead();case _Received() when received != null:
return received(_that.event);case _Stopped() when stopped != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  refresh,required TResult Function( int by)  decremented,required TResult Function()  allRead,required TResult Function( NotificationEvent event)  received,required TResult Function()  stopped,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _Refresh():
return refresh();case _Decremented():
return decremented(_that.by);case _AllRead():
return allRead();case _Received():
return received(_that.event);case _Stopped():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  refresh,TResult? Function( int by)?  decremented,TResult? Function()?  allRead,TResult? Function( NotificationEvent event)?  received,TResult? Function()?  stopped,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _Refresh() when refresh != null:
return refresh();case _Decremented() when decremented != null:
return decremented(_that.by);case _AllRead() when allRead != null:
return allRead();case _Received() when received != null:
return received(_that.event);case _Stopped() when stopped != null:
return stopped();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements NotificationsUnreadEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NotificationsUnreadEvent.started()';
}


}




/// @nodoc


class _Refresh implements NotificationsUnreadEvent {
  const _Refresh();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Refresh);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NotificationsUnreadEvent.refresh()';
}


}




/// @nodoc


class _Decremented implements NotificationsUnreadEvent {
  const _Decremented(this.by);
  

 final  int by;

/// Create a copy of NotificationsUnreadEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DecrementedCopyWith<_Decremented> get copyWith => __$DecrementedCopyWithImpl<_Decremented>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Decremented&&(identical(other.by, by) || other.by == by));
}


@override
int get hashCode {
    return Object.hash(runtimeType,by);
}

@override
String toString() {
    return 'NotificationsUnreadEvent.decremented(by: $by)';
}


}

/// @nodoc
abstract mixin class _$DecrementedCopyWith<$Res> implements $NotificationsUnreadEventCopyWith<$Res> {
  factory _$DecrementedCopyWith(_Decremented value, $Res Function(_Decremented) _then) = __$DecrementedCopyWithImpl;
@useResult
$Res call({
 int by
});




}
/// @nodoc
class __$DecrementedCopyWithImpl<$Res>
    implements _$DecrementedCopyWith<$Res> {
  __$DecrementedCopyWithImpl(this._self, this._then);

  final _Decremented _self;
  final $Res Function(_Decremented) _then;

/// Create a copy of NotificationsUnreadEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? by = null,}) {
  return _then(_Decremented(
null == by ? _self.by : by // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _AllRead implements NotificationsUnreadEvent {
  const _AllRead();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AllRead);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NotificationsUnreadEvent.allRead()';
}


}




/// @nodoc


class _Received implements NotificationsUnreadEvent {
  const _Received(this.event);
  

 final  NotificationEvent event;

/// Create a copy of NotificationsUnreadEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceivedCopyWith<_Received> get copyWith => __$ReceivedCopyWithImpl<_Received>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Received&&(identical(other.event, event) || other.event == event));
}


@override
int get hashCode {
    return Object.hash(runtimeType,event);
}

@override
String toString() {
    return 'NotificationsUnreadEvent.received(event: $event)';
}


}

/// @nodoc
abstract mixin class _$ReceivedCopyWith<$Res> implements $NotificationsUnreadEventCopyWith<$Res> {
  factory _$ReceivedCopyWith(_Received value, $Res Function(_Received) _then) = __$ReceivedCopyWithImpl;
@useResult
$Res call({
 NotificationEvent event
});




}
/// @nodoc
class __$ReceivedCopyWithImpl<$Res>
    implements _$ReceivedCopyWith<$Res> {
  __$ReceivedCopyWithImpl(this._self, this._then);

  final _Received _self;
  final $Res Function(_Received) _then;

/// Create a copy of NotificationsUnreadEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? event = null,}) {
  return _then(_Received(
null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as NotificationEvent,
  ));
}


}

/// @nodoc


class _Stopped implements NotificationsUnreadEvent {
  const _Stopped();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Stopped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NotificationsUnreadEvent.stopped()';
}


}




/// @nodoc
mixin _$NotificationsUnreadState {

 int get count;/// The notification that just arrived over the socket. The in-app banner
/// drops from the top for it; the next one replaces it.
 AppNotification? get incoming;
/// Create a copy of NotificationsUnreadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationsUnreadStateCopyWith<NotificationsUnreadState> get copyWith => _$NotificationsUnreadStateCopyWithImpl<NotificationsUnreadState>(this as NotificationsUnreadState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NotificationsUnreadState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsUnreadState&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.incoming, _this.incoming) || other.incoming == _this.incoming));
}


@override
int get hashCode {
  final _this = this as NotificationsUnreadState;
  return Object.hash(runtimeType,_this.count,_this.incoming);
}

@override
String toString() {
  final _this = this as NotificationsUnreadState;
  return 'NotificationsUnreadState(count: ${_this.count}, incoming: ${_this.incoming})';
}


}

/// @nodoc
abstract mixin class $NotificationsUnreadStateCopyWith<$Res>  {
  factory $NotificationsUnreadStateCopyWith(NotificationsUnreadState value, $Res Function(NotificationsUnreadState) _then) = _$NotificationsUnreadStateCopyWithImpl;
@useResult
$Res call({
 int count, AppNotification? incoming
});




}
/// @nodoc
class _$NotificationsUnreadStateCopyWithImpl<$Res>
    implements $NotificationsUnreadStateCopyWith<$Res> {
  _$NotificationsUnreadStateCopyWithImpl(this._self, this._then);

  final NotificationsUnreadState _self;
  final $Res Function(NotificationsUnreadState) _then;

/// Create a copy of NotificationsUnreadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? incoming = freezed,}) {
  return _then(NotificationsUnreadState(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,incoming: freezed == incoming ? _self.incoming : incoming // ignore: cast_nullable_to_non_nullable
as AppNotification?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationsUnreadState].
extension NotificationsUnreadStatePatterns on NotificationsUnreadState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationsUnreadState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationsUnreadState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationsUnreadState value)  $default,){
final _that = this;
switch (_that) {
case _NotificationsUnreadState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationsUnreadState value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationsUnreadState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  AppNotification? incoming)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationsUnreadState() when $default != null:
return $default(_that.count,_that.incoming);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  AppNotification? incoming)  $default,) {final _that = this;
switch (_that) {
case _NotificationsUnreadState():
return $default(_that.count,_that.incoming);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  AppNotification? incoming)?  $default,) {final _that = this;
switch (_that) {
case _NotificationsUnreadState() when $default != null:
return $default(_that.count,_that.incoming);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationsUnreadState implements NotificationsUnreadState {
  const _NotificationsUnreadState({this.count = 0, this.incoming});
  

@override@JsonKey() final  int count;
/// The notification that just arrived over the socket. The in-app banner
/// drops from the top for it; the next one replaces it.
@override final  AppNotification? incoming;

/// Create a copy of NotificationsUnreadState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationsUnreadStateCopyWith<_NotificationsUnreadState> get copyWith => __$NotificationsUnreadStateCopyWithImpl<_NotificationsUnreadState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationsUnreadState&&(identical(other.count, count) || other.count == count)&&(identical(other.incoming, incoming) || other.incoming == incoming));
}


@override
int get hashCode {
    return Object.hash(runtimeType,count,incoming);
}

@override
String toString() {
    return 'NotificationsUnreadState(count: $count, incoming: $incoming)';
}


}

/// @nodoc
abstract mixin class _$NotificationsUnreadStateCopyWith<$Res> implements $NotificationsUnreadStateCopyWith<$Res> {
  factory _$NotificationsUnreadStateCopyWith(_NotificationsUnreadState value, $Res Function(_NotificationsUnreadState) _then) = __$NotificationsUnreadStateCopyWithImpl;
@override @useResult
$Res call({
 int count, AppNotification? incoming
});




}
/// @nodoc
class __$NotificationsUnreadStateCopyWithImpl<$Res>
    implements _$NotificationsUnreadStateCopyWith<$Res> {
  __$NotificationsUnreadStateCopyWithImpl(this._self, this._then);

  final _NotificationsUnreadState _self;
  final $Res Function(_NotificationsUnreadState) _then;

/// Create a copy of NotificationsUnreadState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? incoming = freezed,}) {
  return _then(_NotificationsUnreadState(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,incoming: freezed == incoming ? _self.incoming : incoming // ignore: cast_nullable_to_non_nullable
as AppNotification?,
  ));
}


}

// dart format on
