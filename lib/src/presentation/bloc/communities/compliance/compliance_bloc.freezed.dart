// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compliance_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ComplianceEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ComplianceEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ComplianceEvent()';
}


}

/// @nodoc
class $ComplianceEventCopyWith<$Res>  {
$ComplianceEventCopyWith(ComplianceEvent _, $Res Function(ComplianceEvent) __);
}


/// Adds pattern-matching-related methods to [ComplianceEvent].
extension ComplianceEventPatterns on ComplianceEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _DateOfBirthChanged value)?  dateOfBirthChanged,TResult Function( _PanChanged value)?  panChanged,TResult Function( _ConfirmationToggled value)?  confirmationToggled,TResult Function( _Submit value)?  submit,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _DateOfBirthChanged() when dateOfBirthChanged != null:
return dateOfBirthChanged(_that);case _PanChanged() when panChanged != null:
return panChanged(_that);case _ConfirmationToggled() when confirmationToggled != null:
return confirmationToggled(_that);case _Submit() when submit != null:
return submit(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _DateOfBirthChanged value)  dateOfBirthChanged,required TResult Function( _PanChanged value)  panChanged,required TResult Function( _ConfirmationToggled value)  confirmationToggled,required TResult Function( _Submit value)  submit,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _DateOfBirthChanged():
return dateOfBirthChanged(_that);case _PanChanged():
return panChanged(_that);case _ConfirmationToggled():
return confirmationToggled(_that);case _Submit():
return submit(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _DateOfBirthChanged value)?  dateOfBirthChanged,TResult? Function( _PanChanged value)?  panChanged,TResult? Function( _ConfirmationToggled value)?  confirmationToggled,TResult? Function( _Submit value)?  submit,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _DateOfBirthChanged() when dateOfBirthChanged != null:
return dateOfBirthChanged(_that);case _PanChanged() when panChanged != null:
return panChanged(_that);case _ConfirmationToggled() when confirmationToggled != null:
return confirmationToggled(_that);case _Submit() when submit != null:
return submit(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String value)?  dateOfBirthChanged,TResult Function( String value)?  panChanged,TResult Function()?  confirmationToggled,TResult Function()?  submit,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _DateOfBirthChanged() when dateOfBirthChanged != null:
return dateOfBirthChanged(_that.value);case _PanChanged() when panChanged != null:
return panChanged(_that.value);case _ConfirmationToggled() when confirmationToggled != null:
return confirmationToggled();case _Submit() when submit != null:
return submit();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String value)  dateOfBirthChanged,required TResult Function( String value)  panChanged,required TResult Function()  confirmationToggled,required TResult Function()  submit,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _DateOfBirthChanged():
return dateOfBirthChanged(_that.value);case _PanChanged():
return panChanged(_that.value);case _ConfirmationToggled():
return confirmationToggled();case _Submit():
return submit();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String value)?  dateOfBirthChanged,TResult? Function( String value)?  panChanged,TResult? Function()?  confirmationToggled,TResult? Function()?  submit,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _DateOfBirthChanged() when dateOfBirthChanged != null:
return dateOfBirthChanged(_that.value);case _PanChanged() when panChanged != null:
return panChanged(_that.value);case _ConfirmationToggled() when confirmationToggled != null:
return confirmationToggled();case _Submit() when submit != null:
return submit();case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ComplianceEvent {
  const _Initial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ComplianceEvent.initial()';
}


}




/// @nodoc


class _DateOfBirthChanged implements ComplianceEvent {
  const _DateOfBirthChanged(this.value);
  

 final  String value;

/// Create a copy of ComplianceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DateOfBirthChangedCopyWith<_DateOfBirthChanged> get copyWith => __$DateOfBirthChangedCopyWithImpl<_DateOfBirthChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DateOfBirthChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode {
    return Object.hash(runtimeType,value);
}

