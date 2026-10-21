// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_chat_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TicketChatEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketChatEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TicketChatEvent()';
}


}

/// @nodoc
class $TicketChatEventCopyWith<$Res>  {
$TicketChatEventCopyWith(TicketChatEvent _, $Res Function(TicketChatEvent) __);
}


/// Adds pattern-matching-related methods to [TicketChatEvent].
extension TicketChatEventPatterns on TicketChatEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _LoadEarlier value)?  loadEarlier,TResult Function( _Sent value)?  sent,TResult Function( _Retried value)?  retried,TResult Function( _AttachmentPicked value)?  attachmentPicked,TResult Function( _AttachmentRemoved value)?  attachmentRemoved,TResult Function( _AttachmentOpened value)?  attachmentOpened,TResult Function( _Rated value)?  rated,TResult Function( _SocketEvent value)?  socketEvent,TResult Function( _SocketStatus value)?  socketStatus,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoadEarlier() when loadEarlier != null:
return loadEarlier(_that);case _Sent() when sent != null:
return sent(_that);case _Retried() when retried != null:
return retried(_that);case _AttachmentPicked() when attachmentPicked != null:
return attachmentPicked(_that);case _AttachmentRemoved() when attachmentRemoved != null:
return attachmentRemoved(_that);case _AttachmentOpened() when attachmentOpened != null:
return attachmentOpened(_that);case _Rated() when rated != null:
return rated(_that);case _SocketEvent() when socketEvent != null:
return socketEvent(_that);case _SocketStatus() when socketStatus != null:
return socketStatus(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _LoadEarlier value)  loadEarlier,required TResult Function( _Sent value)  sent,required TResult Function( _Retried value)  retried,required TResult Function( _AttachmentPicked value)  attachmentPicked,required TResult Function( _AttachmentRemoved value)  attachmentRemoved,required TResult Function( _AttachmentOpened value)  attachmentOpened,required TResult Function( _Rated value)  rated,required TResult Function( _SocketEvent value)  socketEvent,required TResult Function( _SocketStatus value)  socketStatus,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _LoadEarlier():
return loadEarlier(_that);case _Sent():
return sent(_that);case _Retried():
return retried(_that);case _AttachmentPicked():
return attachmentPicked(_that);case _AttachmentRemoved():
return attachmentRemoved(_that);case _AttachmentOpened():
return attachmentOpened(_that);case _Rated():
return rated(_that);case _SocketEvent():
return socketEvent(_that);case _SocketStatus():
return socketStatus(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _LoadEarlier value)?  loadEarlier,TResult? Function( _Sent value)?  sent,TResult? Function( _Retried value)?  retried,TResult? Function( _AttachmentPicked value)?  attachmentPicked,TResult? Function( _AttachmentRemoved value)?  attachmentRemoved,TResult? Function( _AttachmentOpened value)?  attachmentOpened,TResult? Function( _Rated value)?  rated,TResult? Function( _SocketEvent value)?  socketEvent,TResult? Function( _SocketStatus value)?  socketStatus,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoadEarlier() when loadEarlier != null:
return loadEarlier(_that);case _Sent() when sent != null:
return sent(_that);case _Retried() when retried != null:
return retried(_that);case _AttachmentPicked() when attachmentPicked != null:
return attachmentPicked(_that);case _AttachmentRemoved() when attachmentRemoved != null:
return attachmentRemoved(_that);case _AttachmentOpened() when attachmentOpened != null:
return attachmentOpened(_that);case _Rated() when rated != null:
return rated(_that);case _SocketEvent() when socketEvent != null:
return socketEvent(_that);case _SocketStatus() when socketStatus != null:
return socketStatus(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String ticketId)?  started,TResult Function()?  loadEarlier,TResult Function( String text)?  sent,TResult Function( String clientMessageId)?  retried,TResult Function( File file,  String? name)?  attachmentPicked,TResult Function( String draftId)?  attachmentRemoved,TResult Function( String attachmentId,  Completer<String?> result)?  attachmentOpened,TResult Function( int rating,  String? comment)?  rated,TResult Function( SocketEvent event)?  socketEvent,TResult Function( SocketStatus status)?  socketStatus,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.ticketId);case _LoadEarlier() when loadEarlier != null:
return loadEarlier();case _Sent() when sent != null:
return sent(_that.text);case _Retried() when retried != null:
return retried(_that.clientMessageId);case _AttachmentPicked() when attachmentPicked != null:
return attachmentPicked(_that.file,_that.name);case _AttachmentRemoved() when attachmentRemoved != null:
return attachmentRemoved(_that.draftId);case _AttachmentOpened() when attachmentOpened != null:
return attachmentOpened(_that.attachmentId,_that.result);case _Rated() when rated != null:
return rated(_that.rating,_that.comment);case _SocketEvent() when socketEvent != null:
return socketEvent(_that.event);case _SocketStatus() when socketStatus != null:
return socketStatus(_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String ticketId)  started,required TResult Function()  loadEarlier,required TResult Function( String text)  sent,required TResult Function( String clientMessageId)  retried,required TResult Function( File file,  String? name)  attachmentPicked,required TResult Function( String draftId)  attachmentRemoved,required TResult Function( String attachmentId,  Completer<String?> result)  attachmentOpened,required TResult Function( int rating,  String? comment)  rated,required TResult Function( SocketEvent event)  socketEvent,required TResult Function( SocketStatus status)  socketStatus,}) {final _that = this;
switch (_that) {
case _Started():
return started(_that.ticketId);case _LoadEarlier():
return loadEarlier();case _Sent():
return sent(_that.text);case _Retried():
return retried(_that.clientMessageId);case _AttachmentPicked():
return attachmentPicked(_that.file,_that.name);case _AttachmentRemoved():
return attachmentRemoved(_that.draftId);case _AttachmentOpened():
return attachmentOpened(_that.attachmentId,_that.result);case _Rated():
return rated(_that.rating,_that.comment);case _SocketEvent():
return socketEvent(_that.event);case _SocketStatus():
return socketStatus(_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String ticketId)?  started,TResult? Function()?  loadEarlier,TResult? Function( String text)?  sent,TResult? Function( String clientMessageId)?  retried,TResult? Function( File file,  String? name)?  attachmentPicked,TResult? Function( String draftId)?  attachmentRemoved,TResult? Function( String attachmentId,  Completer<String?> result)?  attachmentOpened,TResult? Function( int rating,  String? comment)?  rated,TResult? Function( SocketEvent event)?  socketEvent,TResult? Function( SocketStatus status)?  socketStatus,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.ticketId);case _LoadEarlier() when loadEarlier != null:
return loadEarlier();case _Sent() when sent != null:
return sent(_that.text);case _Retried() when retried != null:
return retried(_that.clientMessageId);case _AttachmentPicked() when attachmentPicked != null:
return attachmentPicked(_that.file,_that.name);case _AttachmentRemoved() when attachmentRemoved != null:
return attachmentRemoved(_that.draftId);case _AttachmentOpened() when attachmentOpened != null:
return attachmentOpened(_that.attachmentId,_that.result);case _Rated() when rated != null:
return rated(_that.rating,_that.comment);case _SocketEvent() when socketEvent != null:
return socketEvent(_that.event);case _SocketStatus() when socketStatus != null:
return socketStatus(_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements TicketChatEvent {
  const _Started(this.ticketId);
  

 final  String ticketId;

/// Create a copy of TicketChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartedCopyWith<_Started> get copyWith => __$StartedCopyWithImpl<_Started>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started&&(identical(other.ticketId, ticketId) || other.ticketId == ticketId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,ticketId);
}

@override
String toString() {
    return 'TicketChatEvent.started(ticketId: $ticketId)';
}


}

/// @nodoc
abstract mixin class _$StartedCopyWith<$Res> implements $TicketChatEventCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) _then) = __$StartedCopyWithImpl;
@useResult
$Res call({
 String ticketId
});




}
/// @nodoc
class __$StartedCopyWithImpl<$Res>
    implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(this._self, this._then);

  final _Started _self;
  final $Res Function(_Started) _then;

