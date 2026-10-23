// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_chat_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServiceChatEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceChatEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServiceChatEvent()';
}


}

/// @nodoc
class $ServiceChatEventCopyWith<$Res>  {
$ServiceChatEventCopyWith(ServiceChatEvent _, $Res Function(ServiceChatEvent) __);
}


/// Adds pattern-matching-related methods to [ServiceChatEvent].
extension ServiceChatEventPatterns on ServiceChatEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _LoadEarlier value)?  loadEarlier,TResult Function( _Sent value)?  sent,TResult Function( _Retried value)?  retried,TResult Function( _AttachmentPicked value)?  attachmentPicked,TResult Function( _AttachmentRemoved value)?  attachmentRemoved,TResult Function( _AttachmentOpened value)?  attachmentOpened,TResult Function( _Cancelled value)?  cancelled,TResult Function( _Rated value)?  rated,TResult Function( _InvoiceRequested value)?  invoiceRequested,TResult Function( _Refreshed value)?  refreshed,TResult Function( _Paid value)?  paid,TResult Function( _SocketEvent value)?  socketEvent,TResult Function( _SocketStatus value)?  socketStatus,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoadEarlier() when loadEarlier != null:
return loadEarlier(_that);case _Sent() when sent != null:
return sent(_that);case _Retried() when retried != null:
return retried(_that);case _AttachmentPicked() when attachmentPicked != null:
return attachmentPicked(_that);case _AttachmentRemoved() when attachmentRemoved != null:
return attachmentRemoved(_that);case _AttachmentOpened() when attachmentOpened != null:
return attachmentOpened(_that);case _Cancelled() when cancelled != null:
return cancelled(_that);case _Rated() when rated != null:
return rated(_that);case _InvoiceRequested() when invoiceRequested != null:
return invoiceRequested(_that);case _Refreshed() when refreshed != null:
return refreshed(_that);case _Paid() when paid != null:
return paid(_that);case _SocketEvent() when socketEvent != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _LoadEarlier value)  loadEarlier,required TResult Function( _Sent value)  sent,required TResult Function( _Retried value)  retried,required TResult Function( _AttachmentPicked value)  attachmentPicked,required TResult Function( _AttachmentRemoved value)  attachmentRemoved,required TResult Function( _AttachmentOpened value)  attachmentOpened,required TResult Function( _Cancelled value)  cancelled,required TResult Function( _Rated value)  rated,required TResult Function( _InvoiceRequested value)  invoiceRequested,required TResult Function( _Refreshed value)  refreshed,required TResult Function( _Paid value)  paid,required TResult Function( _SocketEvent value)  socketEvent,required TResult Function( _SocketStatus value)  socketStatus,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _LoadEarlier():
return loadEarlier(_that);case _Sent():
return sent(_that);case _Retried():
return retried(_that);case _AttachmentPicked():
return attachmentPicked(_that);case _AttachmentRemoved():
return attachmentRemoved(_that);case _AttachmentOpened():
return attachmentOpened(_that);case _Cancelled():
return cancelled(_that);case _Rated():
return rated(_that);case _InvoiceRequested():
return invoiceRequested(_that);case _Refreshed():
return refreshed(_that);case _Paid():
return paid(_that);case _SocketEvent():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _LoadEarlier value)?  loadEarlier,TResult? Function( _Sent value)?  sent,TResult? Function( _Retried value)?  retried,TResult? Function( _AttachmentPicked value)?  attachmentPicked,TResult? Function( _AttachmentRemoved value)?  attachmentRemoved,TResult? Function( _AttachmentOpened value)?  attachmentOpened,TResult? Function( _Cancelled value)?  cancelled,TResult? Function( _Rated value)?  rated,TResult? Function( _InvoiceRequested value)?  invoiceRequested,TResult? Function( _Refreshed value)?  refreshed,TResult? Function( _Paid value)?  paid,TResult? Function( _SocketEvent value)?  socketEvent,TResult? Function( _SocketStatus value)?  socketStatus,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _LoadEarlier() when loadEarlier != null:
return loadEarlier(_that);case _Sent() when sent != null:
return sent(_that);case _Retried() when retried != null:
return retried(_that);case _AttachmentPicked() when attachmentPicked != null:
return attachmentPicked(_that);case _AttachmentRemoved() when attachmentRemoved != null:
return attachmentRemoved(_that);case _AttachmentOpened() when attachmentOpened != null:
return attachmentOpened(_that);case _Cancelled() when cancelled != null:
return cancelled(_that);case _Rated() when rated != null:
return rated(_that);case _InvoiceRequested() when invoiceRequested != null:
return invoiceRequested(_that);case _Refreshed() when refreshed != null:
return refreshed(_that);case _Paid() when paid != null:
return paid(_that);case _SocketEvent() when socketEvent != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String requestId)?  started,TResult Function()?  loadEarlier,TResult Function( String text)?  sent,TResult Function( String clientMessageId)?  retried,TResult Function( File file,  String? name)?  attachmentPicked,TResult Function( String draftId)?  attachmentRemoved,TResult Function( String attachmentId,  Completer<String?> result)?  attachmentOpened,TResult Function()?  cancelled,TResult Function( int rating,  String? comment)?  rated,TResult Function( Completer<InvoiceLink?> result)?  invoiceRequested,TResult Function()?  refreshed,TResult Function( ServiceRequestModel request)?  paid,TResult Function( SocketEvent event)?  socketEvent,TResult Function( SocketStatus status)?  socketStatus,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.requestId);case _LoadEarlier() when loadEarlier != null:
return loadEarlier();case _Sent() when sent != null:
return sent(_that.text);case _Retried() when retried != null:
return retried(_that.clientMessageId);case _AttachmentPicked() when attachmentPicked != null:
return attachmentPicked(_that.file,_that.name);case _AttachmentRemoved() when attachmentRemoved != null:
return attachmentRemoved(_that.draftId);case _AttachmentOpened() when attachmentOpened != null:
return attachmentOpened(_that.attachmentId,_that.result);case _Cancelled() when cancelled != null:
return cancelled();case _Rated() when rated != null:
return rated(_that.rating,_that.comment);case _InvoiceRequested() when invoiceRequested != null:
return invoiceRequested(_that.result);case _Refreshed() when refreshed != null:
return refreshed();case _Paid() when paid != null:
return paid(_that.request);case _SocketEvent() when socketEvent != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String requestId)  started,required TResult Function()  loadEarlier,required TResult Function( String text)  sent,required TResult Function( String clientMessageId)  retried,required TResult Function( File file,  String? name)  attachmentPicked,required TResult Function( String draftId)  attachmentRemoved,required TResult Function( String attachmentId,  Completer<String?> result)  attachmentOpened,required TResult Function()  cancelled,required TResult Function( int rating,  String? comment)  rated,required TResult Function( Completer<InvoiceLink?> result)  invoiceRequested,required TResult Function()  refreshed,required TResult Function( ServiceRequestModel request)  paid,required TResult Function( SocketEvent event)  socketEvent,required TResult Function( SocketStatus status)  socketStatus,}) {final _that = this;
switch (_that) {
case _Started():
return started(_that.requestId);case _LoadEarlier():
return loadEarlier();case _Sent():
return sent(_that.text);case _Retried():
return retried(_that.clientMessageId);case _AttachmentPicked():
return attachmentPicked(_that.file,_that.name);case _AttachmentRemoved():
return attachmentRemoved(_that.draftId);case _AttachmentOpened():
return attachmentOpened(_that.attachmentId,_that.result);case _Cancelled():
return cancelled();case _Rated():
return rated(_that.rating,_that.comment);case _InvoiceRequested():
return invoiceRequested(_that.result);case _Refreshed():
return refreshed();case _Paid():
return paid(_that.request);case _SocketEvent():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String requestId)?  started,TResult? Function()?  loadEarlier,TResult? Function( String text)?  sent,TResult? Function( String clientMessageId)?  retried,TResult? Function( File file,  String? name)?  attachmentPicked,TResult? Function( String draftId)?  attachmentRemoved,TResult? Function( String attachmentId,  Completer<String?> result)?  attachmentOpened,TResult? Function()?  cancelled,TResult? Function( int rating,  String? comment)?  rated,TResult? Function( Completer<InvoiceLink?> result)?  invoiceRequested,TResult? Function()?  refreshed,TResult? Function( ServiceRequestModel request)?  paid,TResult? Function( SocketEvent event)?  socketEvent,TResult? Function( SocketStatus status)?  socketStatus,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that.requestId);case _LoadEarlier() when loadEarlier != null:
return loadEarlier();case _Sent() when sent != null:
return sent(_that.text);case _Retried() when retried != null:
return retried(_that.clientMessageId);case _AttachmentPicked() when attachmentPicked != null:
return attachmentPicked(_that.file,_that.name);case _AttachmentRemoved() when attachmentRemoved != null:
return attachmentRemoved(_that.draftId);case _AttachmentOpened() when attachmentOpened != null:
return attachmentOpened(_that.attachmentId,_that.result);case _Cancelled() when cancelled != null:
return cancelled();case _Rated() when rated != null:
return rated(_that.rating,_that.comment);case _InvoiceRequested() when invoiceRequested != null:
return invoiceRequested(_that.result);case _Refreshed() when refreshed != null:
return refreshed();case _Paid() when paid != null:
return paid(_that.request);case _SocketEvent() when socketEvent != null:
return socketEvent(_that.event);case _SocketStatus() when socketStatus != null:
return socketStatus(_that.status);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements ServiceChatEvent {
  const _Started(this.requestId);
  

 final  String requestId;

/// Create a copy of ServiceChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartedCopyWith<_Started> get copyWith => __$StartedCopyWithImpl<_Started>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started&&(identical(other.requestId, requestId) || other.requestId == requestId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,requestId);
}

