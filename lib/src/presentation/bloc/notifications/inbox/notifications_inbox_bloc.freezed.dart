// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_inbox_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationsInboxEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsInboxEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NotificationsInboxEvent()';
}


}

/// @nodoc
class $NotificationsInboxEventCopyWith<$Res>  {
$NotificationsInboxEventCopyWith(NotificationsInboxEvent _, $Res Function(NotificationsInboxEvent) __);
}


/// Adds pattern-matching-related methods to [NotificationsInboxEvent].
extension NotificationsInboxEventPatterns on NotificationsInboxEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Load value)?  load,TResult Function( _LoadMore value)?  loadMore,TResult Function( _MarkRead value)?  markRead,TResult Function( _MarkAllRead value)?  markAllRead,TResult Function( _Received value)?  received,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _MarkRead() when markRead != null:
return markRead(_that);case _MarkAllRead() when markAllRead != null:
return markAllRead(_that);case _Received() when received != null:
return received(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Load value)  load,required TResult Function( _LoadMore value)  loadMore,required TResult Function( _MarkRead value)  markRead,required TResult Function( _MarkAllRead value)  markAllRead,required TResult Function( _Received value)  received,}){
final _that = this;
switch (_that) {
case _Load():
return load(_that);case _LoadMore():
return loadMore(_that);case _MarkRead():
return markRead(_that);case _MarkAllRead():
return markAllRead(_that);case _Received():
return received(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Load value)?  load,TResult? Function( _LoadMore value)?  loadMore,TResult? Function( _MarkRead value)?  markRead,TResult? Function( _MarkAllRead value)?  markAllRead,TResult? Function( _Received value)?  received,}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _MarkRead() when markRead != null:
return markRead(_that);case _MarkAllRead() when markAllRead != null:
return markAllRead(_that);case _Received() when received != null:
return received(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  load,TResult Function()?  loadMore,TResult Function( String id)?  markRead,TResult Function()?  markAllRead,TResult Function( AppNotification item)?  received,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load();case _LoadMore() when loadMore != null:
return loadMore();case _MarkRead() when markRead != null:
return markRead(_that.id);case _MarkAllRead() when markAllRead != null:
return markAllRead();case _Received() when received != null:
return received(_that.item);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  load,required TResult Function()  loadMore,required TResult Function( String id)  markRead,required TResult Function()  markAllRead,required TResult Function( AppNotification item)  received,}) {final _that = this;
switch (_that) {
case _Load():
return load();case _LoadMore():
return loadMore();case _MarkRead():
return markRead(_that.id);case _MarkAllRead():
return markAllRead();case _Received():
return received(_that.item);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  load,TResult? Function()?  loadMore,TResult? Function( String id)?  markRead,TResult? Function()?  markAllRead,TResult? Function( AppNotification item)?  received,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load();case _LoadMore() when loadMore != null:
return loadMore();case _MarkRead() when markRead != null:
return markRead(_that.id);case _MarkAllRead() when markAllRead != null:
return markAllRead();case _Received() when received != null:
return received(_that.item);case _:
  return null;

}
}

}

/// @nodoc


class _Load implements NotificationsInboxEvent {
  const _Load();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Load);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NotificationsInboxEvent.load()';
}


}




/// @nodoc


class _LoadMore implements NotificationsInboxEvent {
  const _LoadMore();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NotificationsInboxEvent.loadMore()';
}


}




/// @nodoc


class _MarkRead implements NotificationsInboxEvent {
  const _MarkRead(this.id);
  

 final  String id;

/// Create a copy of NotificationsInboxEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MarkReadCopyWith<_MarkRead> get copyWith => __$MarkReadCopyWithImpl<_MarkRead>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkRead&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id);
}

@override
String toString() {
    return 'NotificationsInboxEvent.markRead(id: $id)';
}


}

