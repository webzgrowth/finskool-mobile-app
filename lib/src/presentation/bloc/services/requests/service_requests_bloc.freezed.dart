// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_requests_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServiceRequestsEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceRequestsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServiceRequestsEvent()';
}


}

/// @nodoc
class $ServiceRequestsEventCopyWith<$Res>  {
$ServiceRequestsEventCopyWith(ServiceRequestsEvent _, $Res Function(ServiceRequestsEvent) __);
}


/// Adds pattern-matching-related methods to [ServiceRequestsEvent].
extension ServiceRequestsEventPatterns on ServiceRequestsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Load value)?  load,TResult Function( _LoadMore value)?  loadMore,TResult Function( _Pushed value)?  pushed,TResult Function( _Reconnected value)?  reconnected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _Pushed() when pushed != null:
return pushed(_that);case _Reconnected() when reconnected != null:
return reconnected(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Load value)  load,required TResult Function( _LoadMore value)  loadMore,required TResult Function( _Pushed value)  pushed,required TResult Function( _Reconnected value)  reconnected,}){
final _that = this;
switch (_that) {
case _Load():
return load(_that);case _LoadMore():
return loadMore(_that);case _Pushed():
return pushed(_that);case _Reconnected():
return reconnected(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Load value)?  load,TResult? Function( _LoadMore value)?  loadMore,TResult? Function( _Pushed value)?  pushed,TResult? Function( _Reconnected value)?  reconnected,}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _Pushed() when pushed != null:
return pushed(_that);case _Reconnected() when reconnected != null:
return reconnected(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  load,TResult Function()?  loadMore,TResult Function( SocketEvent event)?  pushed,TResult Function()?  reconnected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load();case _LoadMore() when loadMore != null:
return loadMore();case _Pushed() when pushed != null:
return pushed(_that.event);case _Reconnected() when reconnected != null:
return reconnected();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  load,required TResult Function()  loadMore,required TResult Function( SocketEvent event)  pushed,required TResult Function()  reconnected,}) {final _that = this;
switch (_that) {
case _Load():
return load();case _LoadMore():
return loadMore();case _Pushed():
return pushed(_that.event);case _Reconnected():
return reconnected();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  load,TResult? Function()?  loadMore,TResult? Function( SocketEvent event)?  pushed,TResult? Function()?  reconnected,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load();case _LoadMore() when loadMore != null:
return loadMore();case _Pushed() when pushed != null:
return pushed(_that.event);case _Reconnected() when reconnected != null:
return reconnected();case _:
  return null;

}
}

}

/// @nodoc


class _Load implements ServiceRequestsEvent {
  const _Load();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Load);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServiceRequestsEvent.load()';
}


}




/// @nodoc


class _LoadMore implements ServiceRequestsEvent {
  const _LoadMore();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServiceRequestsEvent.loadMore()';
}


}




/// @nodoc


class _Pushed implements ServiceRequestsEvent {
  const _Pushed(this.event);
  

 final  SocketEvent event;

/// Create a copy of ServiceRequestsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PushedCopyWith<_Pushed> get copyWith => __$PushedCopyWithImpl<_Pushed>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Pushed&&(identical(other.event, event) || other.event == event));
}


@override
int get hashCode {
    return Object.hash(runtimeType,event);
}

@override
String toString() {
    return 'ServiceRequestsEvent.pushed(event: $event)';
}


}

/// @nodoc
abstract mixin class _$PushedCopyWith<$Res> implements $ServiceRequestsEventCopyWith<$Res> {
  factory _$PushedCopyWith(_Pushed value, $Res Function(_Pushed) _then) = __$PushedCopyWithImpl;
@useResult
$Res call({
 SocketEvent event
});




}
/// @nodoc
class __$PushedCopyWithImpl<$Res>
    implements _$PushedCopyWith<$Res> {
  __$PushedCopyWithImpl(this._self, this._then);

  final _Pushed _self;
  final $Res Function(_Pushed) _then;

/// Create a copy of ServiceRequestsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? event = null,}) {
  return _then(_Pushed(
null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as SocketEvent,
  ));
}


}

/// @nodoc


class _Reconnected implements ServiceRequestsEvent {
  const _Reconnected();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reconnected);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServiceRequestsEvent.reconnected()';
}


}




/// @nodoc
mixin _$ServiceRequestsState {

 RequestState get state; List<ServiceRequestModel> get requests; bool get isLoadingMore; String get message; String? get cursor;
/// Create a copy of ServiceRequestsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceRequestsStateCopyWith<ServiceRequestsState> get copyWith => _$ServiceRequestsStateCopyWithImpl<ServiceRequestsState>(this as ServiceRequestsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ServiceRequestsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceRequestsState&&(identical(other.state, _this.state) || other.state == _this.state)&&const DeepCollectionEquality().equals(other.requests, _this.requests)&&(identical(other.isLoadingMore, _this.isLoadingMore) || other.isLoadingMore == _this.isLoadingMore)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.cursor, _this.cursor) || other.cursor == _this.cursor));
}