@override
String toString() {
    return 'ServiceChatEvent.started(requestId: $requestId)';
}


}

/// @nodoc
abstract mixin class _$StartedCopyWith<$Res> implements $ServiceChatEventCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) _then) = __$StartedCopyWithImpl;
@useResult
$Res call({
 String requestId
});




}
/// @nodoc
class __$StartedCopyWithImpl<$Res>
    implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(this._self, this._then);

  final _Started _self;
  final $Res Function(_Started) _then;

/// Create a copy of ServiceChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? requestId = null,}) {
  return _then(_Started(
null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LoadEarlier implements ServiceChatEvent {
  const _LoadEarlier();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadEarlier);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServiceChatEvent.loadEarlier()';
}


}




/// @nodoc


class _Sent implements ServiceChatEvent {
  const _Sent(this.text);
  

 final  String text;

/// Create a copy of ServiceChatEvent
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
    return 'ServiceChatEvent.sent(text: $text)';
}


}

/// @nodoc
abstract mixin class _$SentCopyWith<$Res> implements $ServiceChatEventCopyWith<$Res> {
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

/// Create a copy of ServiceChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,}) {
  return _then(_Sent(
null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Retried implements ServiceChatEvent {
  const _Retried(this.clientMessageId);
  

 final  String clientMessageId;

/// Create a copy of ServiceChatEvent
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
    return 'ServiceChatEvent.retried(clientMessageId: $clientMessageId)';
}


}

/// @nodoc
abstract mixin class _$RetriedCopyWith<$Res> implements $ServiceChatEventCopyWith<$Res> {
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

/// Create a copy of ServiceChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? clientMessageId = null,}) {
  return _then(_Retried(
null == clientMessageId ? _self.clientMessageId : clientMessageId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AttachmentPicked implements ServiceChatEvent {
  const _AttachmentPicked(this.file, [this.name]);
  

 final  File file;
 final  String? name;

/// Create a copy of ServiceChatEvent
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
    return 'ServiceChatEvent.attachmentPicked(file: $file, name: $name)';
}


}

/// @nodoc
abstract mixin class _$AttachmentPickedCopyWith<$Res> implements $ServiceChatEventCopyWith<$Res> {
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

/// Create a copy of ServiceChatEvent
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


class _AttachmentRemoved implements ServiceChatEvent {
  const _AttachmentRemoved(this.draftId);
  

 final  String draftId;

/// Create a copy of ServiceChatEvent
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
    return 'ServiceChatEvent.attachmentRemoved(draftId: $draftId)';
}


}

/// @nodoc
abstract mixin class _$AttachmentRemovedCopyWith<$Res> implements $ServiceChatEventCopyWith<$Res> {
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

/// Create a copy of ServiceChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? draftId = null,}) {
  return _then(_AttachmentRemoved(
null == draftId ? _self.draftId : draftId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _AttachmentOpened implements ServiceChatEvent {
  const _AttachmentOpened(this.attachmentId, this.result);
  

 final  String attachmentId;
 final  Completer<String?> result;

/// Create a copy of ServiceChatEvent
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
    return 'ServiceChatEvent.attachmentOpened(attachmentId: $attachmentId, result: $result)';
}


}

/// @nodoc
abstract mixin class _$AttachmentOpenedCopyWith<$Res> implements $ServiceChatEventCopyWith<$Res> {
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

/// Create a copy of ServiceChatEvent
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


class _Cancelled implements ServiceChatEvent {
  const _Cancelled();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cancelled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServiceChatEvent.cancelled()';
}


}




/// @nodoc


class _Rated implements ServiceChatEvent {
  const _Rated(this.rating, this.comment);
  

 final  int rating;
 final  String? comment;

/// Create a copy of ServiceChatEvent
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
    return 'ServiceChatEvent.rated(rating: $rating, comment: $comment)';
}


}

/// @nodoc
abstract mixin class _$RatedCopyWith<$Res> implements $ServiceChatEventCopyWith<$Res> {
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

/// Create a copy of ServiceChatEvent
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


class _InvoiceRequested implements ServiceChatEvent {
  const _InvoiceRequested(this.result);
  

 final  Completer<InvoiceLink?> result;

/// Create a copy of ServiceChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvoiceRequestedCopyWith<_InvoiceRequested> get copyWith => __$InvoiceRequestedCopyWithImpl<_InvoiceRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvoiceRequested&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode {
    return Object.hash(runtimeType,result);
}

@override
String toString() {
    return 'ServiceChatEvent.invoiceRequested(result: $result)';
}


}

/// @nodoc
abstract mixin class _$InvoiceRequestedCopyWith<$Res> implements $ServiceChatEventCopyWith<$Res> {
  factory _$InvoiceRequestedCopyWith(_InvoiceRequested value, $Res Function(_InvoiceRequested) _then) = __$InvoiceRequestedCopyWithImpl;
@useResult
$Res call({
 Completer<InvoiceLink?> result
});




}
/// @nodoc
class __$InvoiceRequestedCopyWithImpl<$Res>
    implements _$InvoiceRequestedCopyWith<$Res> {
  __$InvoiceRequestedCopyWithImpl(this._self, this._then);

  final _InvoiceRequested _self;
  final $Res Function(_InvoiceRequested) _then;

/// Create a copy of ServiceChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(_InvoiceRequested(
null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Completer<InvoiceLink?>,
  ));
}


}

/// @nodoc


class _Refreshed implements ServiceChatEvent {
  const _Refreshed();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Refreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServiceChatEvent.refreshed()';
}


}




/// @nodoc


class _Paid implements ServiceChatEvent {
  const _Paid(this.request);
  

 final  ServiceRequestModel request;

/// Create a copy of ServiceChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaidCopyWith<_Paid> get copyWith => __$PaidCopyWithImpl<_Paid>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Paid&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode {
    return Object.hash(runtimeType,request);
}

@override
String toString() {
    return 'ServiceChatEvent.paid(request: $request)';
}


}

