// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_filter_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedFilterEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedFilterEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'FeedFilterEvent()';
}


}

/// @nodoc
class $FeedFilterEventCopyWith<$Res>  {
$FeedFilterEventCopyWith(FeedFilterEvent _, $Res Function(FeedFilterEvent) __);
}


/// Adds pattern-matching-related methods to [FeedFilterEvent].
extension FeedFilterEventPatterns on FeedFilterEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _QueryChanged value)?  queryChanged,TResult Function( _FilterToggled value)?  filterToggled,TResult Function( _FiltersCleared value)?  filtersCleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueryChanged() when queryChanged != null:
return queryChanged(_that);case _FilterToggled() when filterToggled != null:
return filterToggled(_that);case _FiltersCleared() when filtersCleared != null:
return filtersCleared(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _QueryChanged value)  queryChanged,required TResult Function( _FilterToggled value)  filterToggled,required TResult Function( _FiltersCleared value)  filtersCleared,}){
final _that = this;
switch (_that) {
case _QueryChanged():
return queryChanged(_that);case _FilterToggled():
return filterToggled(_that);case _FiltersCleared():
return filtersCleared(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _QueryChanged value)?  queryChanged,TResult? Function( _FilterToggled value)?  filterToggled,TResult? Function( _FiltersCleared value)?  filtersCleared,}){
final _that = this;
switch (_that) {
case _QueryChanged() when queryChanged != null:
return queryChanged(_that);case _FilterToggled() when filterToggled != null:
return filterToggled(_that);case _FiltersCleared() when filtersCleared != null:
return filtersCleared(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String query)?  queryChanged,TResult Function( String filterId)?  filterToggled,TResult Function()?  filtersCleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueryChanged() when queryChanged != null:
return queryChanged(_that.query);case _FilterToggled() when filterToggled != null:
return filterToggled(_that.filterId);case _FiltersCleared() when filtersCleared != null:
return filtersCleared();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String query)  queryChanged,required TResult Function( String filterId)  filterToggled,required TResult Function()  filtersCleared,}) {final _that = this;
switch (_that) {
case _QueryChanged():
return queryChanged(_that.query);case _FilterToggled():
return filterToggled(_that.filterId);case _FiltersCleared():
return filtersCleared();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String query)?  queryChanged,TResult? Function( String filterId)?  filterToggled,TResult? Function()?  filtersCleared,}) {final _that = this;
switch (_that) {
case _QueryChanged() when queryChanged != null:
return queryChanged(_that.query);case _FilterToggled() when filterToggled != null:
return filterToggled(_that.filterId);case _FiltersCleared() when filtersCleared != null:
return filtersCleared();case _:
  return null;

}
}

}

/// @nodoc


class _QueryChanged implements FeedFilterEvent {
  const _QueryChanged(this.query);
  

 final  String query;

/// Create a copy of FeedFilterEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueryChangedCopyWith<_QueryChanged> get copyWith => __$QueryChangedCopyWithImpl<_QueryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueryChanged&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query);
}

@override
String toString() {
    return 'FeedFilterEvent.queryChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class _$QueryChangedCopyWith<$Res> implements $FeedFilterEventCopyWith<$Res> {
  factory _$QueryChangedCopyWith(_QueryChanged value, $Res Function(_QueryChanged) _then) = __$QueryChangedCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class __$QueryChangedCopyWithImpl<$Res>
    implements _$QueryChangedCopyWith<$Res> {
  __$QueryChangedCopyWithImpl(this._self, this._then);

  final _QueryChanged _self;
  final $Res Function(_QueryChanged) _then;

/// Create a copy of FeedFilterEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_QueryChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _FilterToggled implements FeedFilterEvent {
  const _FilterToggled(this.filterId);
  

 final  String filterId;

/// Create a copy of FeedFilterEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilterToggledCopyWith<_FilterToggled> get copyWith => __$FilterToggledCopyWithImpl<_FilterToggled>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilterToggled&&(identical(other.filterId, filterId) || other.filterId == filterId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,filterId);
}

@override
String toString() {
    return 'FeedFilterEvent.filterToggled(filterId: $filterId)';
}


}