@override
int get hashCode {
  final _this = this as ServiceRequestsState;
  return Object.hash(runtimeType,_this.state,const DeepCollectionEquality().hash(_this.requests),_this.isLoadingMore,_this.message,_this.cursor);
}

@override
String toString() {
  final _this = this as ServiceRequestsState;
  return 'ServiceRequestsState(state: ${_this.state}, requests: ${_this.requests}, isLoadingMore: ${_this.isLoadingMore}, message: ${_this.message}, cursor: ${_this.cursor})';
}


}

/// @nodoc
abstract mixin class $ServiceRequestsStateCopyWith<$Res>  {
  factory $ServiceRequestsStateCopyWith(ServiceRequestsState value, $Res Function(ServiceRequestsState) _then) = _$ServiceRequestsStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, List<ServiceRequestModel> requests, bool isLoadingMore, String message, String? cursor
});




}
/// @nodoc
class _$ServiceRequestsStateCopyWithImpl<$Res>
    implements $ServiceRequestsStateCopyWith<$Res> {
  _$ServiceRequestsStateCopyWithImpl(this._self, this._then);

  final ServiceRequestsState _self;
  final $Res Function(ServiceRequestsState) _then;

/// Create a copy of ServiceRequestsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? requests = null,Object? isLoadingMore = null,Object? message = null,Object? cursor = freezed,}) {
  return _then(ServiceRequestsState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,requests: null == requests ? _self.requests : requests // ignore: cast_nullable_to_non_nullable
as List<ServiceRequestModel>,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceRequestsState].
extension ServiceRequestsStatePatterns on ServiceRequestsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceRequestsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceRequestsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceRequestsState value)  $default,){
final _that = this;
switch (_that) {
case _ServiceRequestsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceRequestsState value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceRequestsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  List<ServiceRequestModel> requests,  bool isLoadingMore,  String message,  String? cursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceRequestsState() when $default != null:
return $default(_that.state,_that.requests,_that.isLoadingMore,_that.message,_that.cursor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  List<ServiceRequestModel> requests,  bool isLoadingMore,  String message,  String? cursor)  $default,) {final _that = this;
switch (_that) {
case _ServiceRequestsState():
return $default(_that.state,_that.requests,_that.isLoadingMore,_that.message,_that.cursor);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  List<ServiceRequestModel> requests,  bool isLoadingMore,  String message,  String? cursor)?  $default,) {final _that = this;
switch (_that) {
case _ServiceRequestsState() when $default != null:
return $default(_that.state,_that.requests,_that.isLoadingMore,_that.message,_that.cursor);case _:
  return null;

}
}

}

/// @nodoc


class _ServiceRequestsState implements ServiceRequestsState {
  const _ServiceRequestsState({required this.state, required  List<ServiceRequestModel> requests, required this.isLoadingMore, required this.message, this.cursor}): _requests = requests;
  

@override final  RequestState state;
 final  List<ServiceRequestModel> _requests;
@override List<ServiceRequestModel> get requests {
  if (_requests is EqualUnmodifiableListView) return _requests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requests);
}

@override final  bool isLoadingMore;
@override final  String message;
@override final  String? cursor;

/// Create a copy of ServiceRequestsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceRequestsStateCopyWith<_ServiceRequestsState> get copyWith => __$ServiceRequestsStateCopyWithImpl<_ServiceRequestsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceRequestsState&&(identical(other.state, state) || other.state == state)&&const DeepCollectionEquality().equals(other.requests, _requests)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.message, message) || other.message == message)&&(identical(other.cursor, cursor) || other.cursor == cursor));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state,const DeepCollectionEquality().hash(_requests),isLoadingMore,message,cursor);
}

@override
String toString() {
    return 'ServiceRequestsState(state: $state, requests: $requests, isLoadingMore: $isLoadingMore, message: $message, cursor: $cursor)';
}


}

/// @nodoc
abstract mixin class _$ServiceRequestsStateCopyWith<$Res> implements $ServiceRequestsStateCopyWith<$Res> {
  factory _$ServiceRequestsStateCopyWith(_ServiceRequestsState value, $Res Function(_ServiceRequestsState) _then) = __$ServiceRequestsStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, List<ServiceRequestModel> requests, bool isLoadingMore, String message, String? cursor
});




}
/// @nodoc
class __$ServiceRequestsStateCopyWithImpl<$Res>
    implements _$ServiceRequestsStateCopyWith<$Res> {
  __$ServiceRequestsStateCopyWithImpl(this._self, this._then);

  final _ServiceRequestsState _self;
  final $Res Function(_ServiceRequestsState) _then;

/// Create a copy of ServiceRequestsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? requests = null,Object? isLoadingMore = null,Object? message = null,Object? cursor = freezed,}) {
  return _then(_ServiceRequestsState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,requests: null == requests ? _self._requests : requests // ignore: cast_nullable_to_non_nullable
as List<ServiceRequestModel>,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,cursor: freezed == cursor ? _self.cursor : cursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