/// Create a copy of TicketChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? ticketId = null,}) {
  return _then(_Started(
null == ticketId ? _self.ticketId : ticketId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadEarlier implements TicketChatEvent {
  const _LoadEarlier();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadEarlier);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'TicketChatEvent.loadEarlier()';
}


}




/// @nodoc


class _Sent implements TicketChatEvent {
  const _Sent(this.text);
  

 final  String text;

/// Create a copy of TicketChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SentCopyWith<_Sent> get copyWith => __$SentCopyWithImpl<_Sent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Sent&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode {
    return Object.hash(runtimeType,text);
}

@override
String toString() {
    return 'TicketChatEvent.sent(text: $text)';
}


}

/// @nodoc
abstract mixin class _$SentCopyWith<$Res> implements $TicketChatEventCopyWith<$Res> {
  factory _$SentCopyWith(_Sent value, $Res Function(_Sent) _then) = __$SentCopyWithImpl;
@useResult
$Res call({
 String text
});




}
/// @nodoc
class __$SentCopyWithImpl<$Res>
    implements _$SentCopyWith<$Res> {
  __$SentCopyWithImpl(this._self, this._then);

  final _Sent _self;
  final $Res Function(_Sent) _then;

/// Create a copy of TicketChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(_Sent(
null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Retried implements TicketChatEvent {
  const _Retried(this.clientMessageId);
  

 final  String clientMessageId;

/// Create a copy of TicketChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RetriedCopyWith<_Retried> get copyWith => __$RetriedCopyWithImpl<_Retried>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Retried&&(identical(other.clientMessageId, clientMessageId) || other.clientMessageId == clientMessageId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,clientMessageId);
}

@override
String toString() {
    return 'TicketChatEvent.retried(clientMessageId: $clientMessageId)';
}


}

