// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_form_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TicketFormEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketFormEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TicketFormEvent()';
}


}

/// @nodoc
class $TicketFormEventCopyWith<$Res>  {
$TicketFormEventCopyWith(TicketFormEvent _, $Res Function(TicketFormEvent) __);
}


/// Adds pattern-matching-related methods to [TicketFormEvent].
extension TicketFormEventPatterns on TicketFormEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _CommunityChanged value)?  communityChanged,TResult Function( _CategoryChanged value)?  categoryChanged,TResult Function( _TypeChanged value)?  typeChanged,TResult Function( _SubjectChanged value)?  subjectChanged,TResult Function( _DescriptionChanged value)?  descriptionChanged,TResult Function( _FileAdded value)?  fileAdded,TResult Function( _FileRemoved value)?  fileRemoved,TResult Function( _Submitted value)?  submitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _CommunityChanged() when communityChanged != null:
return communityChanged(_that);case _CategoryChanged() when categoryChanged != null:
return categoryChanged(_that);case _TypeChanged() when typeChanged != null:
return typeChanged(_that);case _SubjectChanged() when subjectChanged != null:
return subjectChanged(_that);case _DescriptionChanged() when descriptionChanged != null:
return descriptionChanged(_that);case _FileAdded() when fileAdded != null:
return fileAdded(_that);case _FileRemoved() when fileRemoved != null:
return fileRemoved(_that);case _Submitted() when submitted != null:
return submitted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _CommunityChanged value)  communityChanged,required TResult Function( _CategoryChanged value)  categoryChanged,required TResult Function( _TypeChanged value)  typeChanged,required TResult Function( _SubjectChanged value)  subjectChanged,required TResult Function( _DescriptionChanged value)  descriptionChanged,required TResult Function( _FileAdded value)  fileAdded,required TResult Function( _FileRemoved value)  fileRemoved,required TResult Function( _Submitted value)  submitted,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _CommunityChanged():
return communityChanged(_that);case _CategoryChanged():
return categoryChanged(_that);case _TypeChanged():
return typeChanged(_that);case _SubjectChanged():
return subjectChanged(_that);case _DescriptionChanged():
return descriptionChanged(_that);case _FileAdded():
return fileAdded(_that);case _FileRemoved():
return fileRemoved(_that);case _Submitted():
return submitted(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _CommunityChanged value)?  communityChanged,TResult? Function( _CategoryChanged value)?  categoryChanged,TResult? Function( _TypeChanged value)?  typeChanged,TResult? Function( _SubjectChanged value)?  subjectChanged,TResult? Function( _DescriptionChanged value)?  descriptionChanged,TResult? Function( _FileAdded value)?  fileAdded,TResult? Function( _FileRemoved value)?  fileRemoved,TResult? Function( _Submitted value)?  submitted,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _CommunityChanged() when communityChanged != null:
return communityChanged(_that);case _CategoryChanged() when categoryChanged != null:
return categoryChanged(_that);case _TypeChanged() when typeChanged != null:
return typeChanged(_that);case _SubjectChanged() when subjectChanged != null:
return subjectChanged(_that);case _DescriptionChanged() when descriptionChanged != null:
return descriptionChanged(_that);case _FileAdded() when fileAdded != null:
return fileAdded(_that);case _FileRemoved() when fileRemoved != null:
return fileRemoved(_that);case _Submitted() when submitted != null:
return submitted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( TicketCommunityModel c)?  communityChanged,TResult Function( TicketCategory c)?  categoryChanged,TResult Function( TicketType t)?  typeChanged,TResult Function( String value)?  subjectChanged,TResult Function( String value)?  descriptionChanged,TResult Function( File file,  String? name)?  fileAdded,TResult Function( String draftId)?  fileRemoved,TResult Function()?  submitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _CommunityChanged() when communityChanged != null:
return communityChanged(_that.c);case _CategoryChanged() when categoryChanged != null:
return categoryChanged(_that.c);case _TypeChanged() when typeChanged != null:
return typeChanged(_that.t);case _SubjectChanged() when subjectChanged != null:
return subjectChanged(_that.value);case _DescriptionChanged() when descriptionChanged != null:
return descriptionChanged(_that.value);case _FileAdded() when fileAdded != null:
return fileAdded(_that.file,_that.name);case _FileRemoved() when fileRemoved != null:
return fileRemoved(_that.draftId);case _Submitted() when submitted != null:
return submitted();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( TicketCommunityModel c)  communityChanged,required TResult Function( TicketCategory c)  categoryChanged,required TResult Function( TicketType t)  typeChanged,required TResult Function( String value)  subjectChanged,required TResult Function( String value)  descriptionChanged,required TResult Function( File file,  String? name)  fileAdded,required TResult Function( String draftId)  fileRemoved,required TResult Function()  submitted,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _CommunityChanged():
return communityChanged(_that.c);case _CategoryChanged():
return categoryChanged(_that.c);case _TypeChanged():
return typeChanged(_that.t);case _SubjectChanged():
return subjectChanged(_that.value);case _DescriptionChanged():
return descriptionChanged(_that.value);case _FileAdded():
return fileAdded(_that.file,_that.name);case _FileRemoved():
return fileRemoved(_that.draftId);case _Submitted():
return submitted();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( TicketCommunityModel c)?  communityChanged,TResult? Function( TicketCategory c)?  categoryChanged,TResult? Function( TicketType t)?  typeChanged,TResult? Function( String value)?  subjectChanged,TResult? Function( String value)?  descriptionChanged,TResult? Function( File file,  String? name)?  fileAdded,TResult? Function( String draftId)?  fileRemoved,TResult? Function()?  submitted,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _CommunityChanged() when communityChanged != null:
return communityChanged(_that.c);case _CategoryChanged() when categoryChanged != null:
return categoryChanged(_that.c);case _TypeChanged() when typeChanged != null:
return typeChanged(_that.t);case _SubjectChanged() when subjectChanged != null:
return subjectChanged(_that.value);case _DescriptionChanged() when descriptionChanged != null:
return descriptionChanged(_that.value);case _FileAdded() when fileAdded != null:
return fileAdded(_that.file,_that.name);case _FileRemoved() when fileRemoved != null:
return fileRemoved(_that.draftId);case _Submitted() when submitted != null:
return submitted();case _:
  return null;

}
}

}

