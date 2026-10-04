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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadFeed value)?  loadFeed,TResult Function( _RefreshFeed value)?  refreshFeed,TResult Function( _LoadMore value)?  loadMore,TResult Function( _ReactToPost value)?  reactToPost,TResult Function( _RemoveReaction value)?  removeReaction,TResult Function( _ReactionsHydrated value)?  reactionsHydrated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadFeed() when loadFeed != null:
return loadFeed(_that);case _RefreshFeed() when refreshFeed != null:
return refreshFeed(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _ReactToPost() when reactToPost != null:
return reactToPost(_that);case _RemoveReaction() when removeReaction != null:
return removeReaction(_that);case _ReactionsHydrated() when reactionsHydrated != null:
return reactionsHydrated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadFeed value)  loadFeed,required TResult Function( _RefreshFeed value)  refreshFeed,required TResult Function( _LoadMore value)  loadMore,required TResult Function( _ReactToPost value)  reactToPost,required TResult Function( _RemoveReaction value)  removeReaction,required TResult Function( _ReactionsHydrated value)  reactionsHydrated,}){
final _that = this;
switch (_that) {
case _LoadFeed():
return loadFeed(_that);case _RefreshFeed():
return refreshFeed(_that);case _LoadMore():
return loadMore(_that);case _ReactToPost():
return reactToPost(_that);case _RemoveReaction():
return removeReaction(_that);case _ReactionsHydrated():
return reactionsHydrated(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadFeed value)?  loadFeed,TResult? Function( _RefreshFeed value)?  refreshFeed,TResult? Function( _LoadMore value)?  loadMore,TResult? Function( _ReactToPost value)?  reactToPost,TResult? Function( _RemoveReaction value)?  removeReaction,TResult? Function( _ReactionsHydrated value)?  reactionsHydrated,}){
final _that = this;
switch (_that) {
case _LoadFeed() when loadFeed != null:
return loadFeed(_that);case _RefreshFeed() when refreshFeed != null:
return refreshFeed(_that);case _LoadMore() when loadMore != null:
return loadMore(_that);case _ReactToPost() when reactToPost != null:
return reactToPost(_that);case _RemoveReaction() when removeReaction != null:
return removeReaction(_that);case _ReactionsHydrated() when reactionsHydrated != null:
return reactionsHydrated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? communityId)?  loadFeed,TResult Function()?  refreshFeed,TResult Function()?  loadMore,TResult Function( String postId,  ReactionType reaction)?  reactToPost,TResult Function( String postId)?  removeReaction,TResult Function( int generation,  String postId,  List<ReactorModel> reactors)?  reactionsHydrated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadFeed() when loadFeed != null:
return loadFeed(_that.communityId);case _RefreshFeed() when refreshFeed != null:
return refreshFeed();case _LoadMore() when loadMore != null:
return loadMore();case _ReactToPost() when reactToPost != null:
return reactToPost(_that.postId,_that.reaction);case _RemoveReaction() when removeReaction != null:
return removeReaction(_that.postId);case _ReactionsHydrated() when reactionsHydrated != null:
return reactionsHydrated(_that.generation,_that.postId,_that.reactors);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? communityId)  loadFeed,required TResult Function()  refreshFeed,required TResult Function()  loadMore,required TResult Function( String postId,  ReactionType reaction)  reactToPost,required TResult Function( String postId)  removeReaction,required TResult Function( int generation,  String postId,  List<ReactorModel> reactors)  reactionsHydrated,}) {final _that = this;
switch (_that) {
case _LoadFeed():
return loadFeed(_that.communityId);case _RefreshFeed():
return refreshFeed();case _LoadMore():
return loadMore();case _ReactToPost():
return reactToPost(_that.postId,_that.reaction);case _RemoveReaction():
return removeReaction(_that.postId);case _ReactionsHydrated():
return reactionsHydrated(_that.generation,_that.postId,_that.reactors);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? communityId)?  loadFeed,TResult? Function()?  refreshFeed,TResult? Function()?  loadMore,TResult? Function( String postId,  ReactionType reaction)?  reactToPost,TResult? Function( String postId)?  removeReaction,TResult? Function( int generation,  String postId,  List<ReactorModel> reactors)?  reactionsHydrated,}) {final _that = this;
switch (_that) {
case _LoadFeed() when loadFeed != null:
return loadFeed(_that.communityId);case _RefreshFeed() when refreshFeed != null:
return refreshFeed();case _LoadMore() when loadMore != null:
return loadMore();case _ReactToPost() when reactToPost != null:
return reactToPost(_that.postId,_that.reaction);case _RemoveReaction() when removeReaction != null:
return removeReaction(_that.postId);case _ReactionsHydrated() when reactionsHydrated != null:
return reactionsHydrated(_that.generation,_that.postId,_that.reactors);case _:
  return null;

}
}

}