/// @nodoc
abstract mixin class _$FilterToggledCopyWith<$Res> implements $FeedFilterEventCopyWith<$Res> {
  factory _$FilterToggledCopyWith(_FilterToggled value, $Res Function(_FilterToggled) _then) = __$FilterToggledCopyWithImpl;
@useResult
$Res call({
 String filterId
});




}
/// @nodoc
class __$FilterToggledCopyWithImpl<$Res>
    implements _$FilterToggledCopyWith<$Res> {
  __$FilterToggledCopyWithImpl(this._self, this._then);

  final _FilterToggled _self;
  final $Res Function(_FilterToggled) _then;

/// Create a copy of FeedFilterEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filterId = null,}) {
  return _then(_FilterToggled(
null == filterId ? _self.filterId : filterId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _FiltersCleared implements FeedFilterEvent {
  const _FiltersCleared();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FiltersCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'FeedFilterEvent.filtersCleared()';
}


}




/// @nodoc
mixin _$FeedFilterState {

 String get query; Set<String> get activeFilterIds;
/// Create a copy of FeedFilterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedFilterStateCopyWith<FeedFilterState> get copyWith => _$FeedFilterStateCopyWithImpl<FeedFilterState>(this as FeedFilterState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FeedFilterState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedFilterState&&(identical(other.query, _this.query) || other.query == _this.query)&&const DeepCollectionEquality().equals(other.activeFilterIds, _this.activeFilterIds));
}


@override
int get hashCode {
  final _this = this as FeedFilterState;
  return Object.hash(runtimeType,_this.query,const DeepCollectionEquality().hash(_this.activeFilterIds));
}

@override
String toString() {
  final _this = this as FeedFilterState;
  return 'FeedFilterState(query: ${_this.query}, activeFilterIds: ${_this.activeFilterIds})';
}


}

/// @nodoc
abstract mixin class $FeedFilterStateCopyWith<$Res>  {
  factory $FeedFilterStateCopyWith(FeedFilterState value, $Res Function(FeedFilterState) _then) = _$FeedFilterStateCopyWithImpl;
@useResult
$Res call({
 String query, Set<String> activeFilterIds
});




}
/// @nodoc
class _$FeedFilterStateCopyWithImpl<$Res>
    implements $FeedFilterStateCopyWith<$Res> {
  _$FeedFilterStateCopyWithImpl(this._self, this._then);

  final FeedFilterState _self;
  final $Res Function(FeedFilterState) _then;

/// Create a copy of FeedFilterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? activeFilterIds = null,}) {
  return _then(FeedFilterState(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,activeFilterIds: null == activeFilterIds ? _self.activeFilterIds : activeFilterIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedFilterState].
extension FeedFilterStatePatterns on FeedFilterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedFilterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedFilterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedFilterState value)  $default,){
final _that = this;
switch (_that) {
case _FeedFilterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedFilterState value)?  $default,){
final _that = this;
switch (_that) {
case _FeedFilterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  Set<String> activeFilterIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedFilterState() when $default != null:
return $default(_that.query,_that.activeFilterIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  Set<String> activeFilterIds)  $default,) {final _that = this;
switch (_that) {
case _FeedFilterState():
return $default(_that.query,_that.activeFilterIds);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  Set<String> activeFilterIds)?  $default,) {final _that = this;
switch (_that) {
case _FeedFilterState() when $default != null:
return $default(_that.query,_that.activeFilterIds);case _:
  return null;

}
}

}

/// @nodoc


class _FeedFilterState implements FeedFilterState {
  const _FeedFilterState({required this.query, required  Set<String> activeFilterIds}): _activeFilterIds = activeFilterIds;
  

@override final  String query;
 final  Set<String> _activeFilterIds;
@override Set<String> get activeFilterIds {
  if (_activeFilterIds is EqualUnmodifiableSetView) return _activeFilterIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_activeFilterIds);
}


/// Create a copy of FeedFilterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedFilterStateCopyWith<_FeedFilterState> get copyWith => __$FeedFilterStateCopyWithImpl<_FeedFilterState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedFilterState&&(identical(other.query, query) || other.query == query)&&const DeepCollectionEquality().equals(other.activeFilterIds, _activeFilterIds));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query,const DeepCollectionEquality().hash(_activeFilterIds));
}

@override
String toString() {
    return 'FeedFilterState(query: $query, activeFilterIds: $activeFilterIds)';
}


}

/// @nodoc
abstract mixin class _$FeedFilterStateCopyWith<$Res> implements $FeedFilterStateCopyWith<$Res> {
  factory _$FeedFilterStateCopyWith(_FeedFilterState value, $Res Function(_FeedFilterState) _then) = __$FeedFilterStateCopyWithImpl;
@override @useResult
$Res call({
 String query, Set<String> activeFilterIds
});




}
/// @nodoc
class __$FeedFilterStateCopyWithImpl<$Res>
    implements _$FeedFilterStateCopyWith<$Res> {
  __$FeedFilterStateCopyWithImpl(this._self, this._then);

  final _FeedFilterState _self;
  final $Res Function(_FeedFilterState) _then;

/// Create a copy of FeedFilterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? activeFilterIds = null,}) {
  return _then(_FeedFilterState(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,activeFilterIds: null == activeFilterIds ? _self._activeFilterIds : activeFilterIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

// dart format on
