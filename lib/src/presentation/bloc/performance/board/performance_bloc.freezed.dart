// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'performance_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PerformanceEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PerformanceEvent()';
}


}

/// @nodoc
class $PerformanceEventCopyWith<$Res>  {
$PerformanceEventCopyWith(PerformanceEvent _, $Res Function(PerformanceEvent) __);
}


/// Adds pattern-matching-related methods to [PerformanceEvent].
extension PerformanceEventPatterns on PerformanceEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Load value)?  load,TResult Function( _SegmentChanged value)?  segmentChanged,TResult Function( _FilterChanged value)?  filterChanged,TResult Function( _LoadMore value)?  loadMore,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _SegmentChanged() when segmentChanged != null:
return segmentChanged(_that);case _FilterChanged() when filterChanged != null:
return filterChanged(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Load value)  load,required TResult Function( _SegmentChanged value)  segmentChanged,required TResult Function( _FilterChanged value)  filterChanged,required TResult Function( _LoadMore value)  loadMore,}){
final _that = this;
switch (_that) {
case _Load():
return load(_that);case _SegmentChanged():
return segmentChanged(_that);case _FilterChanged():
return filterChanged(_that);case _LoadMore():
return loadMore(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Load value)?  load,TResult? Function( _SegmentChanged value)?  segmentChanged,TResult? Function( _FilterChanged value)?  filterChanged,TResult? Function( _LoadMore value)?  loadMore,}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _SegmentChanged() when segmentChanged != null:
return segmentChanged(_that);case _FilterChanged() when filterChanged != null:
return filterChanged(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String communityId,  PerformanceSegment? segment)?  load,TResult Function( PerformanceSegment segment)?  segmentChanged,TResult Function( PerformanceMonthFilter? filter)?  filterChanged,TResult Function()?  loadMore,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.communityId,_that.segment);case _SegmentChanged() when segmentChanged != null:
return segmentChanged(_that.segment);case _FilterChanged() when filterChanged != null:
return filterChanged(_that.filter);case _LoadMore() when loadMore != null:
return loadMore();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String communityId,  PerformanceSegment? segment)  load,required TResult Function( PerformanceSegment segment)  segmentChanged,required TResult Function( PerformanceMonthFilter? filter)  filterChanged,required TResult Function()  loadMore,}) {final _that = this;
switch (_that) {
case _Load():
return load(_that.communityId,_that.segment);case _SegmentChanged():
return segmentChanged(_that.segment);case _FilterChanged():
return filterChanged(_that.filter);case _LoadMore():
return loadMore();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String communityId,  PerformanceSegment? segment)?  load,TResult? Function( PerformanceSegment segment)?  segmentChanged,TResult? Function( PerformanceMonthFilter? filter)?  filterChanged,TResult? Function()?  loadMore,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that.communityId,_that.segment);case _SegmentChanged() when segmentChanged != null:
return segmentChanged(_that.segment);case _FilterChanged() when filterChanged != null:
return filterChanged(_that.filter);case _LoadMore() when loadMore != null:
return loadMore();case _:
  return null;

}
}

}

/// @nodoc


class _Load implements PerformanceEvent {
  const _Load({required this.communityId, this.segment});
  

 final  String communityId;
 final  PerformanceSegment? segment;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadCopyWith<_Load> get copyWith => __$LoadCopyWithImpl<_Load>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Load&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.segment, segment) || other.segment == segment));
}


@override
int get hashCode {
    return Object.hash(runtimeType,communityId,segment);
}

@override
String toString() {
    return 'PerformanceEvent.load(communityId: $communityId, segment: $segment)';
}


}

/// @nodoc
abstract mixin class _$LoadCopyWith<$Res> implements $PerformanceEventCopyWith<$Res> {
  factory _$LoadCopyWith(_Load value, $Res Function(_Load) _then) = __$LoadCopyWithImpl;
@useResult
$Res call({
 String communityId, PerformanceSegment? segment
});




}
/// @nodoc
class __$LoadCopyWithImpl<$Res>
    implements _$LoadCopyWith<$Res> {
  __$LoadCopyWithImpl(this._self, this._then);

  final _Load _self;
  final $Res Function(_Load) _then;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,Object? segment = freezed,}) {
  return _then(_Load(
communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,segment: freezed == segment ? _self.segment : segment // ignore: cast_nullable_to_non_nullable
as PerformanceSegment?,
  ));
}


}