/// @nodoc
abstract mixin class _$PaidCopyWith<$Res> implements $ServiceChatEventCopyWith<$Res> {
  factory _$PaidCopyWith(_Paid value, $Res Function(_Paid) _then) = __$PaidCopyWithImpl;
@useResult
$Res call({
 ServiceRequestModel request
});




}
/// @nodoc
class __$PaidCopyWithImpl<$Res>
    implements _$PaidCopyWith<$Res> {
  __$PaidCopyWithImpl(this._self, this._then);

  final _Paid _self;
  final $Res Function(_Paid) _then;

/// Create a copy of ServiceChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(_Paid(
null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as ServiceRequestModel,
  ));
}


}

/// @nodoc


class _SocketEvent implements ServiceChatEvent {
  const _SocketEvent(this.event);
  

 final  SocketEvent event;

/// Create a copy of ServiceChatEvent
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
    return 'ServiceChatEvent.socketEvent(event: $event)';
}


}

/// @nodoc
abstract mixin class _$SocketEventCopyWith<$Res> implements $ServiceChatEventCopyWith<$Res> {
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

/// Create a copy of ServiceChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? event = null,}) {
  return _then(_SocketEvent(
null == event ? _self.event : event // ignore: cast_nullable_to_non_nullable
as SocketEvent,
  ));
}


}

