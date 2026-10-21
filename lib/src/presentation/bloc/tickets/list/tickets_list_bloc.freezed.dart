// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tickets_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TicketsListEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketsListEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TicketsListEvent()';
}


}

/// @nodoc
class $TicketsListEventCopyWith<$Res>  {
$TicketsListEventCopyWith(TicketsListEvent _, $Res Function(TicketsListEvent) __);
}


/// Adds pattern-matching-related methods to [TicketsListEvent].
extension TicketsListEventPatterns on TicketsListEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Load value)?  load,TResult Function( _Refresh value)?  refresh,TResult Function( _LoadMore value)?  loadMore,TResult Function( _FilterChanged value)?  filterChanged,TResult Function( _SummaryPushed value)?  summaryPushed,TResult Function( _ReadElsewhere value)?  readElsewhere,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _Refresh() when refresh != null:
return refresh(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _FilterChanged() when filterChanged != null:
return filterChanged(_that);case _SummaryPushed() when summaryPushed != null:
return summaryPushed(_that);case _ReadElsewhere() when readElsewhere != null:
return readElsewhere(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Load value)  load,required TResult Function( _Refresh value)  refresh,required TResult Function( _LoadMore value)  loadMore,required TResult Function( _FilterChanged value)  filterChanged,required TResult Function( _SummaryPushed value)  summaryPushed,required TResult Function( _ReadElsewhere value)  readElsewhere,}){
final _that = this;
switch (_that) {
case _Load():
return load(_that);case _Refresh():
return refresh(_that);case _LoadMore():
return loadMore(_that);case _FilterChanged():
return filterChanged(_that);case _SummaryPushed():
return summaryPushed(_that);case _ReadElsewhere():
return readElsewhere(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Load value)?  load,TResult? Function( _Refresh value)?  refresh,TResult? Function( _LoadMore value)?  loadMore,TResult? Function( _FilterChanged value)?  filterChanged,TResult? Function( _SummaryPushed value)?  summaryPushed,TResult? Function( _ReadElsewhere value)?  readElsewhere,}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _Refresh() when refresh != null:
return refresh(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _FilterChanged() when filterChanged != null:
return filterChanged(_that);case _SummaryPushed() when summaryPushed != null:
return summaryPushed(_that);case _ReadElsewhere() when readElsewhere != null:
return readElsewhere(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  load,TResult Function()?  refresh,TResult Function()?  loadMore,TResult Function( TicketStatus? status)?  filterChanged,TResult Function( TicketSummaryModel summary)?  summaryPushed,TResult Function( String ticketId)?  readElsewhere,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load();case _Refresh() when refresh != null:
return refresh();case _LoadMore() when loadMore != null:
return loadMore();case _FilterChanged() when filterChanged != null:
return filterChanged(_that.status);case _SummaryPushed() when summaryPushed != null:
return summaryPushed(_that.summary);case _ReadElsewhere() when readElsewhere != null:
return readElsewhere(_that.ticketId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  load,required TResult Function()  refresh,required TResult Function()  loadMore,required TResult Function( TicketStatus? status)  filterChanged,required TResult Function( TicketSummaryModel summary)  summaryPushed,required TResult Function( String ticketId)  readElsewhere,}) {final _that = this;
switch (_that) {
case _Load():
return load();case _Refresh():
return refresh();case _LoadMore():
return loadMore();case _FilterChanged():
return filterChanged(_that.status);case _SummaryPushed():
return summaryPushed(_that.summary);case _ReadElsewhere():
return readElsewhere(_that.ticketId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  load,TResult? Function()?  refresh,TResult? Function()?  loadMore,TResult? Function( TicketStatus? status)?  filterChanged,TResult? Function( TicketSummaryModel summary)?  summaryPushed,TResult? Function( String ticketId)?  readElsewhere,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load();case _Refresh() when refresh != null:
return refresh();case _LoadMore() when loadMore != null:
return loadMore();case _FilterChanged() when filterChanged != null:
return filterChanged(_that.status);case _SummaryPushed() when summaryPushed != null:
return summaryPushed(_that.summary);case _ReadElsewhere() when readElsewhere != null:
return readElsewhere(_that.ticketId);case _:
  return null;

}
}

}

/// @nodoc


class _Load implements TicketsListEvent {
  const _Load();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Load);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TicketsListEvent.load()';
}


}




/// @nodoc


class _Refresh implements TicketsListEvent {
  const _Refresh();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Refresh);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TicketsListEvent.refresh()';
}


}




/// @nodoc


class _LoadMore implements TicketsListEvent {
  const _LoadMore();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TicketsListEvent.loadMore()';
}


}




/// @nodoc


class _FilterChanged implements TicketsListEvent {
  const _FilterChanged(this.status);
  

 final  TicketStatus? status;

/// Create a copy of TicketsListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilterChangedCopyWith<_FilterChanged> get copyWith => __$FilterChangedCopyWithImpl<_FilterChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilterChanged&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status);
}