/// @nodoc
abstract mixin class _$RetriedCopyWith<$Res> implements $TicketChatEventCopyWith<$Res> {
  factory _$RetriedCopyWith(_Retried value, $Res Function(_Retried) _then) = __$RetriedCopyWithImpl;
@useResult
$Res call({
 String clientMessageId
});




}
/// @nodoc
class __$RetriedCopyWithImpl<$Res>
    implements _$RetriedCopyWith<$Res> {
  __$RetriedCopyWithImpl(this._self, this._then);

  final _Retried _self;
  final $Res Function(_Retried) _then;

/// Create a copy of TicketChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? clientMessageId = null,}) {
  return _then(_Retried(
null == clientMessageId ? _self.clientMessageId : clientMessageId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AttachmentPicked implements TicketChatEvent {
  const _AttachmentPicked(this.file, [this.name]);
  

 final  File file;
 final  String? name;

/// Create a copy of TicketChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttachmentPickedCopyWith<_AttachmentPicked> get copyWith => __$AttachmentPickedCopyWithImpl<_AttachmentPicked>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttachmentPicked&&(identical(other.file, file) || other.file == file)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode {
    return Object.hash(runtimeType,file,name);
}

@override
String toString() {
    return 'TicketChatEvent.attachmentPicked(file: $file, name: $name)';
}


}

/// @nodoc
abstract mixin class _$AttachmentPickedCopyWith<$Res> implements $TicketChatEventCopyWith<$Res> {
  factory _$AttachmentPickedCopyWith(_AttachmentPicked value, $Res Function(_AttachmentPicked) _then) = __$AttachmentPickedCopyWithImpl;
@useResult
$Res call({
 File file, String? name
});




}
/// @nodoc
class __$AttachmentPickedCopyWithImpl<$Res>
    implements _$AttachmentPickedCopyWith<$Res> {
  __$AttachmentPickedCopyWithImpl(this._self, this._then);

  final _AttachmentPicked _self;
  final $Res Function(_AttachmentPicked) _then;

/// Create a copy of TicketChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? file = null,Object? name = freezed,}) {
  return _then(_AttachmentPicked(
null == file ? _self.file : file // ignore: cast_nullable_to_non_nullable
as File,freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _AttachmentRemoved implements TicketChatEvent {
  const _AttachmentRemoved(this.draftId);
  

 final  String draftId;

/// Create a copy of TicketChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttachmentRemovedCopyWith<_AttachmentRemoved> get copyWith => __$AttachmentRemovedCopyWithImpl<_AttachmentRemoved>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttachmentRemoved&&(identical(other.draftId, draftId) || other.draftId == draftId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,draftId);
}

@override
String toString() {
    return 'TicketChatEvent.attachmentRemoved(draftId: $draftId)';
}


}

/// @nodoc
abstract mixin class _$AttachmentRemovedCopyWith<$Res> implements $TicketChatEventCopyWith<$Res> {
  factory _$AttachmentRemovedCopyWith(_AttachmentRemoved value, $Res Function(_AttachmentRemoved) _then) = __$AttachmentRemovedCopyWithImpl;
@useResult
$Res call({
 String draftId
});




}
/// @nodoc
class __$AttachmentRemovedCopyWithImpl<$Res>
    implements _$AttachmentRemovedCopyWith<$Res> {
  __$AttachmentRemovedCopyWithImpl(this._self, this._then);

  final _AttachmentRemoved _self;
  final $Res Function(_AttachmentRemoved) _then;

/// Create a copy of TicketChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? draftId = null,}) {
  return _then(_AttachmentRemoved(
null == draftId ? _self.draftId : draftId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AttachmentOpened implements TicketChatEvent {
  const _AttachmentOpened(this.attachmentId, this.result);
  

 final  String attachmentId;
 final  Completer<String?> result;

/// Create a copy of TicketChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttachmentOpenedCopyWith<_AttachmentOpened> get copyWith => __$AttachmentOpenedCopyWithImpl<_AttachmentOpened>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttachmentOpened&&(identical(other.attachmentId, attachmentId) || other.attachmentId == attachmentId)&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode {
    return Object.hash(runtimeType,attachmentId,result);
}

@override
String toString() {
    return 'TicketChatEvent.attachmentOpened(attachmentId: $attachmentId, result: $result)';
}


}

/// @nodoc
abstract mixin class _$AttachmentOpenedCopyWith<$Res> implements $TicketChatEventCopyWith<$Res> {
  factory _$AttachmentOpenedCopyWith(_AttachmentOpened value, $Res Function(_AttachmentOpened) _then) = __$AttachmentOpenedCopyWithImpl;
@useResult
$Res call({
 String attachmentId, Completer<String?> result
});




}
/// @nodoc
class __$AttachmentOpenedCopyWithImpl<$Res>
    implements _$AttachmentOpenedCopyWith<$Res> {
  __$AttachmentOpenedCopyWithImpl(this._self, this._then);

  final _AttachmentOpened _self;
  final $Res Function(_AttachmentOpened) _then;

/// Create a copy of TicketChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? attachmentId = null,Object? result = null,}) {
  return _then(_AttachmentOpened(
null == attachmentId ? _self.attachmentId : attachmentId // ignore: cast_nullable_to_non_nullable
as String,null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Completer<String?>,
  ));
}


}

/// @nodoc


class _Rated implements TicketChatEvent {
  const _Rated(this.rating, this.comment);
  

 final  int rating;
 final  String? comment;

/// Create a copy of TicketChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RatedCopyWith<_Rated> get copyWith => __$RatedCopyWithImpl<_Rated>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Rated&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.comment, comment) || other.comment == comment));
}


@override
int get hashCode {
    return Object.hash(runtimeType,rating,comment);
}

@override
String toString() {
    return 'TicketChatEvent.rated(rating: $rating, comment: $comment)';
}


}

/// @nodoc
abstract mixin class _$RatedCopyWith<$Res> implements $TicketChatEventCopyWith<$Res> {
  factory _$RatedCopyWith(_Rated value, $Res Function(_Rated) _then) = __$RatedCopyWithImpl;
@useResult
$Res call({
 int rating, String? comment
});




}
/// @nodoc
class __$RatedCopyWithImpl<$Res>
    implements _$RatedCopyWith<$Res> {
  __$RatedCopyWithImpl(this._self, this._then);

  final _Rated _self;
  final $Res Function(_Rated) _then;

/// Create a copy of TicketChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? rating = null,Object? comment = freezed,}) {
  return _then(_Rated(
null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as int,freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _SocketEvent implements TicketChatEvent {
  const _SocketEvent(this.event);
  

 final  SocketEvent event;

/// Create a copy of TicketChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocketEventCopyWith<_SocketEvent> get copyWith => __$SocketEventCopyWithImpl<_SocketEvent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocketEvent&&(identical(other.event, event) || other.event == event));
}


@override
int get hashCode {
    return Object.hash(runtimeType,event);
}

@override
String toString() {
    return 'TicketChatEvent.socketEvent(event: $event)';
}


}

/// @nodoc
abstract mixin class _$SocketEventCopyWith<$Res> implements $TicketChatEventCopyWith<$Res> {
  factory _$SocketEventCopyWith(_SocketEvent value, $Res Function(_SocketEvent) _then) = __$SocketEventCopyWithImpl;
@useResult
$Res call({
 SocketEvent event
});




}
/// @nodoc
class __$SocketEventCopyWithImpl<$Res>
    implements _$SocketEventCopyWith<$Res> {
  __$SocketEventCopyWithImpl(this._self, this._then);

  final _SocketEvent _self;
  final $Res Function(_SocketEvent) _then;

/// Create a copy of TicketChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? event = null,}) {
  return _then(_SocketEvent(
null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as SocketEvent,
  ));
}


}

/// @nodoc


class _SocketStatus implements TicketChatEvent {
  const _SocketStatus(this.status);
  

 final  SocketStatus status;

/// Create a copy of TicketChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocketStatusCopyWith<_SocketStatus> get copyWith => __$SocketStatusCopyWithImpl<_SocketStatus>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocketStatus&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status);
}

@override
String toString() {
    return 'TicketChatEvent.socketStatus(status: $status)';
}


}

/// @nodoc
abstract mixin class _$SocketStatusCopyWith<$Res> implements $TicketChatEventCopyWith<$Res> {
  factory _$SocketStatusCopyWith(_SocketStatus value, $Res Function(_SocketStatus) _then) = __$SocketStatusCopyWithImpl;
@useResult
$Res call({
 SocketStatus status
});




}
/// @nodoc
class __$SocketStatusCopyWithImpl<$Res>
    implements _$SocketStatusCopyWith<$Res> {
  __$SocketStatusCopyWithImpl(this._self, this._then);

  final _SocketStatus _self;
  final $Res Function(_SocketStatus) _then;

/// Create a copy of TicketChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_SocketStatus(
null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SocketStatus,
  ));
}


}

/// @nodoc
mixin _$TicketChatState {

/// The first load of the ticket and its history.
 RequestState get state;/// A transient failure (a send, an upload, a rating) shown as a snackbar
/// without disturbing the conversation on screen.
 String get message; List<TicketMessageModel> get messages; bool get isLoadingEarlier; SocketStatus get socket; List<TicketAttachmentDraft> get drafts; RequestState get rating; TicketModel? get ticket; String? get historyCursor;
/// Create a copy of TicketChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketChatStateCopyWith<TicketChatState> get copyWith => _$TicketChatStateCopyWithImpl<TicketChatState>(this as TicketChatState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TicketChatState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketChatState&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.message, _this.message) || other.message == _this.message)&&const DeepCollectionEquality().equals(other.messages, _this.messages)&&(identical(other.isLoadingEarlier, _this.isLoadingEarlier) || other.isLoadingEarlier == _this.isLoadingEarlier)&&(identical(other.socket, _this.socket) || other.socket == _this.socket)&&const DeepCollectionEquality().equals(other.drafts, _this.drafts)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.ticket, _this.ticket) || other.ticket == _this.ticket)&&(identical(other.historyCursor, _this.historyCursor) || other.historyCursor == _this.historyCursor));
}


@override
int get hashCode {
  final _this = this as TicketChatState;
  return Object.hash(runtimeType,_this.state,_this.message,const DeepCollectionEquality().hash(_this.messages),_this.isLoadingEarlier,_this.socket,const DeepCollectionEquality().hash(_this.drafts),_this.rating,_this.ticket,_this.historyCursor);
}

@override
String toString() {
  final _this = this as TicketChatState;
  return 'TicketChatState(state: ${_this.state}, message: ${_this.message}, messages: ${_this.messages}, isLoadingEarlier: ${_this.isLoadingEarlier}, socket: ${_this.socket}, drafts: ${_this.drafts}, rating: ${_this.rating}, ticket: ${_this.ticket}, historyCursor: ${_this.historyCursor})';
}


}