/// @nodoc


class _SocketStatus implements ServiceChatEvent {
  const _SocketStatus(this.status);
  

 final  SocketStatus status;

/// Create a copy of ServiceChatEvent
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
    return 'ServiceChatEvent.socketStatus(status: $status)';
}


}

/// @nodoc
abstract mixin class _$SocketStatusCopyWith<$Res> implements $ServiceChatEventCopyWith<$Res> {
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

/// Create a copy of ServiceChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(_SocketStatus(
null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SocketStatus,
  ));
}


}

/// @nodoc
mixin _$ServiceChatState {

 RequestState get state;/// A transient failure, shown as a snackbar without disturbing the chat.
 String get message; List<TicketMessageModel> get messages;/// Every quote seen, by id. Quote *cards* read their status from here.
 Map<String, ServiceQuoteModel> get quotes; bool get isLoadingEarlier; SocketStatus get socket; List<TicketAttachmentDraft> get drafts; RequestState get rating; RequestState get cancel; ServiceRequestModel? get request; String? get historyCursor;
/// Create a copy of ServiceChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceChatStateCopyWith<ServiceChatState> get copyWith => _$ServiceChatStateCopyWithImpl<ServiceChatState>(this as ServiceChatState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ServiceChatState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceChatState&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.message, _this.message) || other.message == _this.message)&&const DeepCollectionEquality().equals(other.messages, _this.messages)&&const DeepCollectionEquality().equals(other.quotes, _this.quotes)&&(identical(other.isLoadingEarlier, _this.isLoadingEarlier) || other.isLoadingEarlier == _this.isLoadingEarlier)&&(identical(other.socket, _this.socket) || other.socket == _this.socket)&&const DeepCollectionEquality().equals(other.drafts, _this.drafts)&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.cancel, _this.cancel) || other.cancel == _this.cancel)&&(identical(other.request, _this.request) || other.request == _this.request)&&(identical(other.historyCursor, _this.historyCursor) || other.historyCursor == _this.historyCursor));
}