/// @nodoc


class _Started implements TicketFormEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TicketFormEvent.started()';
}


}




/// @nodoc


class _CommunityChanged implements TicketFormEvent {
  const _CommunityChanged(this.c);
  

 final  TicketCommunityModel c;

/// Create a copy of TicketFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommunityChangedCopyWith<_CommunityChanged> get copyWith => __$CommunityChangedCopyWithImpl<_CommunityChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommunityChanged&&(identical(other.c, c) || other.c == c));
}


@override
int get hashCode {
    return Object.hash(runtimeType,c);
}

@override
String toString() {
    return 'TicketFormEvent.communityChanged(c: $c)';
}


}

/// @nodoc
abstract mixin class _$CommunityChangedCopyWith<$Res> implements $TicketFormEventCopyWith<$Res> {
  factory _$CommunityChangedCopyWith(_CommunityChanged value, $Res Function(_CommunityChanged) _then) = __$CommunityChangedCopyWithImpl;
@useResult
$Res call({
 TicketCommunityModel c
});




}
/// @nodoc
class __$CommunityChangedCopyWithImpl<$Res>
    implements _$CommunityChangedCopyWith<$Res> {
  __$CommunityChangedCopyWithImpl(this._self, this._then);

  final _CommunityChanged _self;
  final $Res Function(_CommunityChanged) _then;

/// Create a copy of TicketFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? c = null,}) {
  return _then(_CommunityChanged(
null == c ? _self.c : c // ignore: cast_nullable_to_non_nullable
as TicketCommunityModel,
  ));
}


}

