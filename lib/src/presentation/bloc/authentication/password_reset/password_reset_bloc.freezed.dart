// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'password_reset_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PasswordResetEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PasswordResetEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PasswordResetEvent()';
}


}

/// @nodoc
class $PasswordResetEventCopyWith<$Res>  {
$PasswordResetEventCopyWith(PasswordResetEvent _, $Res Function(PasswordResetEvent) __);
}


/// Adds pattern-matching-related methods to [PasswordResetEvent].
extension PasswordResetEventPatterns on PasswordResetEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _EmailChanged value)?  emailChanged,TResult Function( _SendResetCode value)?  sendResetCode,TResult Function( _CodeChanged value)?  codeChanged,TResult Function( _VerifyCode value)?  verifyCode,TResult Function( _ResendCode value)?  resendCode,TResult Function( _Tick value)?  tick,TResult Function( _ChangeEmail value)?  changeEmail,TResult Function( _NewPasswordChanged value)?  newPasswordChanged,TResult Function( _ConfirmPasswordChanged value)?  confirmPasswordChanged,TResult Function( _ToggleNewPasswordVisibility value)?  toggleNewPasswordVisibility,TResult Function( _ToggleConfirmPasswordVisibility value)?  toggleConfirmPasswordVisibility,TResult Function( _UpdatePassword value)?  updatePassword,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _EmailChanged() when emailChanged != null:
return emailChanged(_that);case _SendResetCode() when sendResetCode != null:
return sendResetCode(_that);case _CodeChanged() when codeChanged != null:
return codeChanged(_that);case _VerifyCode() when verifyCode != null:
return verifyCode(_that);case _ResendCode() when resendCode != null:
return resendCode(_that);case _Tick() when tick != null:
return tick(_that);case _ChangeEmail() when changeEmail != null:
return changeEmail(_that);case _NewPasswordChanged() when newPasswordChanged != null:
return newPasswordChanged(_that);case _ConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that);case _ToggleNewPasswordVisibility() when toggleNewPasswordVisibility != null:
return toggleNewPasswordVisibility(_that);case _ToggleConfirmPasswordVisibility() when toggleConfirmPasswordVisibility != null:
return toggleConfirmPasswordVisibility(_that);case _UpdatePassword() when updatePassword != null:
return updatePassword(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _EmailChanged value)  emailChanged,required TResult Function( _SendResetCode value)  sendResetCode,required TResult Function( _CodeChanged value)  codeChanged,required TResult Function( _VerifyCode value)  verifyCode,required TResult Function( _ResendCode value)  resendCode,required TResult Function( _Tick value)  tick,required TResult Function( _ChangeEmail value)  changeEmail,required TResult Function( _NewPasswordChanged value)  newPasswordChanged,required TResult Function( _ConfirmPasswordChanged value)  confirmPasswordChanged,required TResult Function( _ToggleNewPasswordVisibility value)  toggleNewPasswordVisibility,required TResult Function( _ToggleConfirmPasswordVisibility value)  toggleConfirmPasswordVisibility,required TResult Function( _UpdatePassword value)  updatePassword,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _EmailChanged():
return emailChanged(_that);case _SendResetCode():
return sendResetCode(_that);case _CodeChanged():
return codeChanged(_that);case _VerifyCode():
return verifyCode(_that);case _ResendCode():
return resendCode(_that);case _Tick():
return tick(_that);case _ChangeEmail():
return changeEmail(_that);case _NewPasswordChanged():
return newPasswordChanged(_that);case _ConfirmPasswordChanged():
return confirmPasswordChanged(_that);case _ToggleNewPasswordVisibility():
return toggleNewPasswordVisibility(_that);case _ToggleConfirmPasswordVisibility():
return toggleConfirmPasswordVisibility(_that);case _UpdatePassword():
return updatePassword(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _EmailChanged value)?  emailChanged,TResult? Function( _SendResetCode value)?  sendResetCode,TResult? Function( _CodeChanged value)?  codeChanged,TResult? Function( _VerifyCode value)?  verifyCode,TResult? Function( _ResendCode value)?  resendCode,TResult? Function( _Tick value)?  tick,TResult? Function( _ChangeEmail value)?  changeEmail,TResult? Function( _NewPasswordChanged value)?  newPasswordChanged,TResult? Function( _ConfirmPasswordChanged value)?  confirmPasswordChanged,TResult? Function( _ToggleNewPasswordVisibility value)?  toggleNewPasswordVisibility,TResult? Function( _ToggleConfirmPasswordVisibility value)?  toggleConfirmPasswordVisibility,TResult? Function( _UpdatePassword value)?  updatePassword,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _EmailChanged() when emailChanged != null:
return emailChanged(_that);case _SendResetCode() when sendResetCode != null:
return sendResetCode(_that);case _CodeChanged() when codeChanged != null:
return codeChanged(_that);case _VerifyCode() when verifyCode != null:
return verifyCode(_that);case _ResendCode() when resendCode != null:
return resendCode(_that);case _Tick() when tick != null:
return tick(_that);case _ChangeEmail() when changeEmail != null:
return changeEmail(_that);case _NewPasswordChanged() when newPasswordChanged != null:
return newPasswordChanged(_that);case _ConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that);case _ToggleNewPasswordVisibility() when toggleNewPasswordVisibility != null:
return toggleNewPasswordVisibility(_that);case _ToggleConfirmPasswordVisibility() when toggleConfirmPasswordVisibility != null:
return toggleConfirmPasswordVisibility(_that);case _UpdatePassword() when updatePassword != null:
return updatePassword(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String email)?  emailChanged,TResult Function()?  sendResetCode,TResult Function( String code)?  codeChanged,TResult Function()?  verifyCode,TResult Function()?  resendCode,TResult Function()?  tick,TResult Function()?  changeEmail,TResult Function( String value)?  newPasswordChanged,TResult Function( String value)?  confirmPasswordChanged,TResult Function()?  toggleNewPasswordVisibility,TResult Function()?  toggleConfirmPasswordVisibility,TResult Function()?  updatePassword,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _EmailChanged() when emailChanged != null:
return emailChanged(_that.email);case _SendResetCode() when sendResetCode != null:
return sendResetCode();case _CodeChanged() when codeChanged != null:
return codeChanged(_that.code);case _VerifyCode() when verifyCode != null:
return verifyCode();case _ResendCode() when resendCode != null:
return resendCode();case _Tick() when tick != null:
return tick();case _ChangeEmail() when changeEmail != null:
return changeEmail();case _NewPasswordChanged() when newPasswordChanged != null:
return newPasswordChanged(_that.value);case _ConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that.value);case _ToggleNewPasswordVisibility() when toggleNewPasswordVisibility != null:
return toggleNewPasswordVisibility();case _ToggleConfirmPasswordVisibility() when toggleConfirmPasswordVisibility != null:
return toggleConfirmPasswordVisibility();case _UpdatePassword() when updatePassword != null:
return updatePassword();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String email)  emailChanged,required TResult Function()  sendResetCode,required TResult Function( String code)  codeChanged,required TResult Function()  verifyCode,required TResult Function()  resendCode,required TResult Function()  tick,required TResult Function()  changeEmail,required TResult Function( String value)  newPasswordChanged,required TResult Function( String value)  confirmPasswordChanged,required TResult Function()  toggleNewPasswordVisibility,required TResult Function()  toggleConfirmPasswordVisibility,required TResult Function()  updatePassword,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _EmailChanged():
return emailChanged(_that.email);case _SendResetCode():
return sendResetCode();case _CodeChanged():
return codeChanged(_that.code);case _VerifyCode():
return verifyCode();case _ResendCode():
return resendCode();case _Tick():
return tick();case _ChangeEmail():
return changeEmail();case _NewPasswordChanged():
return newPasswordChanged(_that.value);case _ConfirmPasswordChanged():
return confirmPasswordChanged(_that.value);case _ToggleNewPasswordVisibility():
return toggleNewPasswordVisibility();case _ToggleConfirmPasswordVisibility():
return toggleConfirmPasswordVisibility();case _UpdatePassword():
return updatePassword();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String email)?  emailChanged,TResult? Function()?  sendResetCode,TResult? Function( String code)?  codeChanged,TResult? Function()?  verifyCode,TResult? Function()?  resendCode,TResult? Function()?  tick,TResult? Function()?  changeEmail,TResult? Function( String value)?  newPasswordChanged,TResult? Function( String value)?  confirmPasswordChanged,TResult? Function()?  toggleNewPasswordVisibility,TResult? Function()?  toggleConfirmPasswordVisibility,TResult? Function()?  updatePassword,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _EmailChanged() when emailChanged != null:
return emailChanged(_that.email);case _SendResetCode() when sendResetCode != null:
return sendResetCode();case _CodeChanged() when codeChanged != null:
return codeChanged(_that.code);case _VerifyCode() when verifyCode != null:
return verifyCode();case _ResendCode() when resendCode != null:
return resendCode();case _Tick() when tick != null:
return tick();case _ChangeEmail() when changeEmail != null:
return changeEmail();case _NewPasswordChanged() when newPasswordChanged != null:
return newPasswordChanged(_that.value);case _ConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that.value);case _ToggleNewPasswordVisibility() when toggleNewPasswordVisibility != null:
return toggleNewPasswordVisibility();case _ToggleConfirmPasswordVisibility() when toggleConfirmPasswordVisibility != null:
return toggleConfirmPasswordVisibility();case _UpdatePassword() when updatePassword != null:
return updatePassword();case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements PasswordResetEvent {
  const _Initial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PasswordResetEvent.initial()';
}


}