/// @nodoc
abstract mixin class $TicketChatStateCopyWith<$Res>  {
  factory $TicketChatStateCopyWith(TicketChatState value, $Res Function(TicketChatState) _then) = _$TicketChatStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, String message, List<TicketMessageModel> messages, bool isLoadingEarlier, SocketStatus socket, List<TicketAttachmentDraft> drafts, RequestState rating, TicketModel? ticket, String? historyCursor
});




}
/// @nodoc
class _$TicketChatStateCopyWithImpl<$Res>
    implements $TicketChatStateCopyWith<$Res> {
  _$TicketChatStateCopyWithImpl(this._self, this._then);

  final TicketChatState _self;
  final $Res Function(TicketChatState) _then;

/// Create a copy of TicketChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? message = null,Object? messages = null,Object? isLoadingEarlier = null,Object? socket = null,Object? drafts = null,Object? rating = null,Object? ticket = freezed,Object? historyCursor = freezed,}) {
  return _then(TicketChatState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<TicketMessageModel>,isLoadingEarlier: null == isLoadingEarlier ? _self.isLoadingEarlier : isLoadingEarlier // ignore: cast_nullable_to_non_nullable
as bool,socket: null == socket ? _self.socket : socket // ignore: cast_nullable_to_non_nullable
as SocketStatus,drafts: null == drafts ? _self.drafts : drafts // ignore: cast_nullable_to_non_nullable
as List<TicketAttachmentDraft>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as RequestState,ticket: freezed == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as TicketModel?,historyCursor: freezed == historyCursor ? _self.historyCursor : historyCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketChatState].
extension TicketChatStatePatterns on TicketChatState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketChatState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketChatState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketChatState value)  $default,){
final _that = this;
switch (_that) {
case _TicketChatState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketChatState value)?  $default,){
final _that = this;
switch (_that) {
case _TicketChatState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  String message,  List<TicketMessageModel> messages,  bool isLoadingEarlier,  SocketStatus socket,  List<TicketAttachmentDraft> drafts,  RequestState rating,  TicketModel? ticket,  String? historyCursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketChatState() when $default != null:
return $default(_that.state,_that.message,_that.messages,_that.isLoadingEarlier,_that.socket,_that.drafts,_that.rating,_that.ticket,_that.historyCursor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  String message,  List<TicketMessageModel> messages,  bool isLoadingEarlier,  SocketStatus socket,  List<TicketAttachmentDraft> drafts,  RequestState rating,  TicketModel? ticket,  String? historyCursor)  $default,) {final _that = this;
switch (_that) {
case _TicketChatState():
return $default(_that.state,_that.message,_that.messages,_that.isLoadingEarlier,_that.socket,_that.drafts,_that.rating,_that.ticket,_that.historyCursor);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  String message,  List<TicketMessageModel> messages,  bool isLoadingEarlier,  SocketStatus socket,  List<TicketAttachmentDraft> drafts,  RequestState rating,  TicketModel? ticket,  String? historyCursor)?  $default,) {final _that = this;
switch (_that) {
case _TicketChatState() when $default != null:
return $default(_that.state,_that.message,_that.messages,_that.isLoadingEarlier,_that.socket,_that.drafts,_that.rating,_that.ticket,_that.historyCursor);case _:
  return null;

}
}

}