/// @nodoc


class _CategoryChanged implements TicketFormEvent {
  const _CategoryChanged(this.c);
  

 final  TicketCategory c;

/// Create a copy of TicketFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryChangedCopyWith<_CategoryChanged> get copyWith => __$CategoryChangedCopyWithImpl<_CategoryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryChanged&&(identical(other.c, c) || other.c == c));
}


@override
int get hashCode {
    return Object.hash(runtimeType,c);
}

@override
String toString() {
    return 'TicketFormEvent.categoryChanged(c: $c)';
}


}

/// @nodoc
abstract mixin class _$CategoryChangedCopyWith<$Res> implements $TicketFormEventCopyWith<$Res> {
  factory _$CategoryChangedCopyWith(_CategoryChanged value, $Res Function(_CategoryChanged) _then) = __$CategoryChangedCopyWithImpl;
@useResult
$Res call({
 TicketCategory c
});




}
/// @nodoc
class __$CategoryChangedCopyWithImpl<$Res>
    implements _$CategoryChangedCopyWith<$Res> {
  __$CategoryChangedCopyWithImpl(this._self, this._then);

  final _CategoryChanged _self;
  final $Res Function(_CategoryChanged) _then;

/// Create a copy of TicketFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? c = null,}) {
  return _then(_CategoryChanged(
null == c ? _self.c : c // ignore: cast_nullable_to_non_nullable
as TicketCategory,
  ));
}


}

/// @nodoc


class _TypeChanged implements TicketFormEvent {
  const _TypeChanged(this.t);
  

 final  TicketType t;

/// Create a copy of TicketFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TypeChangedCopyWith<_TypeChanged> get copyWith => __$TypeChangedCopyWithImpl<_TypeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TypeChanged&&(identical(other.t, t) || other.t == t));
}


@override
int get hashCode {
    return Object.hash(runtimeType,t);
}

@override
String toString() {
    return 'TicketFormEvent.typeChanged(t: $t)';
}


}

/// @nodoc
abstract mixin class _$TypeChangedCopyWith<$Res> implements $TicketFormEventCopyWith<$Res> {
  factory _$TypeChangedCopyWith(_TypeChanged value, $Res Function(_TypeChanged) _then) = __$TypeChangedCopyWithImpl;
@useResult
$Res call({
 TicketType t
});




}
/// @nodoc
class __$TypeChangedCopyWithImpl<$Res>
    implements _$TypeChangedCopyWith<$Res> {
  __$TypeChangedCopyWithImpl(this._self, this._then);

  final _TypeChanged _self;
  final $Res Function(_TypeChanged) _then;

/// Create a copy of TicketFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? t = null,}) {
  return _then(_TypeChanged(
null == t ? _self.t : t // ignore: cast_nullable_to_non_nullable
as TicketType,
  ));
}


}

/// @nodoc


class _SubjectChanged implements TicketFormEvent {
  const _SubjectChanged(this.value);
  

 final  String value;

/// Create a copy of TicketFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubjectChangedCopyWith<_SubjectChanged> get copyWith => __$SubjectChangedCopyWithImpl<_SubjectChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubjectChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode {
    return Object.hash(runtimeType,value);
}