@override
String toString() {
    return 'ComplianceEvent.dateOfBirthChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$DateOfBirthChangedCopyWith<$Res> implements $ComplianceEventCopyWith<$Res> {
  factory _$DateOfBirthChangedCopyWith(_DateOfBirthChanged value, $Res Function(_DateOfBirthChanged) _then) = __$DateOfBirthChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$DateOfBirthChangedCopyWithImpl<$Res>
    implements _$DateOfBirthChangedCopyWith<$Res> {
  __$DateOfBirthChangedCopyWithImpl(this._self, this._then);

  final _DateOfBirthChanged _self;
  final $Res Function(_DateOfBirthChanged) _then;

/// Create a copy of ComplianceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_DateOfBirthChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PanChanged implements ComplianceEvent {
  const _PanChanged(this.value);
  

 final  String value;

/// Create a copy of ComplianceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PanChangedCopyWith<_PanChanged> get copyWith => __$PanChangedCopyWithImpl<_PanChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PanChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode {
    return Object.hash(runtimeType,value);
}

@override
String toString() {
    return 'ComplianceEvent.panChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$PanChangedCopyWith<$Res> implements $ComplianceEventCopyWith<$Res> {
  factory _$PanChangedCopyWith(_PanChanged value, $Res Function(_PanChanged) _then) = __$PanChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$PanChangedCopyWithImpl<$Res>
    implements _$PanChangedCopyWith<$Res> {
  __$PanChangedCopyWithImpl(this._self, this._then);

  final _PanChanged _self;
  final $Res Function(_PanChanged) _then;

/// Create a copy of ComplianceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_PanChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ConfirmationToggled implements ComplianceEvent {
  const _ConfirmationToggled();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmationToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ComplianceEvent.confirmationToggled()';
}


}




/// @nodoc


class _Submit implements ComplianceEvent {
  const _Submit();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submit);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ComplianceEvent.submit()';
}


}




/// @nodoc
mixin _$ComplianceState {

 RequestState get state; String get message; String get dateOfBirth; String get pan; bool get confirmed; String? get dateOfBirthError; String? get panError;
/// Create a copy of ComplianceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComplianceStateCopyWith<ComplianceState> get copyWith => _$ComplianceStateCopyWithImpl<ComplianceState>(this as ComplianceState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ComplianceState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComplianceState&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.dateOfBirth, _this.dateOfBirth) || other.dateOfBirth == _this.dateOfBirth)&&(identical(other.pan, _this.pan) || other.pan == _this.pan)&&(identical(other.confirmed, _this.confirmed) || other.confirmed == _this.confirmed)&&(identical(other.dateOfBirthError, _this.dateOfBirthError) || other.dateOfBirthError == _this.dateOfBirthError)&&(identical(other.panError, _this.panError) || other.panError == _this.panError));
}


@override
int get hashCode {
  final _this = this as ComplianceState;
  return Object.hash(runtimeType,_this.state,_this.message,_this.dateOfBirth,_this.pan,_this.confirmed,_this.dateOfBirthError,_this.panError);
}

@override
String toString() {
  final _this = this as ComplianceState;
  return 'ComplianceState(state: ${_this.state}, message: ${_this.message}, dateOfBirth: ${_this.dateOfBirth}, pan: ${_this.pan}, confirmed: ${_this.confirmed}, dateOfBirthError: ${_this.dateOfBirthError}, panError: ${_this.panError})';
}


}