/// @nodoc


class _EmailChanged implements PasswordResetEvent {
  const _EmailChanged(this.email);
  

 final  String email;

/// Create a copy of PasswordResetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailChangedCopyWith<_EmailChanged> get copyWith => __$EmailChangedCopyWithImpl<_EmailChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailChanged&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode {
    return Object.hash(runtimeType,email);
}

@override
String toString() {
    return 'PasswordResetEvent.emailChanged(email: $email)';
}


}

/// @nodoc
abstract mixin class _$EmailChangedCopyWith<$Res> implements $PasswordResetEventCopyWith<$Res> {
  factory _$EmailChangedCopyWith(_EmailChanged value, $Res Function(_EmailChanged) _then) = __$EmailChangedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class __$EmailChangedCopyWithImpl<$Res>
    implements _$EmailChangedCopyWith<$Res> {
  __$EmailChangedCopyWithImpl(this._self, this._then);

  final _EmailChanged _self;
  final $Res Function(_EmailChanged) _then;

/// Create a copy of PasswordResetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_EmailChanged(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SendResetCode implements PasswordResetEvent {
  const _SendResetCode();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendResetCode);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PasswordResetEvent.sendResetCode()';
}


}




/// @nodoc


class _CodeChanged implements PasswordResetEvent {
  const _CodeChanged(this.code);
  