@override
int get hashCode {
  final _this = this as ServiceChatState;
  return Object.hash(runtimeType,_this.state,_this.message,const DeepCollectionEquality().hash(_this.messages),const DeepCollectionEquality().hash(_this.quotes),_this.isLoadingEarlier,_this.socket,const DeepCollectionEquality().hash(_this.drafts),_this.rating,_this.cancel,_this.request,_this.historyCursor);
}

@override
String toString() {
  final _this = this as ServiceChatState;
  return 'ServiceChatState(state: ${_this.state}, message: ${_this.message}, messages: ${_this.messages}, quotes: ${_this.quotes}, isLoadingEarlier: ${_this.isLoadingEarlier}, socket: ${_this.socket}, drafts: ${_this.drafts}, rating: ${_this.rating}, cancel: ${_this.cancel}, request: ${_this.request}, historyCursor: ${_this.historyCursor})';
}


}

/// @nodoc
abstract mixin class $ServiceChatStateCopyWith<$Res>  {
  factory $ServiceChatStateCopyWith(ServiceChatState value, $Res Function(ServiceChatState) _then) = _$ServiceChatStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, String message, List<TicketMessageModel> messages, Map<String, ServiceQuoteModel> quotes, bool isLoadingEarlier, SocketStatus socket, List<TicketAttachmentDraft> drafts, RequestState rating, RequestState cancel, ServiceRequestModel? request, String? historyCursor
});




}
/// @nodoc
class _$ServiceChatStateCopyWithImpl<$Res>
    implements $ServiceChatStateCopyWith<$Res> {
  _$ServiceChatStateCopyWithImpl(this._self, this._then);

  final ServiceChatState _self;
  final $Res Function(ServiceChatState) _then;

/// Create a copy of ServiceChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? message = null,Object? messages = null,Object? quotes = null,Object? isLoadingEarlier = null,Object? socket = null,Object? drafts = null,Object? rating = null,Object? cancel = null,Object? request = freezed,Object? historyCursor = freezed,}) {
  return _then(ServiceChatState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<TicketMessageModel>,quotes: null == quotes ? _self.quotes : quotes // ignore: cast_nullable_to_non_nullable
as Map<String, ServiceQuoteModel>,isLoadingEarlier: null == isLoadingEarlier ? _self.isLoadingEarlier : isLoadingEarlier // ignore: cast_nullable_to_non_nullable
as bool,socket: null == socket ? _self.socket : socket // ignore: cast_nullable_to_non_nullable
as SocketStatus,drafts: null == drafts ? _self.drafts : drafts // ignore: cast_nullable_to_non_nullable
as List<TicketAttachmentDraft>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as RequestState,cancel: null == cancel ? _self.cancel : cancel // ignore: cast_nullable_to_non_nullable
as RequestState,request: freezed == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as ServiceRequestModel?,historyCursor: freezed == historyCursor ? _self.historyCursor : historyCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceChatState].
extension ServiceChatStatePatterns on ServiceChatState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceChatState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceChatState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceChatState value)  $default,){
final _that = this;
switch (_that) {
case _ServiceChatState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceChatState value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceChatState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  String message,  List<TicketMessageModel> messages,  Map<String, ServiceQuoteModel> quotes,  bool isLoadingEarlier,  SocketStatus socket,  List<TicketAttachmentDraft> drafts,  RequestState rating,  RequestState cancel,  ServiceRequestModel? request,  String? historyCursor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceChatState() when $default != null:
return $default(_that.state,_that.message,_that.messages,_that.quotes,_that.isLoadingEarlier,_that.socket,_that.drafts,_that.rating,_that.cancel,_that.request,_that.historyCursor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  String message,  List<TicketMessageModel> messages,  Map<String, ServiceQuoteModel> quotes,  bool isLoadingEarlier,  SocketStatus socket,  List<TicketAttachmentDraft> drafts,  RequestState rating,  RequestState cancel,  ServiceRequestModel? request,  String? historyCursor)  $default,) {final _that = this;
switch (_that) {
case _ServiceChatState():
return $default(_that.state,_that.message,_that.messages,_that.quotes,_that.isLoadingEarlier,_that.socket,_that.drafts,_that.rating,_that.cancel,_that.request,_that.historyCursor);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  String message,  List<TicketMessageModel> messages,  Map<String, ServiceQuoteModel> quotes,  bool isLoadingEarlier,  SocketStatus socket,  List<TicketAttachmentDraft> drafts,  RequestState rating,  RequestState cancel,  ServiceRequestModel? request,  String? historyCursor)?  $default,) {final _that = this;
switch (_that) {
case _ServiceChatState() when $default != null:
return $default(_that.state,_that.message,_that.messages,_that.quotes,_that.isLoadingEarlier,_that.socket,_that.drafts,_that.rating,_that.cancel,_that.request,_that.historyCursor);case _:
  return null;

}
}

}

