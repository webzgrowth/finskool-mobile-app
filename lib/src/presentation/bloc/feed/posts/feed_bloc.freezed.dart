// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FeedEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'FeedEvent()';
}


}

/// @nodoc
class $FeedEventCopyWith<$Res>  {
$FeedEventCopyWith(FeedEvent _, $Res Function(FeedEvent) __);
}


/// Adds pattern-matching-related methods to [FeedEvent].
extension FeedEventPatterns on FeedEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadFeed value)?  loadFeed,TResult Function( _ReactToPost value)?  reactToPost,TResult Function( _RemoveReaction value)?  removeReaction,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadFeed() when loadFeed != null:
return loadFeed(_that);case _ReactToPost() when reactToPost != null:
return reactToPost(_that);case _RemoveReaction() when removeReaction != null:
return removeReaction(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadFeed value)  loadFeed,required TResult Function( _ReactToPost value)  reactToPost,required TResult Function( _RemoveReaction value)  removeReaction,}){
final _that = this;
switch (_that) {
case _LoadFeed():
return loadFeed(_that);case _ReactToPost():
return reactToPost(_that);case _RemoveReaction():
return removeReaction(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadFeed value)?  loadFeed,TResult? Function( _ReactToPost value)?  reactToPost,TResult? Function( _RemoveReaction value)?  removeReaction,}){
final _that = this;
switch (_that) {
case _LoadFeed() when loadFeed != null:
return loadFeed(_that);case _ReactToPost() when reactToPost != null:
return reactToPost(_that);case _RemoveReaction() when removeReaction != null:
return removeReaction(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadFeed,TResult Function( String postId,  ReactionType reaction)?  reactToPost,TResult Function( String postId)?  removeReaction,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadFeed() when loadFeed != null:
return loadFeed();case _ReactToPost() when reactToPost != null:
return reactToPost(_that.postId,_that.reaction);case _RemoveReaction() when removeReaction != null:
return removeReaction(_that.postId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadFeed,required TResult Function( String postId,  ReactionType reaction)  reactToPost,required TResult Function( String postId)  removeReaction,}) {final _that = this;
switch (_that) {
case _LoadFeed():
return loadFeed();case _ReactToPost():
return reactToPost(_that.postId,_that.reaction);case _RemoveReaction():
return removeReaction(_that.postId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadFeed,TResult? Function( String postId,  ReactionType reaction)?  reactToPost,TResult? Function( String postId)?  removeReaction,}) {final _that = this;
switch (_that) {
case _LoadFeed() when loadFeed != null:
return loadFeed();case _ReactToPost() when reactToPost != null:
return reactToPost(_that.postId,_that.reaction);case _RemoveReaction() when removeReaction != null:
return removeReaction(_that.postId);case _:
  return null;

}
}

}

/// @nodoc


class _LoadFeed implements FeedEvent {
  const _LoadFeed();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadFeed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'FeedEvent.loadFeed()';
}


}




/// @nodoc


class _ReactToPost implements FeedEvent {
  const _ReactToPost({required this.postId, required this.reaction});
  

 final  String postId;
 final  ReactionType reaction;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReactToPostCopyWith<_ReactToPost> get copyWith => __$ReactToPostCopyWithImpl<_ReactToPost>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReactToPost&&(identical(other.postId, postId) || other.postId == postId)&&(identical(other.reaction, reaction) || other.reaction == reaction));
}


@override
int get hashCode {
    return Object.hash(runtimeType,postId,reaction);
}

@override
String toString() {
    return 'FeedEvent.reactToPost(postId: $postId, reaction: $reaction)';
}


}

/// @nodoc
abstract mixin class _$ReactToPostCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory _$ReactToPostCopyWith(_ReactToPost value, $Res Function(_ReactToPost) _then) = __$ReactToPostCopyWithImpl;
@useResult
$Res call({
 String postId, ReactionType reaction
});




}
/// @nodoc
class __$ReactToPostCopyWithImpl<$Res>
    implements _$ReactToPostCopyWith<$Res> {
  __$ReactToPostCopyWithImpl(this._self, this._then);

  final _ReactToPost _self;
  final $Res Function(_ReactToPost) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? postId = null,Object? reaction = null,}) {
  return _then(_ReactToPost(
postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,reaction: null == reaction ? _self.reaction : reaction // ignore: cast_nullable_to_non_nullable
as ReactionType,
  ));
}


}