 final  String code;

/// Create a copy of PasswordResetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CodeChangedCopyWith<_CodeChanged> get copyWith => __$CodeChangedCopyWithImpl<_CodeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CodeChanged&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode {
    return Object.hash(runtimeType,code);
}

@override
String toString() {
    return 'PasswordResetEvent.codeChanged(code: $code)';
}


}

/// @nodoc
abstract mixin class _$CodeChangedCopyWith<$Res> implements $PasswordResetEventCopyWith<$Res> {
  factory _$CodeChangedCopyWith(_CodeChanged value, $Res Function(_CodeChanged) _then) = __$CodeChangedCopyWithImpl;
@useResult
$Res call({
 String code
});




}
/// @nodoc
class __$CodeChangedCopyWithImpl<$Res>
    implements _$CodeChangedCopyWith<$Res> {
  __$CodeChangedCopyWithImpl(this._self, this._then);

  final _CodeChanged _self;
  final $Res Function(_CodeChanged) _then;

/// Create a copy of PasswordResetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
  return _then(_CodeChanged(
null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _VerifyCode implements PasswordResetEvent {
  const _VerifyCode();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _VerifyCode);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PasswordResetEvent.verifyCode()';
}


}




/// @nodoc


class _ResendCode implements PasswordResetEvent {
  const _ResendCode();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResendCode);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PasswordResetEvent.resendCode()';
}


}