/// @nodoc


class _SegmentChanged implements PerformanceEvent {
  const _SegmentChanged(this.segment);
  

 final  PerformanceSegment segment;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SegmentChangedCopyWith<_SegmentChanged> get copyWith => __$SegmentChangedCopyWithImpl<_SegmentChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SegmentChanged&&(identical(other.segment, segment) || other.segment == segment));
}


@override
int get hashCode {
    return Object.hash(runtimeType,segment);
}

@override
String toString() {
    return 'PerformanceEvent.segmentChanged(segment: $segment)';
}


}

/// @nodoc
abstract mixin class _$SegmentChangedCopyWith<$Res> implements $PerformanceEventCopyWith<$Res> {
  factory _$SegmentChangedCopyWith(_SegmentChanged value, $Res Function(_SegmentChanged) _then) = __$SegmentChangedCopyWithImpl;
@useResult
$Res call({
 PerformanceSegment segment
});




}
/// @nodoc
class __$SegmentChangedCopyWithImpl<$Res>
    implements _$SegmentChangedCopyWith<$Res> {
  __$SegmentChangedCopyWithImpl(this._self, this._then);

  final _SegmentChanged _self;
  final $Res Function(_SegmentChanged) _then;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? segment = null,}) {
  return _then(_SegmentChanged(
null == segment ? _self.segment : segment // ignore: cast_nullable_to_non_nullable
as PerformanceSegment,
  ));
}


}

/// @nodoc


class _FilterChanged implements PerformanceEvent {
  const _FilterChanged(this.filter);
  

 final  PerformanceMonthFilter? filter;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilterChangedCopyWith<_FilterChanged> get copyWith => __$FilterChangedCopyWithImpl<_FilterChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilterChanged&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode {
    return Object.hash(runtimeType,filter);
}

@override
String toString() {
    return 'PerformanceEvent.filterChanged(filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$FilterChangedCopyWith<$Res> implements $PerformanceEventCopyWith<$Res> {
  factory _$FilterChangedCopyWith(_FilterChanged value, $Res Function(_FilterChanged) _then) = __$FilterChangedCopyWithImpl;
@useResult
$Res call({
 PerformanceMonthFilter? filter
});




}
/// @nodoc
class __$FilterChangedCopyWithImpl<$Res>
    implements _$FilterChangedCopyWith<$Res> {
  __$FilterChangedCopyWithImpl(this._self, this._then);

  final _FilterChanged _self;
  final $Res Function(_FilterChanged) _then;

/// Create a copy of PerformanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filter = freezed,}) {
  return _then(_FilterChanged(
freezed == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as PerformanceMonthFilter?,
  ));
}


}

/// @nodoc


class _LoadMore implements PerformanceEvent {
  const _LoadMore();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PerformanceEvent.loadMore()';
}


}




/// @nodoc
mixin _$PerformanceState {

 RequestState get state;/// A snackbar's worth: a failed month change or "load more". Reset to ''
/// at the start of each action so the same text can be raised twice.
 String get message;/// The server's code for a failed first load — `PERFORMANCE_BOARD_NOT_FOUND`
/// means "nothing to show", not "try again".
 String? get errorCode; String get communityId;/// The **first page of the current query** (segment + filter): where the
/// summary, banner, hidden count, access flag and the month list come from.
/// Replaced by every filter change, so the cards always match the list.
 PerformanceBoard? get board; List<PerformanceTrade> get items; String? get nextCursor; PerformanceSegment? get segment;/// The months asked for, or null for every month.
 PerformanceMonthFilter? get filter;/// A filter change is reloading the screen. The old cards stay (dimmed)
/// until the answer replaces them.
 bool get isListLoading; bool get isLoadingMore;
/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PerformanceStateCopyWith<PerformanceState> get copyWith => _$PerformanceStateCopyWithImpl<PerformanceState>(this as PerformanceState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PerformanceState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PerformanceState&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode)&&(identical(other.communityId, _this.communityId) || other.communityId == _this.communityId)&&(identical(other.board, _this.board) || other.board == _this.board)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.nextCursor, _this.nextCursor) || other.nextCursor == _this.nextCursor)&&(identical(other.segment, _this.segment) || other.segment == _this.segment)&&(identical(other.filter, _this.filter) || other.filter == _this.filter)&&(identical(other.isListLoading, _this.isListLoading) || other.isListLoading == _this.isListLoading)&&(identical(other.isLoadingMore, _this.isLoadingMore) || other.isLoadingMore == _this.isLoadingMore));
}