@override
String toString() {
    return 'TicketFormEvent.subjectChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$SubjectChangedCopyWith<$Res> implements $TicketFormEventCopyWith<$Res> {
  factory _$SubjectChangedCopyWith(_SubjectChanged value, $Res Function(_SubjectChanged) _then) = __$SubjectChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$SubjectChangedCopyWithImpl<$Res>
    implements _$SubjectChangedCopyWith<$Res> {
  __$SubjectChangedCopyWithImpl(this._self, this._then);

  final _SubjectChanged _self;
  final $Res Function(_SubjectChanged) _then;

/// Create a copy of TicketFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_SubjectChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _DescriptionChanged implements TicketFormEvent {
  const _DescriptionChanged(this.value);
  

 final  String value;

/// Create a copy of TicketFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DescriptionChangedCopyWith<_DescriptionChanged> get copyWith => __$DescriptionChangedCopyWithImpl<_DescriptionChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DescriptionChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode {
    return Object.hash(runtimeType,value);
}

@override
String toString() {
    return 'TicketFormEvent.descriptionChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$DescriptionChangedCopyWith<$Res> implements $TicketFormEventCopyWith<$Res> {
  factory _$DescriptionChangedCopyWith(_DescriptionChanged value, $Res Function(_DescriptionChanged) _then) = __$DescriptionChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$DescriptionChangedCopyWithImpl<$Res>
    implements _$DescriptionChangedCopyWith<$Res> {
  __$DescriptionChangedCopyWithImpl(this._self, this._then);

  final _DescriptionChanged _self;
  final $Res Function(_DescriptionChanged) _then;

/// Create a copy of TicketFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_DescriptionChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _FileAdded implements TicketFormEvent {
  const _FileAdded(this.file, [this.name]);
  

 final  File file;
 final  String? name;

/// Create a copy of TicketFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FileAddedCopyWith<_FileAdded> get copyWith => __$FileAddedCopyWithImpl<_FileAdded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FileAdded&&(identical(other.file, file) || other.file == file)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode {
    return Object.hash(runtimeType,file,name);
}

@override
String toString() {
    return 'TicketFormEvent.fileAdded(file: $file, name: $name)';
}


}

/// @nodoc
abstract mixin class _$FileAddedCopyWith<$Res> implements $TicketFormEventCopyWith<$Res> {
  factory _$FileAddedCopyWith(_FileAdded value, $Res Function(_FileAdded) _then) = __$FileAddedCopyWithImpl;
@useResult
$Res call({
 File file, String? name
});




}
/// @nodoc
class __$FileAddedCopyWithImpl<$Res>
    implements _$FileAddedCopyWith<$Res> {
  __$FileAddedCopyWithImpl(this._self, this._then);

  final _FileAdded _self;
  final $Res Function(_FileAdded) _then;

/// Create a copy of TicketFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? file = null,Object? name = freezed,}) {
  return _then(_FileAdded(
null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as File,freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _FileRemoved implements TicketFormEvent {
  const _FileRemoved(this.draftId);
  

 final  String draftId;

/// Create a copy of TicketFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FileRemovedCopyWith<_FileRemoved> get copyWith => __$FileRemovedCopyWithImpl<_FileRemoved>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FileRemoved&&(identical(other.draftId, draftId) || other.draftId == draftId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,draftId);
}

@override
String toString() {
    return 'TicketFormEvent.fileRemoved(draftId: $draftId)';
}


}

/// @nodoc
abstract mixin class _$FileRemovedCopyWith<$Res> implements $TicketFormEventCopyWith<$Res> {
  factory _$FileRemovedCopyWith(_FileRemoved value, $Res Function(_FileRemoved) _then) = __$FileRemovedCopyWithImpl;
@useResult
$Res call({
 String draftId
});




}
/// @nodoc
class __$FileRemovedCopyWithImpl<$Res>
    implements _$FileRemovedCopyWith<$Res> {
  __$FileRemovedCopyWithImpl(this._self, this._then);

  final _FileRemoved _self;
  final $Res Function(_FileRemoved) _then;

/// Create a copy of TicketFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? draftId = null,}) {
  return _then(_FileRemoved(
null == draftId ? _self.draftId : draftId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Submitted implements TicketFormEvent {
  const _Submitted();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TicketFormEvent.submitted()';
}


}




/// @nodoc
mixin _$TicketFormState {

/// The community picker's own load, separate from [submit].
 RequestState get communities; List<TicketCommunityModel> get communityOptions;/// The submission: `empty` before, `loading` while in flight, `loaded`
/// once the ticket exists, `error` after a failure.
 RequestState get submit; String get message;/// Minted when the form opens, **reused on a retry of the same
/// submission**, and rotated by any edit — see [TicketFormBloc].
 String get idempotencyKey; String get subject; String get description; List<TicketAttachmentDraft> get files; TicketCommunityModel? get community; TicketCategory? get category; TicketType? get type; String? get communityError; String? get categoryError; String? get typeError; String? get subjectError; String? get descriptionError; String? get attachmentError; TicketModel? get created;
/// Create a copy of TicketFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketFormStateCopyWith<TicketFormState> get copyWith => _$TicketFormStateCopyWithImpl<TicketFormState>(this as TicketFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TicketFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketFormState&&(identical(other.communities, _this.communities) || other.communities == _this.communities)&&const DeepCollectionEquality().equals(other.communityOptions, _this.communityOptions)&&(identical(other.submit, _this.submit) || other.submit == _this.submit)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.idempotencyKey, _this.idempotencyKey) || other.idempotencyKey == _this.idempotencyKey)&&(identical(other.subject, _this.subject) || other.subject == _this.subject)&&(identical(other.description, _this.description) || other.description == _this.description)&&const DeepCollectionEquality().equals(other.files, _this.files)&&(identical(other.community, _this.community) || other.community == _this.community)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.communityError, _this.communityError) || other.communityError == _this.communityError)&&(identical(other.categoryError, _this.categoryError) || other.categoryError == _this.categoryError)&&(identical(other.typeError, _this.typeError) || other.typeError == _this.typeError)&&(identical(other.subjectError, _this.subjectError) || other.subjectError == _this.subjectError)&&(identical(other.descriptionError, _this.descriptionError) || other.descriptionError == _this.descriptionError)&&(identical(other.attachmentError, _this.attachmentError) || other.attachmentError == _this.attachmentError)&&(identical(other.created, _this.created) || other.created == _this.created));
}


@override
int get hashCode {
  final _this = this as TicketFormState;
  return Object.hash(runtimeType,_this.communities,const DeepCollectionEquality().hash(_this.communityOptions),_this.submit,_this.message,_this.idempotencyKey,_this.subject,_this.description,const DeepCollectionEquality().hash(_this.files),_this.community,_this.category,_this.type,_this.communityError,_this.categoryError,_this.typeError,_this.subjectError,_this.descriptionError,_this.attachmentError,_this.created);
}

@override
String toString() {
  final _this = this as TicketFormState;
  return 'TicketFormState(communities: ${_this.communities}, communityOptions: ${_this.communityOptions}, submit: ${_this.submit}, message: ${_this.message}, idempotencyKey: ${_this.idempotencyKey}, subject: ${_this.subject}, description: ${_this.description}, files: ${_this.files}, community: ${_this.community}, category: ${_this.category}, type: ${_this.type}, communityError: ${_this.communityError}, categoryError: ${_this.categoryError}, typeError: ${_this.typeError}, subjectError: ${_this.subjectError}, descriptionError: ${_this.descriptionError}, attachmentError: ${_this.attachmentError}, created: ${_this.created})';
}


}

/// @nodoc
abstract mixin class $TicketFormStateCopyWith<$Res>  {
  factory $TicketFormStateCopyWith(TicketFormState value, $Res Function(TicketFormState) _then) = _$TicketFormStateCopyWithImpl;
@useResult
$Res call({
 RequestState communities, List<TicketCommunityModel> communityOptions, RequestState submit, String message, String idempotencyKey, String subject, String description, List<TicketAttachmentDraft> files, TicketCommunityModel? community, TicketCategory? category, TicketType? type, String? communityError, String? categoryError, String? typeError, String? subjectError, String? descriptionError, String? attachmentError, TicketModel? created
});




}
/// @nodoc
class _$TicketFormStateCopyWithImpl<$Res>
    implements $TicketFormStateCopyWith<$Res> {
  _$TicketFormStateCopyWithImpl(this._self, this._then);

  final TicketFormState _self;
  final $Res Function(TicketFormState) _then;

/// Create a copy of TicketFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? communities = null,Object? communityOptions = null,Object? submit = null,Object? message = null,Object? idempotencyKey = null,Object? subject = null,Object? description = null,Object? files = null,Object? community = freezed,Object? category = freezed,Object? type = freezed,Object? communityError = freezed,Object? categoryError = freezed,Object? typeError = freezed,Object? subjectError = freezed,Object? descriptionError = freezed,Object? attachmentError = freezed,Object? created = freezed,}) {
  return _then(TicketFormState(
communities: null == communities ? _self.communities : communities // ignore: cast_nullable_to_non_nullable
as RequestState,communityOptions: null == communityOptions ? _self.communityOptions : communityOptions // ignore: cast_nullable_to_non_nullable
as List<TicketCommunityModel>,submit: null == submit ? _self.submit : submit // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,idempotencyKey: null == idempotencyKey ? _self.idempotencyKey : idempotencyKey // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,files: null == files ? _self.files : files // ignore: cast_nullable_to_non_nullable
as List<TicketAttachmentDraft>,community: freezed == community ? _self.community : community // ignore: cast_nullable_to_non_nullable
as TicketCommunityModel?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TicketCategory?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TicketType?,communityError: freezed == communityError ? _self.communityError : communityError // ignore: cast_nullable_to_non_nullable
as String?,categoryError: freezed == categoryError ? _self.categoryError : categoryError // ignore: cast_nullable_to_non_nullable
as String?,typeError: freezed == typeError ? _self.typeError : typeError // ignore: cast_nullable_to_non_nullable
as String?,subjectError: freezed == subjectError ? _self.subjectError : subjectError // ignore: cast_nullable_to_non_nullable
as String?,descriptionError: freezed == descriptionError ? _self.descriptionError : descriptionError // ignore: cast_nullable_to_non_nullable
as String?,attachmentError: freezed == attachmentError ? _self.attachmentError : attachmentError // ignore: cast_nullable_to_non_nullable
as String?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as TicketModel?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketFormState].
extension TicketFormStatePatterns on TicketFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketFormState value)  $default,){
final _that = this;
switch (_that) {
case _TicketFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketFormState value)?  $default,){
final _that = this;
switch (_that) {
case _TicketFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState communities,  List<TicketCommunityModel> communityOptions,  RequestState submit,  String message,  String idempotencyKey,  String subject,  String description,  List<TicketAttachmentDraft> files,  TicketCommunityModel? community,  TicketCategory? category,  TicketType? type,  String? communityError,  String? categoryError,  String? typeError,  String? subjectError,  String? descriptionError,  String? attachmentError,  TicketModel? created)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketFormState() when $default != null:
return $default(_that.communities,_that.communityOptions,_that.submit,_that.message,_that.idempotencyKey,_that.subject,_that.description,_that.files,_that.community,_that.category,_that.type,_that.communityError,_that.categoryError,_that.typeError,_that.subjectError,_that.descriptionError,_that.attachmentError,_that.created);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState communities,  List<TicketCommunityModel> communityOptions,  RequestState submit,  String message,  String idempotencyKey,  String subject,  String description,  List<TicketAttachmentDraft> files,  TicketCommunityModel? community,  TicketCategory? category,  TicketType? type,  String? communityError,  String? categoryError,  String? typeError,  String? subjectError,  String? descriptionError,  String? attachmentError,  TicketModel? created)  $default,) {final _that = this;
switch (_that) {
case _TicketFormState():
return $default(_that.communities,_that.communityOptions,_that.submit,_that.message,_that.idempotencyKey,_that.subject,_that.description,_that.files,_that.community,_that.category,_that.type,_that.communityError,_that.categoryError,_that.typeError,_that.subjectError,_that.descriptionError,_that.attachmentError,_that.created);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState communities,  List<TicketCommunityModel> communityOptions,  RequestState submit,  String message,  String idempotencyKey,  String subject,  String description,  List<TicketAttachmentDraft> files,  TicketCommunityModel? community,  TicketCategory? category,  TicketType? type,  String? communityError,  String? categoryError,  String? typeError,  String? subjectError,  String? descriptionError,  String? attachmentError,  TicketModel? created)?  $default,) {final _that = this;
switch (_that) {
case _TicketFormState() when $default != null:
return $default(_that.communities,_that.communityOptions,_that.submit,_that.message,_that.idempotencyKey,_that.subject,_that.description,_that.files,_that.community,_that.category,_that.type,_that.communityError,_that.categoryError,_that.typeError,_that.subjectError,_that.descriptionError,_that.attachmentError,_that.created);case _:
  return null;

}
}

}

/// @nodoc


class _TicketFormState extends TicketFormState {
  const _TicketFormState({required this.communities, required  List<TicketCommunityModel> communityOptions, required this.submit, required this.message, required this.idempotencyKey, required this.subject, required this.description, required  List<TicketAttachmentDraft> files, this.community, this.category, this.type, this.communityError, this.categoryError, this.typeError, this.subjectError, this.descriptionError, this.attachmentError, this.created}): _communityOptions = communityOptions,_files = files,super._();
  

/// The community picker's own load, separate from [submit].
@override final  RequestState communities;
 final  List<TicketCommunityModel> _communityOptions;
@override List<TicketCommunityModel> get communityOptions {
  if (_communityOptions is EqualUnmodifiableListView) return _communityOptions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_communityOptions);
}

/// The submission: `empty` before, `loading` while in flight, `loaded`
/// once the ticket exists, `error` after a failure.
@override final  RequestState submit;
@override final  String message;
/// Minted when the form opens, **reused on a retry of the same
/// submission**, and rotated by any edit — see [TicketFormBloc].
@override final  String idempotencyKey;
@override final  String subject;
@override final  String description;
 final  List<TicketAttachmentDraft> _files;
@override List<TicketAttachmentDraft> get files {
  if (_files is EqualUnmodifiableListView) return _files;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_files);
}

@override final  TicketCommunityModel? community;
@override final  TicketCategory? category;
@override final  TicketType? type;
@override final  String? communityError;
@override final  String? categoryError;
@override final  String? typeError;
@override final  String? subjectError;
@override final  String? descriptionError;
@override final  String? attachmentError;
@override final  TicketModel? created;

/// Create a copy of TicketFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketFormStateCopyWith<_TicketFormState> get copyWith => __$TicketFormStateCopyWithImpl<_TicketFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketFormState&&(identical(other.communities, communities) || other.communities == communities)&&const DeepCollectionEquality().equals(other.communityOptions, _communityOptions)&&(identical(other.submit, submit) || other.submit == submit)&&(identical(other.message, message) || other.message == message)&&(identical(other.idempotencyKey, idempotencyKey) || other.idempotencyKey == idempotencyKey)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.files, _files)&&(identical(other.community, community) || other.community == community)&&(identical(other.category, category) || other.category == category)&&(identical(other.type, type) || other.type == type)&&(identical(other.communityError, communityError) || other.communityError == communityError)&&(identical(other.categoryError, categoryError) || other.categoryError == categoryError)&&(identical(other.typeError, typeError) || other.typeError == typeError)&&(identical(other.subjectError, subjectError) || other.subjectError == subjectError)&&(identical(other.descriptionError, descriptionError) || other.descriptionError == descriptionError)&&(identical(other.attachmentError, attachmentError) || other.attachmentError == attachmentError)&&(identical(other.created, created) || other.created == created));
}


