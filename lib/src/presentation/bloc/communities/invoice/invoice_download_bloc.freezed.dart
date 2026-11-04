// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice_download_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InvoiceDownloadEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is InvoiceDownloadEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'InvoiceDownloadEvent()';
}


}

/// @nodoc
class $InvoiceDownloadEventCopyWith<$Res>  {
$InvoiceDownloadEventCopyWith(InvoiceDownloadEvent _, $Res Function(InvoiceDownloadEvent) __);
}


/// Adds pattern-matching-related methods to [InvoiceDownloadEvent].
extension InvoiceDownloadEventPatterns on InvoiceDownloadEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Requested value)?  requested,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Requested() when requested != null:
return requested(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Requested value)  requested,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _Requested():
return requested(_that);case _Reset():
return reset(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Requested value)?  requested,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _Requested() when requested != null:
return requested(_that);case _Reset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String invoiceId)?  requested,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Requested() when requested != null:
return requested(_that.invoiceId);case _Reset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String invoiceId)  requested,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _Requested():
return requested(_that.invoiceId);case _Reset():
return reset();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String invoiceId)?  requested,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _Requested() when requested != null:
return requested(_that.invoiceId);case _Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _Requested implements InvoiceDownloadEvent {
  const _Requested(this.invoiceId);
  

 final  String invoiceId;

/// Create a copy of InvoiceDownloadEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RequestedCopyWith<_Requested> get copyWith => __$RequestedCopyWithImpl<_Requested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Requested&&(identical(other.invoiceId, invoiceId) || other.invoiceId == invoiceId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,invoiceId);
}

@override
String toString() {
    return 'InvoiceDownloadEvent.requested(invoiceId: $invoiceId)';
}


}

/// @nodoc
abstract mixin class _$RequestedCopyWith<$Res> implements $InvoiceDownloadEventCopyWith<$Res> {
  factory _$RequestedCopyWith(_Requested value, $Res Function(_Requested) _then) = __$RequestedCopyWithImpl;
@useResult
$Res call({
 String invoiceId
});




}
/// @nodoc
class __$RequestedCopyWithImpl<$Res>
    implements _$RequestedCopyWith<$Res> {
  __$RequestedCopyWithImpl(this._self, this._then);

  final _Requested _self;
  final $Res Function(_Requested) _then;

/// Create a copy of InvoiceDownloadEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? invoiceId = null,}) {
  return _then(_Requested(
null == invoiceId ? _self.invoiceId : invoiceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Reset implements InvoiceDownloadEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'InvoiceDownloadEvent.reset()';
}


}




/// @nodoc
mixin _$InvoiceDownloadState {

 RequestState get state;/// The server's own words for a failure, shown as a snackbar.
 String get message;/// The link the screen should open **right now**. Set only on the
/// `loading → loaded` step and cleared by the next tap's `loading`, so it
/// is never a thing to read later: it expires in minutes.
 InvoiceLink? get link;
/// Create a copy of InvoiceDownloadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvoiceDownloadStateCopyWith<InvoiceDownloadState> get copyWith => _$InvoiceDownloadStateCopyWithImpl<InvoiceDownloadState>(this as InvoiceDownloadState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as InvoiceDownloadState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvoiceDownloadState&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.link, _this.link) || other.link == _this.link));
}


@override
int get hashCode {
  final _this = this as InvoiceDownloadState;
  return Object.hash(runtimeType,_this.state,_this.message,_this.link);
}

@override
String toString() {
  final _this = this as InvoiceDownloadState;
  return 'InvoiceDownloadState(state: ${_this.state}, message: ${_this.message}, link: ${_this.link})';
}


}

/// @nodoc
abstract mixin class $InvoiceDownloadStateCopyWith<$Res>  {
  factory $InvoiceDownloadStateCopyWith(InvoiceDownloadState value, $Res Function(InvoiceDownloadState) _then) = _$InvoiceDownloadStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, String message, InvoiceLink? link
});




}
/// @nodoc
class _$InvoiceDownloadStateCopyWithImpl<$Res>
    implements $InvoiceDownloadStateCopyWith<$Res> {
  _$InvoiceDownloadStateCopyWithImpl(this._self, this._then);

  final InvoiceDownloadState _self;
  final $Res Function(InvoiceDownloadState) _then;

/// Create a copy of InvoiceDownloadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? message = null,Object? link = freezed,}) {
  return _then(InvoiceDownloadState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as InvoiceLink?,
  ));
}

}


/// Adds pattern-matching-related methods to [InvoiceDownloadState].
extension InvoiceDownloadStatePatterns on InvoiceDownloadState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvoiceDownloadState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvoiceDownloadState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvoiceDownloadState value)  $default,){
final _that = this;
switch (_that) {
case _InvoiceDownloadState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvoiceDownloadState value)?  $default,){
final _that = this;
switch (_that) {
case _InvoiceDownloadState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  String message,  InvoiceLink? link)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvoiceDownloadState() when $default != null:
return $default(_that.state,_that.message,_that.link);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  String message,  InvoiceLink? link)  $default,) {final _that = this;
switch (_that) {
case _InvoiceDownloadState():
return $default(_that.state,_that.message,_that.link);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  String message,  InvoiceLink? link)?  $default,) {final _that = this;
switch (_that) {
case _InvoiceDownloadState() when $default != null:
return $default(_that.state,_that.message,_that.link);case _:
  return null;

}
}

}

/// @nodoc


class _InvoiceDownloadState implements InvoiceDownloadState {
  const _InvoiceDownloadState({this.state = RequestState.empty, this.message = '', this.link});
  

@override@JsonKey() final  RequestState state;
/// The server's own words for a failure, shown as a snackbar.
@override@JsonKey() final  String message;
/// The link the screen should open **right now**. Set only on the
/// `loading → loaded` step and cleared by the next tap's `loading`, so it
/// is never a thing to read later: it expires in minutes.
@override final  InvoiceLink? link;

/// Create a copy of InvoiceDownloadState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvoiceDownloadStateCopyWith<_InvoiceDownloadState> get copyWith => __$InvoiceDownloadStateCopyWithImpl<_InvoiceDownloadState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvoiceDownloadState&&(identical(other.state, state) || other.state == state)&&(identical(other.message, message) || other.message == message)&&(identical(other.link, link) || other.link == link));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state,message,link);
}

@override
String toString() {
    return 'InvoiceDownloadState(state: $state, message: $message, link: $link)';
}


}

/// @nodoc
abstract mixin class _$InvoiceDownloadStateCopyWith<$Res> implements $InvoiceDownloadStateCopyWith<$Res> {
  factory _$InvoiceDownloadStateCopyWith(_InvoiceDownloadState value, $Res Function(_InvoiceDownloadState) _then) = __$InvoiceDownloadStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, String message, InvoiceLink? link
});




}
/// @nodoc
class __$InvoiceDownloadStateCopyWithImpl<$Res>
    implements _$InvoiceDownloadStateCopyWith<$Res> {
  __$InvoiceDownloadStateCopyWithImpl(this._self, this._then);

  final _InvoiceDownloadState _self;
  final $Res Function(_InvoiceDownloadState) _then;

/// Create a copy of InvoiceDownloadState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? message = null,Object? link = freezed,}) {
  return _then(_InvoiceDownloadState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as InvoiceLink?,
  ));
}


}

// dart format on