/// @nodoc


class _TicketChatState extends TicketChatState {
  const _TicketChatState({required this.state, required this.message, required  List<TicketMessageModel> messages, required this.isLoadingEarlier, required this.socket, required  List<TicketAttachmentDraft> drafts, required this.rating, this.ticket, this.historyCursor}): _messages = messages,_drafts = drafts,super._();
  

/// The first load of the ticket and its history.
@override final  RequestState state;
/// A transient failure (a send, an upload, a rating) shown as a snackbar
/// without disturbing the conversation on screen.
@override final  String message;
 final  List<TicketMessageModel> _messages;
@override List<TicketMessageModel> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

@override final  bool isLoadingEarlier;
@override final  SocketStatus socket;
 final  List<TicketAttachmentDraft> _drafts;
@override List<TicketAttachmentDraft> get drafts {
  if (_drafts is EqualUnmodifiableListView) return _drafts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_drafts);
}

@override final  RequestState rating;
@override final  TicketModel? ticket;
@override final  String? historyCursor;

/// Create a copy of TicketChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketChatStateCopyWith<_TicketChatState> get copyWith => __$TicketChatStateCopyWithImpl<_TicketChatState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketChatState&&(identical(other.state, state) || other.state == state)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.messages, _messages)&&(identical(other.isLoadingEarlier, isLoadingEarlier) || other.isLoadingEarlier == isLoadingEarlier)&&(identical(other.socket, socket) || other.socket == socket)&&const DeepCollectionEquality().equals(other.drafts, _drafts)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.ticket, ticket) || other.ticket == ticket)&&(identical(other.historyCursor, historyCursor) || other.historyCursor == historyCursor));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state,message,const DeepCollectionEquality().hash(_messages),isLoadingEarlier,socket,const DeepCollectionEquality().hash(_drafts),rating,ticket,historyCursor);
}