@override
int get hashCode {
  final _this = this as PerformanceState;
  return Object.hash(runtimeType,_this.state,_this.message,_this.errorCode,_this.communityId,_this.board,const DeepCollectionEquality().hash(_this.items),_this.nextCursor,_this.segment,_this.filter,_this.isListLoading,_this.isLoadingMore);
}

@override
String toString() {
  final _this = this as PerformanceState;
  return 'PerformanceState(state: ${_this.state}, message: ${_this.message}, errorCode: ${_this.errorCode}, communityId: ${_this.communityId}, board: ${_this.board}, items: ${_this.items}, nextCursor: ${_this.nextCursor}, segment: ${_this.segment}, filter: ${_this.filter}, isListLoading: ${_this.isListLoading}, isLoadingMore: ${_this.isLoadingMore})';
}


}

/// @nodoc
abstract mixin class $PerformanceStateCopyWith<$Res>  {
  factory $PerformanceStateCopyWith(PerformanceState value, $Res Function(PerformanceState) _then) = _$PerformanceStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, String message, String? errorCode, String communityId, PerformanceBoard? board, List<PerformanceTrade> items, String? nextCursor, PerformanceSegment? segment, PerformanceMonthFilter? filter, bool isListLoading, bool isLoadingMore
});




}
/// @nodoc
class _$PerformanceStateCopyWithImpl<$Res>
    implements $PerformanceStateCopyWith<$Res> {
  _$PerformanceStateCopyWithImpl(this._self, this._then);

  final PerformanceState _self;
  final $Res Function(PerformanceState) _then;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? message = null,Object? errorCode = freezed,Object? communityId = null,Object? board = freezed,Object? items = null,Object? nextCursor = freezed,Object? segment = freezed,Object? filter = freezed,Object? isListLoading = null,Object? isLoadingMore = null,}) {
  return _then(PerformanceState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,board: freezed == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as PerformanceBoard?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<PerformanceTrade>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,segment: freezed == segment ? _self.segment : segment // ignore: cast_nullable_to_non_nullable
as PerformanceSegment?,filter: freezed == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as PerformanceMonthFilter?,isListLoading: null == isListLoading ? _self.isListLoading : isListLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PerformanceState].
extension PerformanceStatePatterns on PerformanceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PerformanceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PerformanceState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PerformanceState value)  $default,){
final _that = this;
switch (_that) {
case _PerformanceState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PerformanceState value)?  $default,){
final _that = this;
switch (_that) {
case _PerformanceState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  String message,  String? errorCode,  String communityId,  PerformanceBoard? board,  List<PerformanceTrade> items,  String? nextCursor,  PerformanceSegment? segment,  PerformanceMonthFilter? filter,  bool isListLoading,  bool isLoadingMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PerformanceState() when $default != null:
return $default(_that.state,_that.message,_that.errorCode,_that.communityId,_that.board,_that.items,_that.nextCursor,_that.segment,_that.filter,_that.isListLoading,_that.isLoadingMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  String message,  String? errorCode,  String communityId,  PerformanceBoard? board,  List<PerformanceTrade> items,  String? nextCursor,  PerformanceSegment? segment,  PerformanceMonthFilter? filter,  bool isListLoading,  bool isLoadingMore)  $default,) {final _that = this;
switch (_that) {
case _PerformanceState():
return $default(_that.state,_that.message,_that.errorCode,_that.communityId,_that.board,_that.items,_that.nextCursor,_that.segment,_that.filter,_that.isListLoading,_that.isLoadingMore);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  String message,  String? errorCode,  String communityId,  PerformanceBoard? board,  List<PerformanceTrade> items,  String? nextCursor,  PerformanceSegment? segment,  PerformanceMonthFilter? filter,  bool isListLoading,  bool isLoadingMore)?  $default,) {final _that = this;
switch (_that) {
case _PerformanceState() when $default != null:
return $default(_that.state,_that.message,_that.errorCode,_that.communityId,_that.board,_that.items,_that.nextCursor,_that.segment,_that.filter,_that.isListLoading,_that.isLoadingMore);case _:
  return null;

}
}

}

