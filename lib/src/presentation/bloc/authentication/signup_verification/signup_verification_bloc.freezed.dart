// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_verification_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignupVerificationEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupVerificationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignupVerificationEvent()';
}


}

/// @nodoc
class $SignupVerificationEventCopyWith<$Res>  {
$SignupVerificationEventCopyWith(SignupVerificationEvent _, $Res Function(SignupVerificationEvent) __);
}


/// Adds pattern-matching-related methods to [SignupVerificationEvent].
extension SignupVerificationEventPatterns on SignupVerificationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Prefill value)?  prefill,TResult Function( _SendPhoneCode value)?  sendPhoneCode,TResult Function( _PhoneCodeChanged value)?  phoneCodeChanged,TResult Function( _VerifyPhoneCode value)?  verifyPhoneCode,TResult Function( _ResendPhoneCode value)?  resendPhoneCode,TResult Function( _PhoneTick value)?  phoneTick,TResult Function( _EmailCodeChanged value)?  emailCodeChanged,TResult Function( _VerifyEmailCode value)?  verifyEmailCode,TResult Function( _ResendEmailCode value)?  resendEmailCode,TResult Function( _EmailTick value)?  emailTick,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Prefill() when prefill != null:
return prefill(_that);case _SendPhoneCode() when sendPhoneCode != null:
return sendPhoneCode(_that);case _PhoneCodeChanged() when phoneCodeChanged != null:
return phoneCodeChanged(_that);case _VerifyPhoneCode() when verifyPhoneCode != null:
return verifyPhoneCode(_that);case _ResendPhoneCode() when resendPhoneCode != null:
return resendPhoneCode(_that);case _PhoneTick() when phoneTick != null:
return phoneTick(_that);case _EmailCodeChanged() when emailCodeChanged != null:
return emailCodeChanged(_that);case _VerifyEmailCode() when verifyEmailCode != null:
return verifyEmailCode(_that);case _ResendEmailCode() when resendEmailCode != null:
return resendEmailCode(_that);case _EmailTick() when emailTick != null:
return emailTick(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Prefill value)  prefill,required TResult Function( _SendPhoneCode value)  sendPhoneCode,required TResult Function( _PhoneCodeChanged value)  phoneCodeChanged,required TResult Function( _VerifyPhoneCode value)  verifyPhoneCode,required TResult Function( _ResendPhoneCode value)  resendPhoneCode,required TResult Function( _PhoneTick value)  phoneTick,required TResult Function( _EmailCodeChanged value)  emailCodeChanged,required TResult Function( _VerifyEmailCode value)  verifyEmailCode,required TResult Function( _ResendEmailCode value)  resendEmailCode,required TResult Function( _EmailTick value)  emailTick,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Prefill():
return prefill(_that);case _SendPhoneCode():
return sendPhoneCode(_that);case _PhoneCodeChanged():
return phoneCodeChanged(_that);case _VerifyPhoneCode():
return verifyPhoneCode(_that);case _ResendPhoneCode():
return resendPhoneCode(_that);case _PhoneTick():
return phoneTick(_that);case _EmailCodeChanged():
return emailCodeChanged(_that);case _VerifyEmailCode():
return verifyEmailCode(_that);case _ResendEmailCode():
return resendEmailCode(_that);case _EmailTick():
return emailTick(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Prefill value)?  prefill,TResult? Function( _SendPhoneCode value)?  sendPhoneCode,TResult? Function( _PhoneCodeChanged value)?  phoneCodeChanged,TResult? Function( _VerifyPhoneCode value)?  verifyPhoneCode,TResult? Function( _ResendPhoneCode value)?  resendPhoneCode,TResult? Function( _PhoneTick value)?  phoneTick,TResult? Function( _EmailCodeChanged value)?  emailCodeChanged,TResult? Function( _VerifyEmailCode value)?  verifyEmailCode,TResult? Function( _ResendEmailCode value)?  resendEmailCode,TResult? Function( _EmailTick value)?  emailTick,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Prefill() when prefill != null:
return prefill(_that);case _SendPhoneCode() when sendPhoneCode != null:
return sendPhoneCode(_that);case _PhoneCodeChanged() when phoneCodeChanged != null:
return phoneCodeChanged(_that);case _VerifyPhoneCode() when verifyPhoneCode != null:
return verifyPhoneCode(_that);case _ResendPhoneCode() when resendPhoneCode != null:
return resendPhoneCode(_that);case _PhoneTick() when phoneTick != null:
return phoneTick(_that);case _EmailCodeChanged() when emailCodeChanged != null:
return emailCodeChanged(_that);case _VerifyEmailCode() when verifyEmailCode != null:
return verifyEmailCode(_that);case _ResendEmailCode() when resendEmailCode != null:
return resendEmailCode(_that);case _EmailTick() when emailTick != null:
return emailTick(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String phoneDisplay,  String email,  bool isFromSocial)?  prefill,TResult Function()?  sendPhoneCode,TResult Function( String code)?  phoneCodeChanged,TResult Function()?  verifyPhoneCode,TResult Function()?  resendPhoneCode,TResult Function()?  phoneTick,TResult Function( String code)?  emailCodeChanged,TResult Function()?  verifyEmailCode,TResult Function()?  resendEmailCode,TResult Function()?  emailTick,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Prefill() when prefill != null:
return prefill(_that.phoneDisplay,_that.email,_that.isFromSocial);case _SendPhoneCode() when sendPhoneCode != null:
return sendPhoneCode();case _PhoneCodeChanged() when phoneCodeChanged != null:
return phoneCodeChanged(_that.code);case _VerifyPhoneCode() when verifyPhoneCode != null:
return verifyPhoneCode();case _ResendPhoneCode() when resendPhoneCode != null:
return resendPhoneCode();case _PhoneTick() when phoneTick != null:
return phoneTick();case _EmailCodeChanged() when emailCodeChanged != null:
return emailCodeChanged(_that.code);case _VerifyEmailCode() when verifyEmailCode != null:
return verifyEmailCode();case _ResendEmailCode() when resendEmailCode != null:
return resendEmailCode();case _EmailTick() when emailTick != null:
return emailTick();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String phoneDisplay,  String email,  bool isFromSocial)  prefill,required TResult Function()  sendPhoneCode,required TResult Function( String code)  phoneCodeChanged,required TResult Function()  verifyPhoneCode,required TResult Function()  resendPhoneCode,required TResult Function()  phoneTick,required TResult Function( String code)  emailCodeChanged,required TResult Function()  verifyEmailCode,required TResult Function()  resendEmailCode,required TResult Function()  emailTick,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Prefill():
return prefill(_that.phoneDisplay,_that.email,_that.isFromSocial);case _SendPhoneCode():
return sendPhoneCode();case _PhoneCodeChanged():
return phoneCodeChanged(_that.code);case _VerifyPhoneCode():
return verifyPhoneCode();case _ResendPhoneCode():
return resendPhoneCode();case _PhoneTick():
return phoneTick();case _EmailCodeChanged():
return emailCodeChanged(_that.code);case _VerifyEmailCode():
return verifyEmailCode();case _ResendEmailCode():
return resendEmailCode();case _EmailTick():
return emailTick();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String phoneDisplay,  String email,  bool isFromSocial)?  prefill,TResult? Function()?  sendPhoneCode,TResult? Function( String code)?  phoneCodeChanged,TResult? Function()?  verifyPhoneCode,TResult? Function()?  resendPhoneCode,TResult? Function()?  phoneTick,TResult? Function( String code)?  emailCodeChanged,TResult? Function()?  verifyEmailCode,TResult? Function()?  resendEmailCode,TResult? Function()?  emailTick,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Prefill() when prefill != null:
return prefill(_that.phoneDisplay,_that.email,_that.isFromSocial);case _SendPhoneCode() when sendPhoneCode != null:
return sendPhoneCode();case _PhoneCodeChanged() when phoneCodeChanged != null:
return phoneCodeChanged(_that.code);case _VerifyPhoneCode() when verifyPhoneCode != null:
return verifyPhoneCode();case _ResendPhoneCode() when resendPhoneCode != null:
return resendPhoneCode();case _PhoneTick() when phoneTick != null:
return phoneTick();case _EmailCodeChanged() when emailCodeChanged != null:
return emailCodeChanged(_that.code);case _VerifyEmailCode() when verifyEmailCode != null:
return verifyEmailCode();case _ResendEmailCode() when resendEmailCode != null:
return resendEmailCode();case _EmailTick() when emailTick != null:
return emailTick();case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements SignupVerificationEvent {
  const _Initial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignupVerificationEvent.initial()';
}


}




