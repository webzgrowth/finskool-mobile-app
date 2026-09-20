// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'communities_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CommunitiesEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunitiesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CommunitiesEvent()';
}


}

/// @nodoc
class $CommunitiesEventCopyWith<$Res>  {
$CommunitiesEventCopyWith(CommunitiesEvent _, $Res Function(CommunitiesEvent) __);
}


/// Adds pattern-matching-related methods to [CommunitiesEvent].
extension CommunitiesEventPatterns on CommunitiesEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadCommunities value)?  loadCommunities,TResult Function( _UnlockCommunity value)?  unlockCommunity,TResult Function( _RequestPricing value)?  requestPricing,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadCommunities() when loadCommunities != null:
return loadCommunities(_that);case _UnlockCommunity() when unlockCommunity != null:
return unlockCommunity(_that);case _RequestPricing() when requestPricing != null:
return requestPricing(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadCommunities value)  loadCommunities,required TResult Function( _UnlockCommunity value)  unlockCommunity,required TResult Function( _RequestPricing value)  requestPricing,}){
final _that = this;
switch (_that) {
case _LoadCommunities():
return loadCommunities(_that);case _UnlockCommunity():
return unlockCommunity(_that);case _RequestPricing():
return requestPricing(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadCommunities value)?  loadCommunities,TResult? Function( _UnlockCommunity value)?  unlockCommunity,TResult? Function( _RequestPricing value)?  requestPricing,}){
final _that = this;
switch (_that) {
case _LoadCommunities() when loadCommunities != null:
return loadCommunities(_that);case _UnlockCommunity() when unlockCommunity != null:
return unlockCommunity(_that);case _RequestPricing() when requestPricing != null:
return requestPricing(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadCommunities,TResult Function( String communityId)?  unlockCommunity,TResult Function( String communityId)?  requestPricing,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadCommunities() when loadCommunities != null:
return loadCommunities();case _UnlockCommunity() when unlockCommunity != null:
return unlockCommunity(_that.communityId);case _RequestPricing() when requestPricing != null:
return requestPricing(_that.communityId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadCommunities,required TResult Function( String communityId)  unlockCommunity,required TResult Function( String communityId)  requestPricing,}) {final _that = this;
switch (_that) {
case _LoadCommunities():
return loadCommunities();case _UnlockCommunity():
return unlockCommunity(_that.communityId);case _RequestPricing():
return requestPricing(_that.communityId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadCommunities,TResult? Function( String communityId)?  unlockCommunity,TResult? Function( String communityId)?  requestPricing,}) {final _that = this;
switch (_that) {
case _LoadCommunities() when loadCommunities != null:
return loadCommunities();case _UnlockCommunity() when unlockCommunity != null:
return unlockCommunity(_that.communityId);case _RequestPricing() when requestPricing != null:
return requestPricing(_that.communityId);case _:
  return null;

}
}

}

/// @nodoc


class _LoadCommunities implements CommunitiesEvent {
  const _LoadCommunities();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadCommunities);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CommunitiesEvent.loadCommunities()';
}


}




/// @nodoc


class _UnlockCommunity implements CommunitiesEvent {
  const _UnlockCommunity(this.communityId);
  

 final  String communityId;

/// Create a copy of CommunitiesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UnlockCommunityCopyWith<_UnlockCommunity> get copyWith => __$UnlockCommunityCopyWithImpl<_UnlockCommunity>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UnlockCommunity&&(identical(other.communityId, communityId) || other.communityId == communityId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,communityId);
}

@override
String toString() {
    return 'CommunitiesEvent.unlockCommunity(communityId: $communityId)';
}


}