/// @nodoc


class _ServiceChatState extends ServiceChatState {
  const _ServiceChatState({required this.state, required this.message, required  List<TicketMessageModel> messages, required  Map<String, ServiceQuoteModel> quotes, required this.isLoadingEarlier, required this.socket, required  List<TicketAttachmentDraft> drafts, required this.rating, required this.cancel, this.request, this.historyCursor}): _messages = messages,_quotes = quotes,_drafts = drafts,super._();
  

@override final  RequestState state;
/// A transient failure, shown as a snackbar without disturbing the chat.
@override final  String message;
 final  List<TicketMessageModel> _messages;
@override List<TicketMessageModel> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

/// Every quote seen, by id. Quote *cards* read their status from here.
 final  Map<String, ServiceQuoteModel> _quotes;
/// Every quote seen, by id. Quote *cards* read their status from here.
@override Map<String, ServiceQuoteModel> get quotes {
  if (_quotes is EqualUnmodifiableMapView) return _quotes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_quotes);
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
@override final  RequestState cancel;
@override final  ServiceRequestModel? request;
@override final  String? historyCursor;

/// Create a copy of ServiceChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceChatStateCopyWith<_ServiceChatState> get copyWith => __$ServiceChatStateCopyWithImpl<_ServiceChatState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceChatState&&(identical(other.state, state) || other.state == state)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.messages, _messages)&&const DeepCollectionEquality().equals(other.quotes, _quotes)&&(identical(other.isLoadingEarlier, isLoadingEarlier) || other.isLoadingEarlier == isLoadingEarlier)&&(identical(other.socket, socket) || other.socket == socket)&&const DeepCollectionEquality().equals(other.drafts, _drafts)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.cancel, cancel) || other.cancel == cancel)&&(identical(other.request, request) || other.request == request)&&(identical(other.historyCursor, historyCursor) || other.historyCursor == historyCursor));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state,message,const DeepCollectionEquality().hash(_messages),const DeepCollectionEquality().hash(_quotes),isLoadingEarlier,socket,const DeepCollectionEquality().hash(_drafts),rating,cancel,request,historyCursor);
}