/// @nodoc


class _Prefill implements SignupVerificationEvent {
  const _Prefill({required this.phoneDisplay, required this.email, required this.isFromSocial});
  

 final  String phoneDisplay;
 final  String email;
 final  bool isFromSocial;

/// Create a copy of SignupVerificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrefillCopyWith<_Prefill> get copyWith => __$PrefillCopyWithImpl<_Prefill>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Prefill&&(identical(other.phoneDisplay, phoneDisplay) || other.phoneDisplay == phoneDisplay)&&(identical(other.email, email) || other.email == email)&&(identical(other.isFromSocial, isFromSocial) || other.isFromSocial == isFromSocial));
}


@override
int get hashCode {
    return Object.hash(runtimeType,phoneDisplay,email,isFromSocial);
}

@override
String toString() {
    return 'SignupVerificationEvent.prefill(phoneDisplay: $phoneDisplay, email: $email, isFromSocial: $isFromSocial)';
}


}

/// @nodoc
abstract mixin class _$PrefillCopyWith<$Res> implements $SignupVerificationEventCopyWith<$Res> {
  factory _$PrefillCopyWith(_Prefill value, $Res Function(_Prefill) _then) = __$PrefillCopyWithImpl;
@useResult
$Res call({
 String phoneDisplay, String email, bool isFromSocial
});




}
/// @nodoc
class __$PrefillCopyWithImpl<$Res>
    implements _$PrefillCopyWith<$Res> {
  __$PrefillCopyWithImpl(this._self, this._then);

  final _Prefill _self;
  final $Res Function(_Prefill) _then;

/// Create a copy of SignupVerificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phoneDisplay = null,Object? email = null,Object? isFromSocial = null,}) {
  return _then(_Prefill(
phoneDisplay: null == phoneDisplay ? _self.phoneDisplay : phoneDisplay // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,isFromSocial: null == isFromSocial ? _self.isFromSocial : isFromSocial // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _SendPhoneCode implements SignupVerificationEvent {
  const _SendPhoneCode();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendPhoneCode);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignupVerificationEvent.sendPhoneCode()';
}


}