@override
String toString() {
    return 'TicketsListEvent.filterChanged(status: $status)';
}


}

/// @nodoc
abstract mixin class _$FilterChangedCopyWith<$Res> implements $TicketsListEventCopyWith<$Res> {
  factory _$FilterChangedCopyWith(_FilterChanged value, $Res Function(_FilterChanged) _then) = __$FilterChangedCopyWithImpl;
@useResult
$Res call({
 TicketStatus? status
});




}
/// @nodoc
class __$FilterChangedCopyWithImpl<$Res>
    implements _$FilterChangedCopyWith<$Res> {
  __$FilterChangedCopyWithImpl(this._self, this._then);

  final _FilterChanged _self;
  final $Res Function(_FilterChanged) _then;

/// Create a copy of TicketsListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = freezed,}) {
  return _then(_FilterChanged(
freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TicketStatus?,
  ));
}


}

/// @nodoc


class _SummaryPushed implements TicketsListEvent {
  const _SummaryPushed(this.summary);
  

 final  TicketSummaryModel summary;

/// Create a copy of TicketsListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SummaryPushedCopyWith<_SummaryPushed> get copyWith => __$SummaryPushedCopyWithImpl<_SummaryPushed>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SummaryPushed&&(identical(other.summary, summary) || other.summary == summary));
}


@override
int get hashCode {
    return Object.hash(runtimeType,summary);
}

@override
String toString() {
    return 'TicketsListEvent.summaryPushed(summary: $summary)';
}


}

/// @nodoc
abstract mixin class _$SummaryPushedCopyWith<$Res> implements $TicketsListEventCopyWith<$Res> {
  factory _$SummaryPushedCopyWith(_SummaryPushed value, $Res Function(_SummaryPushed) _then) = __$SummaryPushedCopyWithImpl;
@useResult
$Res call({
 TicketSummaryModel summary
});




}
/// @nodoc
class __$SummaryPushedCopyWithImpl<$Res>
    implements _$SummaryPushedCopyWith<$Res> {
  __$SummaryPushedCopyWithImpl(this._self, this._then);

  final _SummaryPushed _self;
  final $Res Function(_SummaryPushed) _then;

/// Create a copy of TicketsListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? summary = null,}) {
  return _then(_SummaryPushed(
null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as TicketSummaryModel,
  ));
}


}

/// @nodoc


class _ReadElsewhere implements TicketsListEvent {
  const _ReadElsewhere(this.ticketId);
  

 final  String ticketId;

/// Create a copy of TicketsListEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReadElsewhereCopyWith<_ReadElsewhere> get copyWith => __$ReadElsewhereCopyWithImpl<_ReadElsewhere>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReadElsewhere&&(identical(other.ticketId, ticketId) || other.ticketId == ticketId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,ticketId);
}

@override
String toString() {
    return 'TicketsListEvent.readElsewhere(ticketId: $ticketId)';
}


}