@override
int get hashCode {
    return Object.hash(runtimeType,communities,const DeepCollectionEquality().hash(_communityOptions),submit,message,idempotencyKey,subject,description,const DeepCollectionEquality().hash(_files),community,category,type,communityError,categoryError,typeError,subjectError,descriptionError,attachmentError,created);
}

@override
String toString() {
    return 'TicketFormState(communities: $communities, communityOptions: $communityOptions, submit: $submit, message: $message, idempotencyKey: $idempotencyKey, subject: $subject, description: $description, files: $files, community: $community, category: $category, type: $type, communityError: $communityError, categoryError: $categoryError, typeError: $typeError, subjectError: $subjectError, descriptionError: $descriptionError, attachmentError: $attachmentError, created: $created)';
}


}

/// @nodoc
abstract mixin class _$TicketFormStateCopyWith<$Res> implements $TicketFormStateCopyWith<$Res> {
  factory _$TicketFormStateCopyWith(_TicketFormState value, $Res Function(_TicketFormState) _then) = __$TicketFormStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState communities, List<TicketCommunityModel> communityOptions, RequestState submit, String message, String idempotencyKey, String subject, String description, List<TicketAttachmentDraft> files, TicketCommunityModel? community, TicketCategory? category, TicketType? type, String? communityError, String? categoryError, String? typeError, String? subjectError, String? descriptionError, String? attachmentError, TicketModel? created
});




}
/// @nodoc
class __$TicketFormStateCopyWithImpl<$Res>
    implements _$TicketFormStateCopyWith<$Res> {
  __$TicketFormStateCopyWithImpl(this._self, this._then);

  final _TicketFormState _self;
  final $Res Function(_TicketFormState) _then;

/// Create a copy of TicketFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? communities = null,Object? communityOptions = null,Object? submit = null,Object? message = null,Object? idempotencyKey = null,Object? subject = null,Object? description = null,Object? files = null,Object? community = freezed,Object? category = freezed,Object? type = freezed,Object? communityError = freezed,Object? categoryError = freezed,Object? typeError = freezed,Object? subjectError = freezed,Object? descriptionError = freezed,Object? attachmentError = freezed,Object? created = freezed,}) {
  return _then(_TicketFormState(
communities: null == communities ? _self.communities : communities // ignore: cast_nullable_to_non_nullable
as RequestState,communityOptions: null == communityOptions ? _self._communityOptions : communityOptions // ignore: cast_nullable_to_non_nullable
as List<TicketCommunityModel>,submit: null == submit ? _self.submit : submit // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,idempotencyKey: null == idempotencyKey ? _self.idempotencyKey : idempotencyKey // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,files: null == files ? _self._files : files // ignore: cast_nullable_to_non_nullable
as List<TicketAttachmentDraft>,community: freezed == community ? _self.community : community // ignore: cast_nullable_to_non_nullable
as TicketCommunityModel?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as TicketCategory?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TicketType?,communityError: freezed == communityError ? _self.communityError : communityError // ignore: cast_nullable_to_non_nullable
as String?,categoryError: freezed == categoryError ? _self.categoryError : categoryError // ignore: cast_nullable_to_non_nullable
as String?,typeError: freezed == typeError ? _self.typeError : typeError // ignore: cast_nullable_to_non_nullable
as String?,subjectError: freezed == subjectError ? _self.subjectError : subjectError // ignore: cast_nullable_to_non_nullable
as String?,descriptionError: freezed == descriptionError ? _self.descriptionError : descriptionError // ignore: cast_nullable_to_non_nullable
as String?,attachmentError: freezed == attachmentError ? _self.attachmentError : attachmentError // ignore: cast_nullable_to_non_nullable
as String?,created: freezed == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as TicketModel?,
  ));
}


}

// dart format on