/// @nodoc


class _PhoneCodeChanged implements SignupVerificationEvent {
  const _PhoneCodeChanged(this.code);
  

 final  String code;

/// Create a copy of SignupVerificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneCodeChangedCopyWith<_PhoneCodeChanged> get copyWith => __$PhoneCodeChangedCopyWithImpl<_PhoneCodeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneCodeChanged&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode {
    return Object.hash(runtimeType,code);
}

@override
String toString() {
    return 'SignupVerificationEvent.phoneCodeChanged(code: $code)';
}


}

/// @nodoc
abstract mixin class _$PhoneCodeChangedCopyWith<$Res> implements $SignupVerificationEventCopyWith<$Res> {
  factory _$PhoneCodeChangedCopyWith(_PhoneCodeChanged value, $Res Function(_PhoneCodeChanged) _then) = __$PhoneCodeChangedCopyWithImpl;
@useResult
$Res call({
 String code
});




}
/// @nodoc
class __$PhoneCodeChangedCopyWithImpl<$Res>
    implements _$PhoneCodeChangedCopyWith<$Res> {
  __$PhoneCodeChangedCopyWithImpl(this._self, this._then);

  final _PhoneCodeChanged _self;
  final $Res Function(_PhoneCodeChanged) _then;

/// Create a copy of SignupVerificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
  return _then(_PhoneCodeChanged(
null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _VerifyPhoneCode implements SignupVerificationEvent {
  const _VerifyPhoneCode();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyPhoneCode);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignupVerificationEvent.verifyPhoneCode()';
}


}




/// @nodoc


class _ResendPhoneCode implements SignupVerificationEvent {
  const _ResendPhoneCode();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResendPhoneCode);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignupVerificationEvent.resendPhoneCode()';
}


}




/// @nodoc


class _PhoneTick implements SignupVerificationEvent {
  const _PhoneTick();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneTick);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignupVerificationEvent.phoneTick()';
}


}




/// @nodoc


class _EmailCodeChanged implements SignupVerificationEvent {
  const _EmailCodeChanged(this.code);
  