@override
String toString() {
    return 'ServiceChatState(state: $state, message: $message, messages: $messages, quotes: $quotes, isLoadingEarlier: $isLoadingEarlier, socket: $socket, drafts: $drafts, rating: $rating, cancel: $cancel, request: $request, historyCursor: $historyCursor)';
}


}

/// @nodoc
abstract mixin class _$ServiceChatStateCopyWith<$Res> implements $ServiceChatStateCopyWith<$Res> {
  factory _$ServiceChatStateCopyWith(_ServiceChatState value, $Res Function(_ServiceChatState) _then) = __$ServiceChatStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, String message, List<TicketMessageModel> messages, Map<String, ServiceQuoteModel> quotes, bool isLoadingEarlier, SocketStatus socket, List<TicketAttachmentDraft> drafts, RequestState rating, RequestState cancel, ServiceRequestModel? request, String? historyCursor
});




}
/// @nodoc
class __$ServiceChatStateCopyWithImpl<$Res>
    implements _$ServiceChatStateCopyWith<$Res> {
  __$ServiceChatStateCopyWithImpl(this._self, this._then);

  final _ServiceChatState _self;
  final $Res Function(_ServiceChatState) _then;

/// Create a copy of ServiceChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? message = null,Object? messages = null,Object? quotes = null,Object? isLoadingEarlier = null,Object? socket = null,Object? drafts = null,Object? rating = null,Object? cancel = null,Object? request = freezed,Object? historyCursor = freezed,}) {
  return _then(_ServiceChatState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<TicketMessageModel>,quotes: null == quotes ? _self._quotes : quotes // ignore: cast_nullable_to_non_nullable
as Map<String, ServiceQuoteModel>,isLoadingEarlier: null == isLoadingEarlier ? _self.isLoadingEarlier : isLoadingEarlier // ignore: cast_nullable_to_non_nullable
as bool,socket: null == socket ? _self.socket : socket // ignore: cast_nullable_to_non_nullable
as SocketStatus,drafts: null == drafts ? _self._drafts : drafts // ignore: cast_nullable_to_non_nullable
as List<TicketAttachmentDraft>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as RequestState,cancel: null == cancel ? _self.cancel : cancel // ignore: cast_nullable_to_non_nullable
as RequestState,request: freezed == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as ServiceRequestModel?,historyCursor: freezed == historyCursor ? _self.historyCursor : historyCursor // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