/// @nodoc
abstract mixin class _$ReadElsewhereCopyWith<$Res> implements $TicketsListEventCopyWith<$Res> {
  factory _$ReadElsewhereCopyWith(_ReadElsewhere value, $Res Function(_ReadElsewhere) _then) = __$ReadElsewhereCopyWithImpl;
@useResult
$Res call({
 String ticketId
});




}
/// @nodoc
class __$ReadElsewhereCopyWithImpl<$Res>
    implements _$ReadElsewhereCopyWith<$Res> {
  __$ReadElsewhereCopyWithImpl(this._self, this._then);

  final _ReadElsewhere _self;
  final $Res Function(_ReadElsewhere) _then;

/// Create a copy of TicketsListEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticketId = null,}) {
  return _then(_ReadElsewhere(
null == ticketId ? _self.ticketId : ticketId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$TicketsListState {

 RequestState get state;/// The last failure's copy. A failed *extra page* raises it as a
/// snackbar without blanking the list already on screen.
 String get message; List<TicketModel> get tickets; bool get isLoadingMore; String? get nextCursor; TicketStatus? get filter;
/// Create a copy of TicketsListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketsListStateCopyWith<TicketsListState> get copyWith => _$TicketsListStateCopyWithImpl<TicketsListState>(this as TicketsListState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TicketsListState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketsListState&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.message, _this.message) || other.message == _this.message)&&const DeepCollectionEquality().equals(other.tickets, _this.tickets)&&(identical(other.isLoadingMore, _this.isLoadingMore) || other.isLoadingMore == _this.isLoadingMore)&&(identical(other.nextCursor, _this.nextCursor) || other.nextCursor == _this.nextCursor)&&(identical(other.filter, _this.filter) || other.filter == _this.filter));
}


@override
int get hashCode {
  final _this = this as TicketsListState;
  return Object.hash(runtimeType,_this.state,_this.message,const DeepCollectionEquality().hash(_this.tickets),_this.isLoadingMore,_this.nextCursor,_this.filter);
}

@override
String toString() {
  final _this = this as TicketsListState;
  return 'TicketsListState(state: ${_this.state}, message: ${_this.message}, tickets: ${_this.tickets}, isLoadingMore: ${_this.isLoadingMore}, nextCursor: ${_this.nextCursor}, filter: ${_this.filter})';
}


}

/// @nodoc
abstract mixin class $TicketsListStateCopyWith<$Res>  {
  factory $TicketsListStateCopyWith(TicketsListState value, $Res Function(TicketsListState) _then) = _$TicketsListStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, String message, List<TicketModel> tickets, bool isLoadingMore, String? nextCursor, TicketStatus? filter
});




}
/// @nodoc
class _$TicketsListStateCopyWithImpl<$Res>
    implements $TicketsListStateCopyWith<$Res> {
  _$TicketsListStateCopyWithImpl(this._self, this._then);

  final TicketsListState _self;
  final $Res Function(TicketsListState) _then;

/// Create a copy of TicketsListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? message = null,Object? tickets = null,Object? isLoadingMore = null,Object? nextCursor = freezed,Object? filter = freezed,}) {
  return _then(TicketsListState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,tickets: null == tickets ? _self.tickets : tickets // ignore: cast_nullable_to_non_nullable
as List<TicketModel>,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,filter: freezed == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as TicketStatus?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketsListState].
extension TicketsListStatePatterns on TicketsListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketsListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketsListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketsListState value)  $default,){
final _that = this;
switch (_that) {
case _TicketsListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketsListState value)?  $default,){
final _that = this;
switch (_that) {
case _TicketsListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  String message,  List<TicketModel> tickets,  bool isLoadingMore,  String? nextCursor,  TicketStatus? filter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketsListState() when $default != null:
return $default(_that.state,_that.message,_that.tickets,_that.isLoadingMore,_that.nextCursor,_that.filter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  String message,  List<TicketModel> tickets,  bool isLoadingMore,  String? nextCursor,  TicketStatus? filter)  $default,) {final _that = this;
switch (_that) {
case _TicketsListState():
return $default(_that.state,_that.message,_that.tickets,_that.isLoadingMore,_that.nextCursor,_that.filter);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  String message,  List<TicketModel> tickets,  bool isLoadingMore,  String? nextCursor,  TicketStatus? filter)?  $default,) {final _that = this;
switch (_that) {
case _TicketsListState() when $default != null:
return $default(_that.state,_that.message,_that.tickets,_that.isLoadingMore,_that.nextCursor,_that.filter);case _:
  return null;

}
}

}

/// @nodoc


class _TicketsListState extends TicketsListState {
  const _TicketsListState({required this.state, required this.message, required  List<TicketModel> tickets, required this.isLoadingMore, this.nextCursor, this.filter}): _tickets = tickets,super._();
  

@override final  RequestState state;
/// The last failure's copy. A failed *extra page* raises it as a
/// snackbar without blanking the list already on screen.
@override final  String message;
 final  List<TicketModel> _tickets;
@override List<TicketModel> get tickets {
  if (_tickets is EqualUnmodifiableListView) return _tickets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tickets);
}

@override final  bool isLoadingMore;
@override final  String? nextCursor;
@override final  TicketStatus? filter;

/// Create a copy of TicketsListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketsListStateCopyWith<_TicketsListState> get copyWith => __$TicketsListStateCopyWithImpl<_TicketsListState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketsListState&&(identical(other.state, state) || other.state == state)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.tickets, _tickets)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.nextCursor, nextCursor) || other.nextCursor == nextCursor)&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state,message,const DeepCollectionEquality().hash(_tickets),isLoadingMore,nextCursor,filter);
}

@override
String toString() {
    return 'TicketsListState(state: $state, message: $message, tickets: $tickets, isLoadingMore: $isLoadingMore, nextCursor: $nextCursor, filter: $filter)';
}


}

/// @nodoc
abstract mixin class _$TicketsListStateCopyWith<$Res> implements $TicketsListStateCopyWith<$Res> {
  factory _$TicketsListStateCopyWith(_TicketsListState value, $Res Function(_TicketsListState) _then) = __$TicketsListStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, String message, List<TicketModel> tickets, bool isLoadingMore, String? nextCursor, TicketStatus? filter
});




}
/// @nodoc
class __$TicketsListStateCopyWithImpl<$Res>
    implements _$TicketsListStateCopyWith<$Res> {
  __$TicketsListStateCopyWithImpl(this._self, this._then);

  final _TicketsListState _self;
  final $Res Function(_TicketsListState) _then;

/// Create a copy of TicketsListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? message = null,Object? tickets = null,Object? isLoadingMore = null,Object? nextCursor = freezed,Object? filter = freezed,}) {
  return _then(_TicketsListState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,tickets: null == tickets ? _self._tickets : tickets // ignore: cast_nullable_to_non_nullable
as List<TicketModel>,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,nextCursor: freezed == nextCursor ? _self.nextCursor : nextCursor // ignore: cast_nullable_to_non_nullable
as String?,filter: freezed == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as TicketStatus?,
  ));
}


}

// dart format on