/// @nodoc


class _LoadFeed implements FeedEvent {
  const _LoadFeed({this.communityId});
  

 final  String? communityId;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadFeedCopyWith<_LoadFeed> get copyWith => __$LoadFeedCopyWithImpl<_LoadFeed>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadFeed&&(identical(other.communityId, communityId) || other.communityId == communityId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,communityId);
}

@override
String toString() {
    return 'FeedEvent.loadFeed(communityId: $communityId)';
}


}

/// @nodoc
abstract mixin class _$LoadFeedCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory _$LoadFeedCopyWith(_LoadFeed value, $Res Function(_LoadFeed) _then) = __$LoadFeedCopyWithImpl;
@useResult
$Res call({
 String? communityId
});




}
/// @nodoc
class __$LoadFeedCopyWithImpl<$Res>
    implements _$LoadFeedCopyWith<$Res> {
  __$LoadFeedCopyWithImpl(this._self, this._then);

  final _LoadFeed _self;
  final $Res Function(_LoadFeed) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? communityId = freezed,}) {
  return _then(_LoadFeed(
communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _RefreshFeed implements FeedEvent {
  const _RefreshFeed();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RefreshFeed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'FeedEvent.refreshFeed()';
}


}




/// @nodoc


class _LoadMore implements FeedEvent {
  const _LoadMore();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadMore);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'FeedEvent.loadMore()';
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


class _ReactionsHydrated implements FeedEvent {
  const _ReactionsHydrated({required this.generation, required this.postId, required  List<ReactorModel> reactors}): _reactors = reactors;
  

 final  int generation;
 final  String postId;
 final  List<ReactorModel> _reactors;
 List<ReactorModel> get reactors {
  if (_reactors is EqualUnmodifiableListView) return _reactors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reactors);
}


/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReactionsHydratedCopyWith<_ReactionsHydrated> get copyWith => __$ReactionsHydratedCopyWithImpl<_ReactionsHydrated>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReactionsHydrated&&(identical(other.generation, generation) || other.generation == generation)&&(identical(other.postId, postId) || other.postId == postId)&&const DeepCollectionEquality().equals(other.reactors, _reactors));
}


@override
int get hashCode {
    return Object.hash(runtimeType,generation,postId,const DeepCollectionEquality().hash(_reactors));
}

@override
String toString() {
    return 'FeedEvent.reactionsHydrated(generation: $generation, postId: $postId, reactors: $reactors)';
}


}

/// @nodoc
abstract mixin class _$ReactionsHydratedCopyWith<$Res> implements $FeedEventCopyWith<$Res> {
  factory _$ReactionsHydratedCopyWith(_ReactionsHydrated value, $Res Function(_ReactionsHydrated) _then) = __$ReactionsHydratedCopyWithImpl;
@useResult
$Res call({
 int generation, String postId, List<ReactorModel> reactors
});




}
/// @nodoc
class __$ReactionsHydratedCopyWithImpl<$Res>
    implements _$ReactionsHydratedCopyWith<$Res> {
  __$ReactionsHydratedCopyWithImpl(this._self, this._then);

  final _ReactionsHydrated _self;
  final $Res Function(_ReactionsHydrated) _then;

/// Create a copy of FeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? generation = null,Object? postId = null,Object? reactors = null,}) {
  return _then(_ReactionsHydrated(
generation: null == generation ? _self.generation : generation // ignore: cast_nullable_to_non_nullable
as int,postId: null == postId ? _self.postId : postId // ignore: cast_nullable_to_non_nullable
as String,reactors: null == reactors ? _self._reactors : reactors // ignore: cast_nullable_to_non_nullable
as List<ReactorModel>,
  ));
}


}

/// @nodoc
mixin _$FeedState {

 RequestState get state;/// The last failure's copy. Shown as a snackbar rather than replacing the
/// list, so a failed reaction or a failed extra page doesn't wipe the
/// feed that's already rendered.
 String get message; List<FeedPostModel> get posts; int get page; bool get hasMore; bool get isLoadingMore; String? get communityId;
/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedStateCopyWith<FeedState> get copyWith => _$FeedStateCopyWithImpl<FeedState>(this as FeedState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as FeedState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedState&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.message, _this.message) || other.message == _this.message)&&const DeepCollectionEquality().equals(other.posts, _this.posts)&&(identical(other.page, _this.page) || other.page == _this.page)&&(identical(other.hasMore, _this.hasMore) || other.hasMore == _this.hasMore)&&(identical(other.isLoadingMore, _this.isLoadingMore) || other.isLoadingMore == _this.isLoadingMore)&&(identical(other.communityId, _this.communityId) || other.communityId == _this.communityId));
}