/// @nodoc
abstract mixin class _$MarkReadCopyWith<$Res> implements $NotificationsInboxEventCopyWith<$Res> {
  factory _$MarkReadCopyWith(_MarkRead value, $Res Function(_MarkRead) _then) = __$MarkReadCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class __$MarkReadCopyWithImpl<$Res>
    implements _$MarkReadCopyWith<$Res> {
  __$MarkReadCopyWithImpl(this._self, this._then);

  final _MarkRead _self;
  final $Res Function(_MarkRead) _then;

/// Create a copy of NotificationsInboxEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_MarkRead(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _MarkAllRead implements NotificationsInboxEvent {
  const _MarkAllRead();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MarkAllRead);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NotificationsInboxEvent.markAllRead()';
}


}




/// @nodoc


class _Received implements NotificationsInboxEvent {
  const _Received(this.item);
  

 final  AppNotification item;

/// Create a copy of NotificationsInboxEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReceivedCopyWith<_Received> get copyWith => __$ReceivedCopyWithImpl<_Received>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Received&&(identical(other.item, item) || other.item == item));
}


@override
int get hashCode {
    return Object.hash(runtimeType,item);
}

@override
String toString() {
    return 'NotificationsInboxEvent.received(item: $item)';
}


}

/// @nodoc
abstract mixin class _$ReceivedCopyWith<$Res> implements $NotificationsInboxEventCopyWith<$Res> {
  factory _$ReceivedCopyWith(_Received value, $Res Function(_Received) _then) = __$ReceivedCopyWithImpl;
@useResult
$Res call({
 AppNotification item
});




}
/// @nodoc
class __$ReceivedCopyWithImpl<$Res>
    implements _$ReceivedCopyWith<$Res> {
  __$ReceivedCopyWithImpl(this._self, this._then);

  final _Received _self;
  final $Res Function(_Received) _then;

/// Create a copy of NotificationsInboxEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? item = null,}) {
  return _then(_Received(
null == item ? _self.item : item // ignore: cast_nullable_to_non_nullable
as AppNotification,
  ));
}


}

/// @nodoc
mixin _$NotificationsInboxState {

 RequestState get state; List<AppNotification> get items; int get page; bool get hasMore; bool get isLoadingMore;/// The last page request failed. Stops the scroll listener re-firing at
/// the bottom on every tick; cleared by a pull-to-refresh / reload.
 bool get loadMoreFailed; String get message;
/// Create a copy of NotificationsInboxState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationsInboxStateCopyWith<NotificationsInboxState> get copyWith => _$NotificationsInboxStateCopyWithImpl<NotificationsInboxState>(this as NotificationsInboxState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NotificationsInboxState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsInboxState&&(identical(other.state, _this.state) || other.state == _this.state)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.hasMore, _this.hasMore) || other.hasMore == _this.hasMore)&&(identical(other.isLoadingMore, _this.isLoadingMore) || other.isLoadingMore == _this.isLoadingMore)&&(identical(other.loadMoreFailed, _this.loadMoreFailed) || other.loadMoreFailed == _this.loadMoreFailed)&&(identical(other.message, _this.message) || other.message == _this.message));
}


@override
int get hashCode {
  final _this = this as NotificationsInboxState;
  return Object.hash(runtimeType,_this.state,const DeepCollectionEquality().hash(_this.items),_this.page,_this.hasMore,_this.isLoadingMore,_this.loadMoreFailed,_this.message);
}