/// @nodoc
abstract mixin class _$UnlockCommunityCopyWith<$Res> implements $CommunitiesEventCopyWith<$Res> {
  factory _$UnlockCommunityCopyWith(_UnlockCommunity value, $Res Function(_UnlockCommunity) _then) = __$UnlockCommunityCopyWithImpl;
@useResult
$Res call({
 String communityId
});




}
/// @nodoc
class __$UnlockCommunityCopyWithImpl<$Res>
    implements _$UnlockCommunityCopyWith<$Res> {
  __$UnlockCommunityCopyWithImpl(this._self, this._then);

  final _UnlockCommunity _self;
  final $Res Function(_UnlockCommunity) _then;

/// Create a copy of CommunitiesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,}) {
  return _then(_UnlockCommunity(
null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RequestPricing implements CommunitiesEvent {
  const _RequestPricing(this.communityId);
  

 final  String communityId;

/// Create a copy of CommunitiesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestPricingCopyWith<_RequestPricing> get copyWith => __$RequestPricingCopyWithImpl<_RequestPricing>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RequestPricing&&(identical(other.communityId, communityId) || other.communityId == communityId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,communityId);
}

@override
String toString() {
    return 'CommunitiesEvent.requestPricing(communityId: $communityId)';
}


}

/// @nodoc
abstract mixin class _$RequestPricingCopyWith<$Res> implements $CommunitiesEventCopyWith<$Res> {
  factory _$RequestPricingCopyWith(_RequestPricing value, $Res Function(_RequestPricing) _then) = __$RequestPricingCopyWithImpl;
@useResult
$Res call({
 String communityId
});




}
/// @nodoc
class __$RequestPricingCopyWithImpl<$Res>
    implements _$RequestPricingCopyWith<$Res> {
  __$RequestPricingCopyWithImpl(this._self, this._then);

  final _RequestPricing _self;
  final $Res Function(_RequestPricing) _then;

/// Create a copy of CommunitiesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = null,}) {
  return _then(_RequestPricing(
null == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$CommunitiesState {

 RequestState get state; String get message; List<CommunityModel> get communities;
/// Create a copy of CommunitiesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommunitiesStateCopyWith<CommunitiesState> get copyWith => _$CommunitiesStateCopyWithImpl<CommunitiesState>(this as CommunitiesState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CommunitiesState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommunitiesState&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.message, _this.message) || other.message == _this.message)&&const DeepCollectionEquality().equals(other.communities, _this.communities));
}


@override
int get hashCode {
  final _this = this as CommunitiesState;
  return Object.hash(runtimeType,_this.state,_this.message,const DeepCollectionEquality().hash(_this.communities));
}

@override
String toString() {
  final _this = this as CommunitiesState;
  return 'CommunitiesState(state: ${_this.state}, message: ${_this.message}, communities: ${_this.communities})';
}


}

/// @nodoc
abstract mixin class $CommunitiesStateCopyWith<$Res>  {
  factory $CommunitiesStateCopyWith(CommunitiesState value, $Res Function(CommunitiesState) _then) = _$CommunitiesStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, String message, List<CommunityModel> communities
});




}
/// @nodoc
class _$CommunitiesStateCopyWithImpl<$Res>
    implements $CommunitiesStateCopyWith<$Res> {
  _$CommunitiesStateCopyWithImpl(this._self, this._then);

  final CommunitiesState _self;
  final $Res Function(CommunitiesState) _then;

/// Create a copy of CommunitiesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? message = null,Object? communities = null,}) {
  return _then(CommunitiesState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,communities: null == communities ? _self.communities : communities // ignore: cast_nullable_to_non_nullable
as List<CommunityModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [CommunitiesState].
extension CommunitiesStatePatterns on CommunitiesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommunitiesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommunitiesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommunitiesState value)  $default,){
final _that = this;
switch (_that) {
case _CommunitiesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommunitiesState value)?  $default,){
final _that = this;
switch (_that) {
case _CommunitiesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  String message,  List<CommunityModel> communities)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommunitiesState() when $default != null:
return $default(_that.state,_that.message,_that.communities);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  String message,  List<CommunityModel> communities)  $default,) {final _that = this;
switch (_that) {
case _CommunitiesState():
return $default(_that.state,_that.message,_that.communities);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  String message,  List<CommunityModel> communities)?  $default,) {final _that = this;
switch (_that) {
case _CommunitiesState() when $default != null:
return $default(_that.state,_that.message,_that.communities);case _:
  return null;

}
}

}

/// @nodoc


class _CommunitiesState extends CommunitiesState {
  const _CommunitiesState({required this.state, required this.message, required  List<CommunityModel> communities}): _communities = communities,super._();
  

@override final  RequestState state;
@override final  String message;
 final  List<CommunityModel> _communities;
@override List<CommunityModel> get communities {
  if (_communities is EqualUnmodifiableListView) return _communities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_communities);
}


/// Create a copy of CommunitiesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunitiesStateCopyWith<_CommunitiesState> get copyWith => __$CommunitiesStateCopyWithImpl<_CommunitiesState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunitiesState&&(identical(other.state, state) || other.state == state)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.communities, _communities));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state,message,const DeepCollectionEquality().hash(_communities));
}

@override
String toString() {
    return 'CommunitiesState(state: $state, message: $message, communities: $communities)';
}


}

/// @nodoc
abstract mixin class _$CommunitiesStateCopyWith<$Res> implements $CommunitiesStateCopyWith<$Res> {
  factory _$CommunitiesStateCopyWith(_CommunitiesState value, $Res Function(_CommunitiesState) _then) = __$CommunitiesStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, String message, List<CommunityModel> communities
});




}
/// @nodoc
class __$CommunitiesStateCopyWithImpl<$Res>
    implements _$CommunitiesStateCopyWith<$Res> {
  __$CommunitiesStateCopyWithImpl(this._self, this._then);

  final _CommunitiesState _self;
  final $Res Function(_CommunitiesState) _then;

/// Create a copy of CommunitiesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? message = null,Object? communities = null,}) {
  return _then(_CommunitiesState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,communities: null == communities ? _self._communities : communities // ignore: cast_nullable_to_non_nullable
as List<CommunityModel>,
  ));
}


}

// dart format on