/// @nodoc


class _PerformanceState extends PerformanceState {
  const _PerformanceState({this.state = RequestState.empty, this.message = '', this.errorCode, this.communityId = '', this.board,  List<PerformanceTrade> items = const <PerformanceTrade>[], this.nextCursor, this.segment, this.filter, this.isListLoading = false, this.isLoadingMore = false}): _items = items,super._();
  

@override@JsonKey() final  RequestState state;
/// A snackbar's worth: a failed month change or "load more". Reset to ''
/// at the start of each action so the same text can be raised twice.
@override@JsonKey() final  String message;
/// The server's code for a failed first load — `PERFORMANCE_BOARD_NOT_FOUND`
/// means "nothing to show", not "try again".
@override final  String? errorCode;
@override@JsonKey() final  String communityId;
/// The **first page of the current query** (segment + filter): where the
/// summary, banner, hidden count, access flag and the month list come from.
/// Replaced by every filter change, so the cards always match the list.
@override final  PerformanceBoard? board;
 final  List<PerformanceTrade> _items;
@override@JsonKey() List<PerformanceTrade> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? nextCursor;
@override final  PerformanceSegment? segment;
/// The months asked for, or null for every month.
@override final  PerformanceMonthFilter? filter;
/// A filter change is reloading the screen. The old cards stay (dimmed)
/// until the answer replaces them.
@override@JsonKey() final  bool isListLoading;
@override@JsonKey() final  bool isLoadingMore;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PerformanceStateCopyWith<_PerformanceState> get copyWith => __$PerformanceStateCopyWithImpl<_PerformanceState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PerformanceState&&(identical(other.state, state) || other.state == state)&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.communityId, communityId) || other.communityId == communityId)&&(identical(other.board, board) || other.board == board)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.segment, segment) || other.segment == segment)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.isListLoading, isListLoading) || other.isListLoading == isListLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state,message,errorCode,communityId,board,const DeepCollectionEquality().hash(_items),nextCursor,segment,filter,isListLoading,isLoadingMore);
}

@override
String toString() {
    return 'PerformanceState(state: $state, message: $message, errorCode: $errorCode, communityId: $communityId, board: $board, items: $items, nextCursor: $nextCursor, segment: $segment, filter: $filter, isListLoading: $isListLoading, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class _$PerformanceStateCopyWith<$Res> implements $PerformanceStateCopyWith<$Res> {
  factory _$PerformanceStateCopyWith(_PerformanceState value, $Res Function(_PerformanceState) _then) = __$PerformanceStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, String message, String? errorCode, String communityId, PerformanceBoard? board, List<PerformanceTrade> items, String? nextCursor, PerformanceSegment? segment, PerformanceMonthFilter? filter, bool isListLoading, bool isLoadingMore
});




}
/// @nodoc
class __$PerformanceStateCopyWithImpl<$Res>
    implements _$PerformanceStateCopyWith<$Res> {
  __$PerformanceStateCopyWithImpl(this._self, this._then);

  final _PerformanceState _self;
  final $Res Function(_PerformanceState) _then;

/// Create a copy of PerformanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? message = null,Object? errorCode = freezed,Object? communityId = null,Object? board = freezed,Object? items = null,Object? nextCursor = freezed,Object? segment = freezed,Object? filter = freezed,Object? isListLoading = null,Object? isLoadingMore = null,}) {
  return _then(_PerformanceState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,communityId: null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,board: freezed == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as PerformanceBoard?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<PerformanceTrade>,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,segment: freezed == segment ? _self.segment : segment // ignore: cast_nullable_to_non_nullable
as PerformanceSegment?,filter: freezed == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as PerformanceMonthFilter?,isListLoading: null == isListLoading ? _self.isListLoading : isListLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