/// @nodoc


class _Tick implements PasswordResetEvent {
  const _Tick();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tick);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PasswordResetEvent.tick()';
}


}




/// @nodoc


class _ChangeEmail implements PasswordResetEvent {
  const _ChangeEmail();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChangeEmail);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PasswordResetEvent.changeEmail()';
}


}




/// @nodoc


class _NewPasswordChanged implements PasswordResetEvent {
  const _NewPasswordChanged(this.value);
  

 final  String value;

/// Create a copy of PasswordResetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewPasswordChangedCopyWith<_NewPasswordChanged> get copyWith => __$NewPasswordChangedCopyWithImpl<_NewPasswordChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewPasswordChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode {
    return Object.hash(runtimeType,value);
}

@override
String toString() {
    return 'PasswordResetEvent.newPasswordChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$NewPasswordChangedCopyWith<$Res> implements $PasswordResetEventCopyWith<$Res> {
  factory _$NewPasswordChangedCopyWith(_NewPasswordChanged value, $Res Function(_NewPasswordChanged) _then) = __$NewPasswordChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$NewPasswordChangedCopyWithImpl<$Res>
    implements _$NewPasswordChangedCopyWith<$Res> {
  __$NewPasswordChangedCopyWithImpl(this._self, this._then);

  final _NewPasswordChanged _self;
  final $Res Function(_NewPasswordChanged) _then;

/// Create a copy of PasswordResetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_NewPasswordChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ConfirmPasswordChanged implements PasswordResetEvent {
  const _ConfirmPasswordChanged(this.value);
  

 final  String value;

/// Create a copy of PasswordResetEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfirmPasswordChangedCopyWith<_ConfirmPasswordChanged> get copyWith => __$ConfirmPasswordChangedCopyWithImpl<_ConfirmPasswordChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmPasswordChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode {
    return Object.hash(runtimeType,value);
}

@override
String toString() {
    return 'PasswordResetEvent.confirmPasswordChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$ConfirmPasswordChangedCopyWith<$Res> implements $PasswordResetEventCopyWith<$Res> {
  factory _$ConfirmPasswordChangedCopyWith(_ConfirmPasswordChanged value, $Res Function(_ConfirmPasswordChanged) _then) = __$ConfirmPasswordChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$ConfirmPasswordChangedCopyWithImpl<$Res>
    implements _$ConfirmPasswordChangedCopyWith<$Res> {
  __$ConfirmPasswordChangedCopyWithImpl(this._self, this._then);

  final _ConfirmPasswordChanged _self;
  final $Res Function(_ConfirmPasswordChanged) _then;

/// Create a copy of PasswordResetEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_ConfirmPasswordChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ToggleNewPasswordVisibility implements PasswordResetEvent {
  const _ToggleNewPasswordVisibility();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleNewPasswordVisibility);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PasswordResetEvent.toggleNewPasswordVisibility()';
}


}




/// @nodoc


class _ToggleConfirmPasswordVisibility implements PasswordResetEvent {
  const _ToggleConfirmPasswordVisibility();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleConfirmPasswordVisibility);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PasswordResetEvent.toggleConfirmPasswordVisibility()';
}


}