/// @nodoc


class _RemoveReaction implements FeedEvent {
  const _RemoveReaction({required this.postId});
  

 final  String postId;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RemoveReactionCopyWith<_RemoveReaction> get copyWith => __$RemoveReactionCopyWithImpl<_RemoveReaction>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RemoveReaction&&(identical(other.postId, postId) || other.postId == postId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,postId);
}

@override
String toString() {
    return 'FeedEvent.removeReaction(postId: $postId)';
}


}

/// @nodoc
abstract mixin class _$RemoveReactionCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory _$RemoveReactionCopyWith(_RemoveReaction value, $Res Function(_RemoveReaction) _then) = __$RemoveReactionCopyWithImpl;
@useResult
$Res call({
 String postId
});




}
/// @nodoc
class __$RemoveReactionCopyWithImpl<$Res>
    implements _$RemoveReactionCopyWith<$Res> {
  __$RemoveReactionCopyWithImpl(this._self, this._then);

  final _RemoveReaction _self;
  final $Res Function(_RemoveReaction) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? postId = null,}) {
  return _then(_RemoveReaction(
postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$FeedState {

 RequestState get state; List<FeedPostModel> get posts;
/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedStateCopyWith<FeedState> get copyWith => _$FeedStateCopyWithImpl<FeedState>(this as FeedState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FeedState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedState&&(identical(other.state, _this.state) || other.state == _this.state)&&const DeepCollectionEquality().equals(other.posts, _this.posts));
}


@override
int get hashCode {
  final _this = this as FeedState;
  return Object.hash(runtimeType,_this.state,const DeepCollectionEquality().hash(_this.posts));
}

@override
String toString() {
  final _this = this as FeedState;
  return 'FeedState(state: ${_this.state}, posts: ${_this.posts})';
}


}

/// @nodoc
abstract mixin class $FeedStateCopyWith<$Res>  {
  factory $FeedStateCopyWith(FeedState value, $Res Function(FeedState) _then) = _$FeedStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, List<FeedPostModel> posts
});




}
/// @nodoc
class _$FeedStateCopyWithImpl<$Res>
    implements $FeedStateCopyWith<$Res> {
  _$FeedStateCopyWithImpl(this._self, this._then);

  final FeedState _self;
  final $Res Function(FeedState) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? posts = null,}) {
  return _then(FeedState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<FeedPostModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedState].
extension FeedStatePatterns on FeedState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedState value)  $default,){
final _that = this;
switch (_that) {
case _FeedState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedState value)?  $default,){
final _that = this;
switch (_that) {
case _FeedState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  List<FeedPostModel> posts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedState() when $default != null:
return $default(_that.state,_that.posts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  List<FeedPostModel> posts)  $default,) {final _that = this;
switch (_that) {
case _FeedState():
return $default(_that.state,_that.posts);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  List<FeedPostModel> posts)?  $default,) {final _that = this;
switch (_that) {
case _FeedState() when $default != null:
return $default(_that.state,_that.posts);case _:
  return null;

}
}

}

/// @nodoc


class _FeedState implements FeedState {
  const _FeedState({required this.state, required  List<FeedPostModel> posts}): _posts = posts;
  

@override final  RequestState state;
 final  List<FeedPostModel> _posts;
@override List<FeedPostModel> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}


/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedStateCopyWith<_FeedState> get copyWith => __$FeedStateCopyWithImpl<_FeedState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedState&&(identical(other.state, state) || other.state == state)&&const DeepCollectionEquality().equals(other.posts, _posts));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state,const DeepCollectionEquality().hash(_posts));
}

@override
String toString() {
    return 'FeedState(state: $state, posts: $posts)';
}


}

/// @nodoc
abstract mixin class _$FeedStateCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory _$FeedStateCopyWith(_FeedState value, $Res Function(_FeedState) _then) = __$FeedStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, List<FeedPostModel> posts
});




}
/// @nodoc
class __$FeedStateCopyWithImpl<$Res>
    implements _$FeedStateCopyWith<$Res> {
  __$FeedStateCopyWithImpl(this._self, this._then);

  final _FeedState _self;
  final $Res Function(_FeedState) _then;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? posts = null,}) {
  return _then(_FeedState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<FeedPostModel>,
  ));
}


}

// dart format on