/// @nodoc
abstract mixin class $ComplianceStateCopyWith<$Res>  {
  factory $ComplianceStateCopyWith(ComplianceState value, $Res Function(ComplianceState) _then) = _$ComplianceStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, String message, String dateOfBirth, String pan, bool confirmed, String? dateOfBirthError, String? panError
});




}
/// @nodoc
class _$ComplianceStateCopyWithImpl<$Res>
    implements $ComplianceStateCopyWith<$Res> {
  _$ComplianceStateCopyWithImpl(this._self, this._then);

  final ComplianceState _self;
  final $Res Function(ComplianceState) _then;

/// Create a copy of ComplianceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? message = null,Object? dateOfBirth = null,Object? pan = null,Object? confirmed = null,Object? dateOfBirthError = freezed,Object? panError = freezed,}) {
  return _then(ComplianceState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: null == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String,pan: null == pan ? _self.pan : pan // ignore: cast_nullable_to_non_nullable
as String,confirmed: null == confirmed ? _self.confirmed : confirmed // ignore: cast_nullable_to_non_nullable
as bool,dateOfBirthError: freezed == dateOfBirthError ? _self.dateOfBirthError : dateOfBirthError // ignore: cast_nullable_to_non_nullable
as String?,panError: freezed == panError ? _self.panError : panError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ComplianceState].
extension ComplianceStatePatterns on ComplianceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComplianceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComplianceState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComplianceState value)  $default,){
final _that = this;
switch (_that) {
case _ComplianceState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComplianceState value)?  $default,){
final _that = this;
switch (_that) {
case _ComplianceState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  String message,  String dateOfBirth,  String pan,  bool confirmed,  String? dateOfBirthError,  String? panError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComplianceState() when $default != null:
return $default(_that.state,_that.message,_that.dateOfBirth,_that.pan,_that.confirmed,_that.dateOfBirthError,_that.panError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  String message,  String dateOfBirth,  String pan,  bool confirmed,  String? dateOfBirthError,  String? panError)  $default,) {final _that = this;
switch (_that) {
case _ComplianceState():
return $default(_that.state,_that.message,_that.dateOfBirth,_that.pan,_that.confirmed,_that.dateOfBirthError,_that.panError);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  String message,  String dateOfBirth,  String pan,  bool confirmed,  String? dateOfBirthError,  String? panError)?  $default,) {final _that = this;
switch (_that) {
case _ComplianceState() when $default != null:
return $default(_that.state,_that.message,_that.dateOfBirth,_that.pan,_that.confirmed,_that.dateOfBirthError,_that.panError);case _:
  return null;

}
}

}

/// @nodoc


class _ComplianceState implements ComplianceState {
  const _ComplianceState({required this.state, required this.message, required this.dateOfBirth, required this.pan, required this.confirmed, this.dateOfBirthError, this.panError});
  

@override final  RequestState state;
@override final  String message;
@override final  String dateOfBirth;
@override final  String pan;
@override final  bool confirmed;
@override final  String? dateOfBirthError;
@override final  String? panError;

/// Create a copy of ComplianceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComplianceStateCopyWith<_ComplianceState> get copyWith => __$ComplianceStateCopyWithImpl<_ComplianceState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComplianceState&&(identical(other.state, state) || other.state == state)&&(identical(other.message, message) || other.message == message)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.pan, pan) || other.pan == pan)&&(identical(other.confirmed, confirmed) || other.confirmed == confirmed)&&(identical(other.dateOfBirthError, dateOfBirthError) || other.dateOfBirthError == dateOfBirthError)&&(identical(other.panError, panError) || other.panError == panError));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state,message,dateOfBirth,pan,confirmed,dateOfBirthError,panError);
}

@override
String toString() {
    return 'ComplianceState(state: $state, message: $message, dateOfBirth: $dateOfBirth, pan: $pan, confirmed: $confirmed, dateOfBirthError: $dateOfBirthError, panError: $panError)';
}


}

/// @nodoc
abstract mixin class _$ComplianceStateCopyWith<$Res> implements $ComplianceStateCopyWith<$Res> {
  factory _$ComplianceStateCopyWith(_ComplianceState value, $Res Function(_ComplianceState) _then) = __$ComplianceStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, String message, String dateOfBirth, String pan, bool confirmed, String? dateOfBirthError, String? panError
});




}
/// @nodoc
class __$ComplianceStateCopyWithImpl<$Res>
    implements _$ComplianceStateCopyWith<$Res> {
  __$ComplianceStateCopyWithImpl(this._self, this._then);

  final _ComplianceState _self;
  final $Res Function(_ComplianceState) _then;

/// Create a copy of ComplianceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? message = null,Object? dateOfBirth = null,Object? pan = null,Object? confirmed = null,Object? dateOfBirthError = freezed,Object? panError = freezed,}) {
  return _then(_ComplianceState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: null == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String,pan: null == pan ? _self.pan : pan // ignore: cast_nullable_to_non_nullable
as String,confirmed: null == confirmed ? _self.confirmed : confirmed // ignore: cast_nullable_to_non_nullable
as bool,dateOfBirthError: freezed == dateOfBirthError ? _self.dateOfBirthError : dateOfBirthError // ignore: cast_nullable_to_non_nullable
as String?,panError: freezed == panError ? _self.panError : panError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