/// @nodoc


class _UpdatePassword implements PasswordResetEvent {
  const _UpdatePassword();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdatePassword);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PasswordResetEvent.updatePassword()';
}


}




/// @nodoc
mixin _$PasswordResetState {

 RequestState get state; String get message; String get email; String get code; int get resendSeconds; String get newPassword; String get confirmPassword; bool get obscureNewPassword; bool get obscureConfirmPassword; String? get emailError; String? get codeError; String? get newPasswordError; String? get confirmPasswordError;
/// Create a copy of PasswordResetState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PasswordResetStateCopyWith<PasswordResetState> get copyWith => _$PasswordResetStateCopyWithImpl<PasswordResetState>(this as PasswordResetState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PasswordResetState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PasswordResetState&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.code, _this.code) || other.code == _this.code)&&(identical(other.resendSeconds, _this.resendSeconds) || other.resendSeconds == _this.resendSeconds)&&(identical(other.newPassword, _this.newPassword) || other.newPassword == _this.newPassword)&&(identical(other.confirmPassword, _this.confirmPassword) || other.confirmPassword == _this.confirmPassword)&&(identical(other.obscureNewPassword, _this.obscureNewPassword) || other.obscureNewPassword == _this.obscureNewPassword)&&(identical(other.obscureConfirmPassword, _this.obscureConfirmPassword) || other.obscureConfirmPassword == _this.obscureConfirmPassword)&&(identical(other.emailError, _this.emailError) || other.emailError == _this.emailError)&&(identical(other.codeError, _this.codeError) || other.codeError == _this.codeError)&&(identical(other.newPasswordError, _this.newPasswordError) || other.newPasswordError == _this.newPasswordError)&&(identical(other.confirmPasswordError, _this.confirmPasswordError) || other.confirmPasswordError == _this.confirmPasswordError));
}


@override
int get hashCode {
  final _this = this as PasswordResetState;
  return Object.hash(runtimeType,_this.state,_this.message,_this.email,_this.code,_this.resendSeconds,_this.newPassword,_this.confirmPassword,_this.obscureNewPassword,_this.obscureConfirmPassword,_this.emailError,_this.codeError,_this.newPasswordError,_this.confirmPasswordError);
}

@override
String toString() {
  final _this = this as PasswordResetState;
  return 'PasswordResetState(state: ${_this.state}, message: ${_this.message}, email: ${_this.email}, code: ${_this.code}, resendSeconds: ${_this.resendSeconds}, newPassword: ${_this.newPassword}, confirmPassword: ${_this.confirmPassword}, obscureNewPassword: ${_this.obscureNewPassword}, obscureConfirmPassword: ${_this.obscureConfirmPassword}, emailError: ${_this.emailError}, codeError: ${_this.codeError}, newPasswordError: ${_this.newPasswordError}, confirmPasswordError: ${_this.confirmPasswordError})';
}


}