 final  String code;

/// Create a copy of SignupVerificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailCodeChangedCopyWith<_EmailCodeChanged> get copyWith => __$EmailCodeChangedCopyWithImpl<_EmailCodeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailCodeChanged&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode {
    return Object.hash(runtimeType,code);
}

@override
String toString() {
    return 'SignupVerificationEvent.emailCodeChanged(code: $code)';
}


}

/// @nodoc
abstract mixin class _$EmailCodeChangedCopyWith<$Res> implements $SignupVerificationEventCopyWith<$Res> {
  factory _$EmailCodeChangedCopyWith(_EmailCodeChanged value, $Res Function(_EmailCodeChanged) _then) = __$EmailCodeChangedCopyWithImpl;
@useResult
$Res call({
 String code
});




}
/// @nodoc
class __$EmailCodeChangedCopyWithImpl<$Res>
    implements _$EmailCodeChangedCopyWith<$Res> {
  __$EmailCodeChangedCopyWithImpl(this._self, this._then);

  final _EmailCodeChanged _self;
  final $Res Function(_EmailCodeChanged) _then;

/// Create a copy of SignupVerificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
  return _then(_EmailCodeChanged(
null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _VerifyEmailCode implements SignupVerificationEvent {
  const _VerifyEmailCode();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyEmailCode);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignupVerificationEvent.verifyEmailCode()';
}


}




/// @nodoc


class _ResendEmailCode implements SignupVerificationEvent {
  const _ResendEmailCode();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResendEmailCode);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignupVerificationEvent.resendEmailCode()';
}


}




/// @nodoc


class _EmailTick implements SignupVerificationEvent {
  const _EmailTick();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailTick);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignupVerificationEvent.emailTick()';
}


}




/// @nodoc
mixin _$SignupVerificationState {

 RequestState get state; String get phoneDisplay; String get email; bool get isFromSocial; String get phoneCode; int get phoneResendSeconds; String get emailCode; int get emailResendSeconds; String? get phoneCodeError; String? get emailCodeError;
/// Create a copy of SignupVerificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupVerificationStateCopyWith<SignupVerificationState> get copyWith => _$SignupVerificationStateCopyWithImpl<SignupVerificationState>(this as SignupVerificationState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SignupVerificationState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupVerificationState&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.phoneDisplay, _this.phoneDisplay) || other.phoneDisplay == _this.phoneDisplay)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.isFromSocial, _this.isFromSocial) || other.isFromSocial == _this.isFromSocial)&&(identical(other.phoneCode, _this.phoneCode) || other.phoneCode == _this.phoneCode)&&(identical(other.phoneResendSeconds, _this.phoneResendSeconds) || other.phoneResendSeconds == _this.phoneResendSeconds)&&(identical(other.emailCode, _this.emailCode) || other.emailCode == _this.emailCode)&&(identical(other.emailResendSeconds, _this.emailResendSeconds) || other.emailResendSeconds == _this.emailResendSeconds)&&(identical(other.phoneCodeError, _this.phoneCodeError) || other.phoneCodeError == _this.phoneCodeError)&&(identical(other.emailCodeError, _this.emailCodeError) || other.emailCodeError == _this.emailCodeError));
}


@override
int get hashCode {
  final _this = this as SignupVerificationState;
  return Object.hash(runtimeType,_this.state,_this.phoneDisplay,_this.email,_this.isFromSocial,_this.phoneCode,_this.phoneResendSeconds,_this.emailCode,_this.emailResendSeconds,_this.phoneCodeError,_this.emailCodeError);
}

@override
String toString() {
  final _this = this as SignupVerificationState;
  return 'SignupVerificationState(state: ${_this.state}, phoneDisplay: ${_this.phoneDisplay}, email: ${_this.email}, isFromSocial: ${_this.isFromSocial}, phoneCode: ${_this.phoneCode}, phoneResendSeconds: ${_this.phoneResendSeconds}, emailCode: ${_this.emailCode}, emailResendSeconds: ${_this.emailResendSeconds}, phoneCodeError: ${_this.phoneCodeError}, emailCodeError: ${_this.emailCodeError})';
}


}