@override
String toString() {
    return 'TicketChatState(state: $state, message: $message, messages: $messages, isLoadingEarlier: $isLoadingEarlier, socket: $socket, drafts: $drafts, rating: $rating, ticket: $ticket, historyCursor: $historyCursor)';
}


}

/// @nodoc
abstract mixin class _$TicketChatStateCopyWith<$Res> implements $TicketChatStateCopyWith<$Res> {
  factory _$TicketChatStateCopyWith(_TicketChatState value, $Res Function(_TicketChatState) _then) = __$TicketChatStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, String message, List<TicketMessageModel> messages, bool isLoadingEarlier, SocketStatus socket, List<TicketAttachmentDraft> drafts, RequestState rating, TicketModel? ticket, String? historyCursor
});




}
/// @nodoc
class __$TicketChatStateCopyWithImpl<$Res>
    implements _$TicketChatStateCopyWith<$Res> {
  __$TicketChatStateCopyWithImpl(this._self, this._then);

  final _TicketChatState _self;
  final $Res Function(_TicketChatState) _then;

/// Create a copy of TicketChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? message = null,Object? messages = null,Object? isLoadingEarlier = null,Object? socket = null,Object? drafts = null,Object? rating = null,Object? ticket = freezed,Object? historyCursor = freezed,}) {
  return _then(_TicketChatState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<TicketMessageModel>,isLoadingEarlier: null == isLoadingEarlier ? _self.isLoadingEarlier : isLoadingEarlier // ignore: cast_nullable_to_non_nullable
as bool,socket: null == socket ? _self.socket : socket // ignore: cast_nullable_to_non_nullable
as SocketStatus,drafts: null == drafts ? _self._drafts : drafts // ignore: cast_nullable_to_non_nullable
as List<TicketAttachmentDraft>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as RequestState,ticket: freezed == ticket ? _self.ticket : ticket // ignore: cast_nullable_to_non_nullable
as TicketModel?,historyCursor: freezed == historyCursor ? _self.historyCursor : historyCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