/// @nodoc
abstract mixin class $PasswordResetStateCopyWith<$Res>  {
  factory $PasswordResetStateCopyWith(PasswordResetState value, $Res Function(PasswordResetState) _then) = _$PasswordResetStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, String message, String email, String code, int resendSeconds, String newPassword, String confirmPassword, bool obscureNewPassword, bool obscureConfirmPassword, String? emailError, String? codeError, String? newPasswordError, String? confirmPasswordError
});




}
/// @nodoc
class _$PasswordResetStateCopyWithImpl<$Res>
    implements $PasswordResetStateCopyWith<$Res> {
  _$PasswordResetStateCopyWithImpl(this._self, this._then);

  final PasswordResetState _self;
  final $Res Function(PasswordResetState) _then;

/// Create a copy of PasswordResetState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? message = null,Object? email = null,Object? code = null,Object? resendSeconds = null,Object? newPassword = null,Object? confirmPassword = null,Object? obscureNewPassword = null,Object? obscureConfirmPassword = null,Object? emailError = freezed,Object? codeError = freezed,Object? newPasswordError = freezed,Object? confirmPasswordError = freezed,}) {
  return _then(PasswordResetState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,resendSeconds: null == resendSeconds ? _self.resendSeconds : resendSeconds // ignore: cast_nullable_to_non_nullable
as int,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,obscureNewPassword: null == obscureNewPassword ? _self.obscureNewPassword : obscureNewPassword // ignore: cast_nullable_to_non_nullable
as bool,obscureConfirmPassword: null == obscureConfirmPassword ? _self.obscureConfirmPassword : obscureConfirmPassword // ignore: cast_nullable_to_non_nullable
as bool,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as String?,codeError: freezed == codeError ? _self.codeError : codeError // ignore: cast_nullable_to_non_nullable
as String?,newPasswordError: freezed == newPasswordError ? _self.newPasswordError : newPasswordError // ignore: cast_nullable_to_non_nullable
as String?,confirmPasswordError: freezed == confirmPasswordError ? _self.confirmPasswordError : confirmPasswordError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PasswordResetState].
extension PasswordResetStatePatterns on PasswordResetState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PasswordResetState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PasswordResetState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PasswordResetState value)  $default,){
final _that = this;
switch (_that) {
case _PasswordResetState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PasswordResetState value)?  $default,){
final _that = this;
switch (_that) {
case _PasswordResetState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  String message,  String email,  String code,  int resendSeconds,  String newPassword,  String confirmPassword,  bool obscureNewPassword,  bool obscureConfirmPassword,  String? emailError,  String? codeError,  String? newPasswordError,  String? confirmPasswordError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PasswordResetState() when $default != null:
return $default(_that.state,_that.message,_that.email,_that.code,_that.resendSeconds,_that.newPassword,_that.confirmPassword,_that.obscureNewPassword,_that.obscureConfirmPassword,_that.emailError,_that.codeError,_that.newPasswordError,_that.confirmPasswordError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  String message,  String email,  String code,  int resendSeconds,  String newPassword,  String confirmPassword,  bool obscureNewPassword,  bool obscureConfirmPassword,  String? emailError,  String? codeError,  String? newPasswordError,  String? confirmPasswordError)  $default,) {final _that = this;
switch (_that) {
case _PasswordResetState():
return $default(_that.state,_that.message,_that.email,_that.code,_that.resendSeconds,_that.newPassword,_that.confirmPassword,_that.obscureNewPassword,_that.obscureConfirmPassword,_that.emailError,_that.codeError,_that.newPasswordError,_that.confirmPasswordError);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  String message,  String email,  String code,  int resendSeconds,  String newPassword,  String confirmPassword,  bool obscureNewPassword,  bool obscureConfirmPassword,  String? emailError,  String? codeError,  String? newPasswordError,  String? confirmPasswordError)?  $default,) {final _that = this;
switch (_that) {
case _PasswordResetState() when $default != null:
return $default(_that.state,_that.message,_that.email,_that.code,_that.resendSeconds,_that.newPassword,_that.confirmPassword,_that.obscureNewPassword,_that.obscureConfirmPassword,_that.emailError,_that.codeError,_that.newPasswordError,_that.confirmPasswordError);case _:
  return null;

}
}

}

/// @nodoc