/// @nodoc
abstract mixin class $SignupVerificationStateCopyWith<$Res>  {
  factory $SignupVerificationStateCopyWith(SignupVerificationState value, $Res Function(SignupVerificationState) _then) = _$SignupVerificationStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, String phoneDisplay, String email, bool isFromSocial, String phoneCode, int phoneResendSeconds, String emailCode, int emailResendSeconds, String? phoneCodeError, String? emailCodeError
});




}
/// @nodoc
class _$SignupVerificationStateCopyWithImpl<$Res>
    implements $SignupVerificationStateCopyWith<$Res> {
  _$SignupVerificationStateCopyWithImpl(this._self, this._then);

  final SignupVerificationState _self;
  final $Res Function(SignupVerificationState) _then;

/// Create a copy of SignupVerificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? phoneDisplay = null,Object? email = null,Object? isFromSocial = null,Object? phoneCode = null,Object? phoneResendSeconds = null,Object? emailCode = null,Object? emailResendSeconds = null,Object? phoneCodeError = freezed,Object? emailCodeError = freezed,}) {
  return _then(SignupVerificationState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,phoneDisplay: null == phoneDisplay ? _self.phoneDisplay : phoneDisplay // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,isFromSocial: null == isFromSocial ? _self.isFromSocial : isFromSocial // ignore: cast_nullable_to_non_nullable
as bool,phoneCode: null == phoneCode ? _self.phoneCode : phoneCode // ignore: cast_nullable_to_non_nullable
as String,phoneResendSeconds: null == phoneResendSeconds ? _self.phoneResendSeconds : phoneResendSeconds // ignore: cast_nullable_to_non_nullable
as int,emailCode: null == emailCode ? _self.emailCode : emailCode // ignore: cast_nullable_to_non_nullable
as String,emailResendSeconds: null == emailResendSeconds ? _self.emailResendSeconds : emailResendSeconds // ignore: cast_nullable_to_non_nullable
as int,phoneCodeError: freezed == phoneCodeError ? _self.phoneCodeError : phoneCodeError // ignore: cast_nullable_to_non_nullable
as String?,emailCodeError: freezed == emailCodeError ? _self.emailCodeError : emailCodeError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SignupVerificationState].
extension SignupVerificationStatePatterns on SignupVerificationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignupVerificationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignupVerificationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignupVerificationState value)  $default,){
final _that = this;
switch (_that) {
case _SignupVerificationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignupVerificationState value)?  $default,){
final _that = this;
switch (_that) {
case _SignupVerificationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  String phoneDisplay,  String email,  bool isFromSocial,  String phoneCode,  int phoneResendSeconds,  String emailCode,  int emailResendSeconds,  String? phoneCodeError,  String? emailCodeError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignupVerificationState() when $default != null:
return $default(_that.state,_that.phoneDisplay,_that.email,_that.isFromSocial,_that.phoneCode,_that.phoneResendSeconds,_that.emailCode,_that.emailResendSeconds,_that.phoneCodeError,_that.emailCodeError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  String phoneDisplay,  String email,  bool isFromSocial,  String phoneCode,  int phoneResendSeconds,  String emailCode,  int emailResendSeconds,  String? phoneCodeError,  String? emailCodeError)  $default,) {final _that = this;
switch (_that) {
case _SignupVerificationState():
return $default(_that.state,_that.phoneDisplay,_that.email,_that.isFromSocial,_that.phoneCode,_that.phoneResendSeconds,_that.emailCode,_that.emailResendSeconds,_that.phoneCodeError,_that.emailCodeError);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  String phoneDisplay,  String email,  bool isFromSocial,  String phoneCode,  int phoneResendSeconds,  String emailCode,  int emailResendSeconds,  String? phoneCodeError,  String? emailCodeError)?  $default,) {final _that = this;
switch (_that) {
case _SignupVerificationState() when $default != null:
return $default(_that.state,_that.phoneDisplay,_that.email,_that.isFromSocial,_that.phoneCode,_that.phoneResendSeconds,_that.emailCode,_that.emailResendSeconds,_that.phoneCodeError,_that.emailCodeError);case _:
  return null;

}
}

}

/// @nodoc


