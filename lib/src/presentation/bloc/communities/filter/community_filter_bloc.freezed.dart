// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'community_filter_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommunityFilterEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityFilterEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CommunityFilterEvent()';
}


}

/// @nodoc
class $CommunityFilterEventCopyWith<$Res>  {
$CommunityFilterEventCopyWith(CommunityFilterEvent _, $Res Function(CommunityFilterEvent) __);
}


/// Adds pattern-matching-related methods to [CommunityFilterEvent].
extension CommunityFilterEventPatterns on CommunityFilterEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _QueryChanged value)?  queryChanged,TResult Function( _Cleared value)?  cleared,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueryChanged() when queryChanged != null:
return queryChanged(_that);case _Cleared() when cleared != null:
return cleared(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _QueryChanged value)  queryChanged,required TResult Function( _Cleared value)  cleared,}){
final _that = this;
switch (_that) {
case _QueryChanged():
return queryChanged(_that);case _Cleared():
return cleared(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _QueryChanged value)?  queryChanged,TResult? Function( _Cleared value)?  cleared,}){
final _that = this;
switch (_that) {
case _QueryChanged() when queryChanged != null:
return queryChanged(_that);case _Cleared() when cleared != null:
return cleared(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String query)?  queryChanged,TResult Function()?  cleared,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueryChanged() when queryChanged != null:
return queryChanged(_that.query);case _Cleared() when cleared != null:
return cleared();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String query)  queryChanged,required TResult Function()  cleared,}) {final _that = this;
switch (_that) {
case _QueryChanged():
return queryChanged(_that.query);case _Cleared():
return cleared();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String query)?  queryChanged,TResult? Function()?  cleared,}) {final _that = this;
switch (_that) {
case _QueryChanged() when queryChanged != null:
return queryChanged(_that.query);case _Cleared() when cleared != null:
return cleared();case _:
  return null;

}
}

}

/// @nodoc


class _QueryChanged implements CommunityFilterEvent {
  const _QueryChanged(this.query);
  

 final  String query;

/// Create a copy of CommunityFilterEvent
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
    return 'CommunityFilterEvent.queryChanged(query: $query)';
}


}

/// @nodoc
abstract mixin class _$QueryChangedCopyWith<$Res> implements $CommunityFilterEventCopyWith<$Res> {
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

/// Create a copy of CommunityFilterEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_QueryChanged(
null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Cleared implements CommunityFilterEvent {
  const _Cleared();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CommunityFilterEvent.cleared()';
}


}




/// @nodoc
mixin _$CommunityFilterState {

 String get query;
/// Create a copy of CommunityFilterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunityFilterStateCopyWith<CommunityFilterState> get copyWith => _$CommunityFilterStateCopyWithImpl<CommunityFilterState>(this as CommunityFilterState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CommunityFilterState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunityFilterState&&(identical(other.query, _this.query) || other.query == _this.query));
}


@override
int get hashCode {
  final _this = this as CommunityFilterState;
  return Object.hash(runtimeType,_this.query);
}

@override
String toString() {
  final _this = this as CommunityFilterState;
  return 'CommunityFilterState(query: ${_this.query})';
}


}

/// @nodoc
abstract mixin class $CommunityFilterStateCopyWith<$Res>  {
  factory $CommunityFilterStateCopyWith(CommunityFilterState value, $Res Function(CommunityFilterState) _then) = _$CommunityFilterStateCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$CommunityFilterStateCopyWithImpl<$Res>
    implements $CommunityFilterStateCopyWith<$Res> {
  _$CommunityFilterStateCopyWithImpl(this._self, this._then);

  final CommunityFilterState _self;
  final $Res Function(CommunityFilterState) _then;

/// Create a copy of CommunityFilterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,}) {
  return _then(CommunityFilterState(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunityFilterState].
extension CommunityFilterStatePatterns on CommunityFilterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunityFilterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunityFilterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunityFilterState value)  $default,){
final _that = this;
switch (_that) {
case _CommunityFilterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunityFilterState value)?  $default,){
final _that = this;
switch (_that) {
case _CommunityFilterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunityFilterState() when $default != null:
return $default(_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query)  $default,) {final _that = this;
switch (_that) {
case _CommunityFilterState():
return $default(_that.query);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query)?  $default,) {final _that = this;
switch (_that) {
case _CommunityFilterState() when $default != null:
return $default(_that.query);case _:
  return null;

}
}

}

/// @nodoc


class _CommunityFilterState implements CommunityFilterState {
  const _CommunityFilterState({required this.query});
  

@override final  String query;

/// Create a copy of CommunityFilterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityFilterStateCopyWith<_CommunityFilterState> get copyWith => __$CommunityFilterStateCopyWithImpl<_CommunityFilterState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityFilterState&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query);
}

@override
String toString() {
    return 'CommunityFilterState(query: $query)';
}


}

/// @nodoc
abstract mixin class _$CommunityFilterStateCopyWith<$Res> implements $CommunityFilterStateCopyWith<$Res> {
  factory _$CommunityFilterStateCopyWith(_CommunityFilterState value, $Res Function(_CommunityFilterState) _then) = __$CommunityFilterStateCopyWithImpl;
@override @useResult
$Res call({
 String query
});




}
/// @nodoc
class __$CommunityFilterStateCopyWithImpl<$Res>
    implements _$CommunityFilterStateCopyWith<$Res> {
  __$CommunityFilterStateCopyWithImpl(this._self, this._then);

  final _CommunityFilterState _self;
  final $Res Function(_CommunityFilterState) _then;

/// Create a copy of CommunityFilterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(_CommunityFilterState(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