class _PasswordResetState implements PasswordResetState {
  const _PasswordResetState({required this.state, required this.message, required this.email, required this.code, required this.resendSeconds, required this.newPassword, required this.confirmPassword, required this.obscureNewPassword, required this.obscureConfirmPassword, this.emailError, this.codeError, this.newPasswordError, this.confirmPasswordError});
  

@override final  RequestState state;
@override final  String message;
@override final  String email;
@override final  String code;
@override final  int resendSeconds;
@override final  String newPassword;
@override final  String confirmPassword;
@override final  bool obscureNewPassword;
@override final  bool obscureConfirmPassword;
@override final  String? emailError;
@override final  String? codeError;
@override final  String? newPasswordError;
@override final  String? confirmPasswordError;

/// Create a copy of PasswordResetState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PasswordResetStateCopyWith<_PasswordResetState> get copyWith => __$PasswordResetStateCopyWithImpl<_PasswordResetState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordResetState&&(identical(other.state, state) || other.state == state)&&(identical(other.message, message) || other.message == message)&&(identical(other.email, email) || other.email == email)&&(identical(other.code, code) || other.code == code)&&(identical(other.resendSeconds, resendSeconds) || other.resendSeconds == resendSeconds)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.obscureNewPassword, obscureNewPassword) || other.obscureNewPassword == obscureNewPassword)&&(identical(other.obscureConfirmPassword, obscureConfirmPassword) || other.obscureConfirmPassword == obscureConfirmPassword)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.codeError, codeError) || other.codeError == codeError)&&(identical(other.newPasswordError, newPasswordError) || other.newPasswordError == newPasswordError)&&(identical(other.confirmPasswordError, confirmPasswordError) || other.confirmPasswordError == confirmPasswordError));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state,message,email,code,resendSeconds,newPassword,confirmPassword,obscureNewPassword,obscureConfirmPassword,emailError,codeError,newPasswordError,confirmPasswordError);
}

@override
String toString() {
    return 'PasswordResetState(state: $state, message: $message, email: $email, code: $code, resendSeconds: $resendSeconds, newPassword: $newPassword, confirmPassword: $confirmPassword, obscureNewPassword: $obscureNewPassword, obscureConfirmPassword: $obscureConfirmPassword, emailError: $emailError, codeError: $codeError, newPasswordError: $newPasswordError, confirmPasswordError: $confirmPasswordError)';
}


}

/// @nodoc
abstract mixin class _$PasswordResetStateCopyWith<$Res> implements $PasswordResetStateCopyWith<$Res> {
  factory _$PasswordResetStateCopyWith(_PasswordResetState value, $Res Function(_PasswordResetState) _then) = __$PasswordResetStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, String message, String email, String code, int resendSeconds, String newPassword, String confirmPassword, bool obscureNewPassword, bool obscureConfirmPassword, String? emailError, String? codeError, String? newPasswordError, String? confirmPasswordError
});




}
/// @nodoc
class __$PasswordResetStateCopyWithImpl<$Res>
    implements _$PasswordResetStateCopyWith<$Res> {
  __$PasswordResetStateCopyWithImpl(this._self, this._then);

  final _PasswordResetState _self;
  final $Res Function(_PasswordResetState) _then;

/// Create a copy of PasswordResetState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? message = null,Object? email = null,Object? code = null,Object? resendSeconds = null,Object? newPassword = null,Object? confirmPassword = null,Object? obscureNewPassword = null,Object? obscureConfirmPassword = null,Object? emailError = freezed,Object? codeError = freezed,Object? newPasswordError = freezed,Object? confirmPasswordError = freezed,}) {
  return _then(_PasswordResetState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,resendSeconds: null == resendSeconds ? _self.resendSeconds : resendSeconds // ignore: cast_nullable_to_non_nullable
as int,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,obscureNewPassword: null == obscureNewPassword ? _self.obscureNewPassword : obscureNewPassword // ignore: cast_nullable_to_non_nullable
as bool,obscureConfirmPassword: null == obscureConfirmPassword ? _self.obscureConfirmPassword : obscureConfirmPassword // ignore: cast_nullable_to_non_nullable
as bool,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as String?,codeError: freezed == codeError ? _self.codeError : codeError // ignore: cast_nullable_to_non_nullable
as String?,newPasswordError: freezed == newPasswordError ? _self.newPasswordError : newPasswordError // ignore: cast_nullable_to_non_nullable
as String?,confirmPasswordError: freezed == confirmPasswordError ? _self.confirmPasswordError : confirmPasswordError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