class _SignupVerificationState implements SignupVerificationState {
  const _SignupVerificationState({required this.state, required this.phoneDisplay, required this.email, required this.isFromSocial, required this.phoneCode, required this.phoneResendSeconds, required this.emailCode, required this.emailResendSeconds, this.phoneCodeError, this.emailCodeError});
  

@override final  RequestState state;
@override final  String phoneDisplay;
@override final  String email;
@override final  bool isFromSocial;
@override final  String phoneCode;
@override final  int phoneResendSeconds;
@override final  String emailCode;
@override final  int emailResendSeconds;
@override final  String? phoneCodeError;
@override final  String? emailCodeError;

/// Create a copy of SignupVerificationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignupVerificationStateCopyWith<_SignupVerificationState> get copyWith => __$SignupVerificationStateCopyWithImpl<_SignupVerificationState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignupVerificationState&&(identical(other.state, state) || other.state == state)&&(identical(other.phoneDisplay, phoneDisplay) || other.phoneDisplay == phoneDisplay)&&(identical(other.email, email) || other.email == email)&&(identical(other.isFromSocial, isFromSocial) || other.isFromSocial == isFromSocial)&&(identical(other.phoneCode, phoneCode) || other.phoneCode == phoneCode)&&(identical(other.phoneResendSeconds, phoneResendSeconds) || other.phoneResendSeconds == phoneResendSeconds)&&(identical(other.emailCode, emailCode) || other.emailCode == emailCode)&&(identical(other.emailResendSeconds, emailResendSeconds) || other.emailResendSeconds == emailResendSeconds)&&(identical(other.phoneCodeError, phoneCodeError) || other.phoneCodeError == phoneCodeError)&&(identical(other.emailCodeError, emailCodeError) || other.emailCodeError == emailCodeError));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state,phoneDisplay,email,isFromSocial,phoneCode,phoneResendSeconds,emailCode,emailResendSeconds,phoneCodeError,emailCodeError);
}

@override
String toString() {
    return 'SignupVerificationState(state: $state, phoneDisplay: $phoneDisplay, email: $email, isFromSocial: $isFromSocial, phoneCode: $phoneCode, phoneResendSeconds: $phoneResendSeconds, emailCode: $emailCode, emailResendSeconds: $emailResendSeconds, phoneCodeError: $phoneCodeError, emailCodeError: $emailCodeError)';
}


}

/// @nodoc
abstract mixin class _$SignupVerificationStateCopyWith<$Res> implements $SignupVerificationStateCopyWith<$Res> {
  factory _$SignupVerificationStateCopyWith(_SignupVerificationState value, $Res Function(_SignupVerificationState) _then) = __$SignupVerificationStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, String phoneDisplay, String email, bool isFromSocial, String phoneCode, int phoneResendSeconds, String emailCode, int emailResendSeconds, String? phoneCodeError, String? emailCodeError
});




}
/// @nodoc
class __$SignupVerificationStateCopyWithImpl<$Res>
    implements _$SignupVerificationStateCopyWith<$Res> {
  __$SignupVerificationStateCopyWithImpl(this._self, this._then);

  final _SignupVerificationState _self;
  final $Res Function(_SignupVerificationState) _then;

/// Create a copy of SignupVerificationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? phoneDisplay = null,Object? email = null,Object? isFromSocial = null,Object? phoneCode = null,Object? phoneResendSeconds = null,Object? emailCode = null,Object? emailResendSeconds = null,Object? phoneCodeError = freezed,Object? emailCodeError = freezed,}) {
  return _then(_SignupVerificationState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,phoneDisplay: null == phoneDisplay ? _self.phoneDisplay : phoneDisplay // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,isFromSocial: null == isFromSocial ? _self.isFromSocial : isFromSocial // ignore: cast_nullable_to_non_nullable
as bool,phoneCode: null == phoneCode ? _self.phoneCode : phoneCode // ignore: cast_nullable_to_non_nullable
as String,phoneResendSeconds: null == phoneResendSeconds ? _self.phoneResendSeconds : phoneResendSeconds // ignore: cast_nullable_to_non_nullable
as int,emailCode: null == emailCode ? _self.emailCode : emailCode // ignore: cast_nullable_to_non_nullable
as String,emailResendSeconds: null == emailResendSeconds ? _self.emailResendSeconds : emailResendSeconds // ignore: cast_nullable_to_non_nullable
as int,phoneCodeError: freezed == phoneCodeError ? _self.phoneCodeError : phoneCodeError // ignore: cast_nullable_to_non_nullable
as String?,emailCodeError: freezed == emailCodeError ? _self.emailCodeError : emailCodeError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