@override
int get hashCode {
  final _this = this as FeedState;
  return Object.hash(runtimeType,_this.state,_this.message,const DeepCollectionEquality().hash(_this.posts),_this.page,_this.hasMore,_this.isLoadingMore,_this.communityId);
}

@override
String toString() {
  final _this = this as FeedState;
  return 'FeedState(state: ${_this.state}, message: ${_this.message}, posts: ${_this.posts}, page: ${_this.page}, hasMore: ${_this.hasMore}, isLoadingMore: ${_this.isLoadingMore}, communityId: ${_this.communityId})';
}


}

/// @nodoc
abstract mixin class $FeedStateCopyWith<$Res>  {
  factory $FeedStateCopyWith(FeedState value, $Res Function(FeedState) _then) = _$FeedStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, String message, List<FeedPostModel> posts, int page, bool hasMore, bool isLoadingMore, String? communityId
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
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? message = null,Object? posts = null,Object? page = null,Object? hasMore = null,Object? isLoadingMore = null,Object? communityId = freezed,}) {
  return _then(FeedState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,posts: null == posts ? _self.posts : posts // ignore: cast_nullable_to_non_nullable
as List<FeedPostModel>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  String message,  List<FeedPostModel> posts,  int page,  bool hasMore,  bool isLoadingMore,  String? communityId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedState() when $default != null:
return $default(_that.state,_that.message,_that.posts,_that.page,_that.hasMore,_that.isLoadingMore,_that.communityId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  String message,  List<FeedPostModel> posts,  int page,  bool hasMore,  bool isLoadingMore,  String? communityId)  $default,) {final _that = this;
switch (_that) {
case _FeedState():
return $default(_that.state,_that.message,_that.posts,_that.page,_that.hasMore,_that.isLoadingMore,_that.communityId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  String message,  List<FeedPostModel> posts,  int page,  bool hasMore,  bool isLoadingMore,  String? communityId)?  $default,) {final _that = this;
switch (_that) {
case _FeedState() when $default != null:
return $default(_that.state,_that.message,_that.posts,_that.page,_that.hasMore,_that.isLoadingMore,_that.communityId);case _:
  return null;

}
}

}

/// @nodoc


class _FeedState extends FeedState {
  const _FeedState({required this.state, required this.message, required  List<FeedPostModel> posts, required this.page, required this.hasMore, required this.isLoadingMore, this.communityId}): _posts = posts,super._();
  

@override final  RequestState state;
/// The last failure's copy. Shown as a snackbar rather than replacing the
/// list, so a failed reaction or a failed extra page doesn't wipe the
/// feed that's already rendered.
@override final  String message;
 final  List<FeedPostModel> _posts;
@override List<FeedPostModel> get posts {
  if (_posts is EqualUnmodifiableListView) return _posts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_posts);
}

@override final  int page;
@override final  bool hasMore;
@override final  bool isLoadingMore;
@override final  String? communityId;

/// Create a copy of FeedState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedStateCopyWith<_FeedState> get copyWith => __$FeedStateCopyWithImpl<_FeedState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedState&&(identical(other.state, state) || other.state == state)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.posts, _posts)&&(identical(other.page, page) || other.page == page)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.communityId, communityId) || other.communityId == communityId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state,message,const DeepCollectionEquality().hash(_posts),page,hasMore,isLoadingMore,communityId);
}

@override
String toString() {
    return 'FeedState(state: $state, message: $message, posts: $posts, page: $page, hasMore: $hasMore, isLoadingMore: $isLoadingMore, communityId: $communityId)';
}


}

/// @nodoc
abstract mixin class _$FeedStateCopyWith<$Res> implements $FeedStateCopyWith<$Res> {
  factory _$FeedStateCopyWith(_FeedState value, $Res Function(_FeedState) _then) = __$FeedStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, String message, List<FeedPostModel> posts, int page, bool hasMore, bool isLoadingMore, String? communityId
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
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? message = null,Object? posts = null,Object? page = null,Object? hasMore = null,Object? isLoadingMore = null,Object? communityId = freezed,}) {
  return _then(_FeedState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,posts: null == posts ? _self._posts : posts // ignore: cast_nullable_to_non_nullable
as List<FeedPostModel>,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,communityId: freezed == communityId ? _self.communityId : communityId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