@override
String toString() {
  final _this = this as NotificationsInboxState;
  return 'NotificationsInboxState(state: ${_this.state}, items: ${_this.items}, page: ${_this.page}, hasMore: ${_this.hasMore}, isLoadingMore: ${_this.isLoadingMore}, loadMoreFailed: ${_this.loadMoreFailed}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $NotificationsInboxStateCopyWith<$Res>  {
  factory $NotificationsInboxStateCopyWith(NotificationsInboxState value, $Res Function(NotificationsInboxState) _then) = _$NotificationsInboxStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, List<AppNotification> items, int page, bool hasMore, bool isLoadingMore, bool loadMoreFailed, String message
});




}
/// @nodoc
class _$NotificationsInboxStateCopyWithImpl<$Res>
    implements $NotificationsInboxStateCopyWith<$Res> {
  _$NotificationsInboxStateCopyWithImpl(this._self, this._then);

  final NotificationsInboxState _self;
  final $Res Function(NotificationsInboxState) _then;

/// Create a copy of NotificationsInboxState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? items = null,Object? page = null,Object? hasMore = null,Object? isLoadingMore = null,Object? loadMoreFailed = null,Object? message = null,}) {
  return _then(NotificationsInboxState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<AppNotification>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,loadMoreFailed: null == loadMoreFailed ? _self.loadMoreFailed : loadMoreFailed // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationsInboxState].
extension NotificationsInboxStatePatterns on NotificationsInboxState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationsInboxState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationsInboxState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationsInboxState value)  $default,){
final _that = this;
switch (_that) {
case _NotificationsInboxState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationsInboxState value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationsInboxState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  List<AppNotification> items,  int page,  bool hasMore,  bool isLoadingMore,  bool loadMoreFailed,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationsInboxState() when $default != null:
return $default(_that.state,_that.items,_that.page,_that.hasMore,_that.isLoadingMore,_that.loadMoreFailed,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  List<AppNotification> items,  int page,  bool hasMore,  bool isLoadingMore,  bool loadMoreFailed,  String message)  $default,) {final _that = this;
switch (_that) {
case _NotificationsInboxState():
return $default(_that.state,_that.items,_that.page,_that.hasMore,_that.isLoadingMore,_that.loadMoreFailed,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  List<AppNotification> items,  int page,  bool hasMore,  bool isLoadingMore,  bool loadMoreFailed,  String message)?  $default,) {final _that = this;
switch (_that) {
case _NotificationsInboxState() when $default != null:
return $default(_that.state,_that.items,_that.page,_that.hasMore,_that.isLoadingMore,_that.loadMoreFailed,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationsInboxState extends NotificationsInboxState {
  const _NotificationsInboxState({this.state = RequestState.empty,  List<AppNotification> items = const <AppNotification>[], this.page = 1, this.hasMore = false, this.isLoadingMore = false, this.loadMoreFailed = false, this.message = ''}): _items = items,super._();
  

@override@JsonKey() final  RequestState state;
 final  List<AppNotification> _items;
@override@JsonKey() List<AppNotification> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int page;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  bool isLoadingMore;
/// The last page request failed. Stops the scroll listener re-firing at
/// the bottom on every tick; cleared by a pull-to-refresh / reload.
@override@JsonKey() final  bool loadMoreFailed;
@override@JsonKey() final  String message;

/// Create a copy of NotificationsInboxState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationsInboxStateCopyWith<_NotificationsInboxState> get copyWith => __$NotificationsInboxStateCopyWithImpl<_NotificationsInboxState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationsInboxState&&(identical(other.state, state) || other.state == state)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.loadMoreFailed, loadMoreFailed) || other.loadMoreFailed == loadMoreFailed)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state,const DeepCollectionEquality().hash(_items),page,hasMore,isLoadingMore,loadMoreFailed,message);
}

@override
String toString() {
    return 'NotificationsInboxState(state: $state, items: $items, page: $page, hasMore: $hasMore, isLoadingMore: $isLoadingMore, loadMoreFailed: $loadMoreFailed, message: $message)';
}


}

/// @nodoc
abstract mixin class _$NotificationsInboxStateCopyWith<$Res> implements $NotificationsInboxStateCopyWith<$Res> {
  factory _$NotificationsInboxStateCopyWith(_NotificationsInboxState value, $Res Function(_NotificationsInboxState) _then) = __$NotificationsInboxStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, List<AppNotification> items, int page, bool hasMore, bool isLoadingMore, bool loadMoreFailed, String message
});




}
/// @nodoc
class __$NotificationsInboxStateCopyWithImpl<$Res>
    implements _$NotificationsInboxStateCopyWith<$Res> {
  __$NotificationsInboxStateCopyWithImpl(this._self, this._then);

  final _NotificationsInboxState _self;
  final $Res Function(_NotificationsInboxState) _then;

/// Create a copy of NotificationsInboxState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? items = null,Object? page = null,Object? hasMore = null,Object? isLoadingMore = null,Object? loadMoreFailed = null,Object? message = null,}) {
  return _then(_NotificationsInboxState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<AppNotification>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,loadMoreFailed: null == loadMoreFailed ? _self.loadMoreFailed : loadMoreFailed // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
