// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SocialAuthEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialAuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SocialAuthEvent()';
}


}

/// @nodoc
class $SocialAuthEventCopyWith<$Res>  {
$SocialAuthEventCopyWith(SocialAuthEvent _, $Res Function(SocialAuthEvent) __);
}


/// Adds pattern-matching-related methods to [SocialAuthEvent].
extension SocialAuthEventPatterns on SocialAuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _SignIn value)?  signIn,TResult Function( _PasswordChanged value)?  passwordChanged,TResult Function( _Link value)?  link,TResult Function( _PhoneChanged value)?  phoneChanged,TResult Function( _CountryChanged value)?  countryChanged,TResult Function( _NameChanged value)?  nameChanged,TResult Function( _SendCode value)?  sendCode,TResult Function( _OtpChanged value)?  otpChanged,TResult Function( _Verify value)?  verify,TResult Function( _Resend value)?  resend,TResult Function( _Tick value)?  tick,TResult Function( _Reset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignIn() when signIn != null:
return signIn(_that);case _PasswordChanged() when passwordChanged != null:
return passwordChanged(_that);case _Link() when link != null:
return link(_that);case _PhoneChanged() when phoneChanged != null:
return phoneChanged(_that);case _CountryChanged() when countryChanged != null:
return countryChanged(_that);case _NameChanged() when nameChanged != null:
return nameChanged(_that);case _SendCode() when sendCode != null:
return sendCode(_that);case _OtpChanged() when otpChanged != null:
return otpChanged(_that);case _Verify() when verify != null:
return verify(_that);case _Resend() when resend != null:
return resend(_that);case _Tick() when tick != null:
return tick(_that);case _Reset() when reset != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _SignIn value)  signIn,required TResult Function( _PasswordChanged value)  passwordChanged,required TResult Function( _Link value)  link,required TResult Function( _PhoneChanged value)  phoneChanged,required TResult Function( _CountryChanged value)  countryChanged,required TResult Function( _NameChanged value)  nameChanged,required TResult Function( _SendCode value)  sendCode,required TResult Function( _OtpChanged value)  otpChanged,required TResult Function( _Verify value)  verify,required TResult Function( _Resend value)  resend,required TResult Function( _Tick value)  tick,required TResult Function( _Reset value)  reset,}){
final _that = this;
switch (_that) {
case _SignIn():
return signIn(_that);case _PasswordChanged():
return passwordChanged(_that);case _Link():
return link(_that);case _PhoneChanged():
return phoneChanged(_that);case _CountryChanged():
return countryChanged(_that);case _NameChanged():
return nameChanged(_that);case _SendCode():
return sendCode(_that);case _OtpChanged():
return otpChanged(_that);case _Verify():
return verify(_that);case _Resend():
return resend(_that);case _Tick():
return tick(_that);case _Reset():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _SignIn value)?  signIn,TResult? Function( _PasswordChanged value)?  passwordChanged,TResult? Function( _Link value)?  link,TResult? Function( _PhoneChanged value)?  phoneChanged,TResult? Function( _CountryChanged value)?  countryChanged,TResult? Function( _NameChanged value)?  nameChanged,TResult? Function( _SendCode value)?  sendCode,TResult? Function( _OtpChanged value)?  otpChanged,TResult? Function( _Verify value)?  verify,TResult? Function( _Resend value)?  resend,TResult? Function( _Tick value)?  tick,TResult? Function( _Reset value)?  reset,}){
final _that = this;
switch (_that) {
case _SignIn() when signIn != null:
return signIn(_that);case _PasswordChanged() when passwordChanged != null:
return passwordChanged(_that);case _Link() when link != null:
return link(_that);case _PhoneChanged() when phoneChanged != null:
return phoneChanged(_that);case _CountryChanged() when countryChanged != null:
return countryChanged(_that);case _NameChanged() when nameChanged != null:
return nameChanged(_that);case _SendCode() when sendCode != null:
return sendCode(_that);case _OtpChanged() when otpChanged != null:
return otpChanged(_that);case _Verify() when verify != null:
return verify(_that);case _Resend() when resend != null:
return resend(_that);case _Tick() when tick != null:
return tick(_that);case _Reset() when reset != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( SocialProvider provider)?  signIn,TResult Function( String value)?  passwordChanged,TResult Function()?  link,TResult Function( String value)?  phoneChanged,TResult Function( String dialCode)?  countryChanged,TResult Function( String value)?  nameChanged,TResult Function()?  sendCode,TResult Function( String value)?  otpChanged,TResult Function()?  verify,TResult Function()?  resend,TResult Function()?  tick,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignIn() when signIn != null:
return signIn(_that.provider);case _PasswordChanged() when passwordChanged != null:
return passwordChanged(_that.value);case _Link() when link != null:
return link();case _PhoneChanged() when phoneChanged != null:
return phoneChanged(_that.value);case _CountryChanged() when countryChanged != null:
return countryChanged(_that.dialCode);case _NameChanged() when nameChanged != null:
return nameChanged(_that.value);case _SendCode() when sendCode != null:
return sendCode();case _OtpChanged() when otpChanged != null:
return otpChanged(_that.value);case _Verify() when verify != null:
return verify();case _Resend() when resend != null:
return resend();case _Tick() when tick != null:
return tick();case _Reset() when reset != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( SocialProvider provider)  signIn,required TResult Function( String value)  passwordChanged,required TResult Function()  link,required TResult Function( String value)  phoneChanged,required TResult Function( String dialCode)  countryChanged,required TResult Function( String value)  nameChanged,required TResult Function()  sendCode,required TResult Function( String value)  otpChanged,required TResult Function()  verify,required TResult Function()  resend,required TResult Function()  tick,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case _SignIn():
return signIn(_that.provider);case _PasswordChanged():
return passwordChanged(_that.value);case _Link():
return link();case _PhoneChanged():
return phoneChanged(_that.value);case _CountryChanged():
return countryChanged(_that.dialCode);case _NameChanged():
return nameChanged(_that.value);case _SendCode():
return sendCode();case _OtpChanged():
return otpChanged(_that.value);case _Verify():
return verify();case _Resend():
return resend();case _Tick():
return tick();case _Reset():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( SocialProvider provider)?  signIn,TResult? Function( String value)?  passwordChanged,TResult? Function()?  link,TResult? Function( String value)?  phoneChanged,TResult? Function( String dialCode)?  countryChanged,TResult? Function( String value)?  nameChanged,TResult? Function()?  sendCode,TResult? Function( String value)?  otpChanged,TResult? Function()?  verify,TResult? Function()?  resend,TResult? Function()?  tick,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case _SignIn() when signIn != null:
return signIn(_that.provider);case _PasswordChanged() when passwordChanged != null:
return passwordChanged(_that.value);case _Link() when link != null:
return link();case _PhoneChanged() when phoneChanged != null:
return phoneChanged(_that.value);case _CountryChanged() when countryChanged != null:
return countryChanged(_that.dialCode);case _NameChanged() when nameChanged != null:
return nameChanged(_that.value);case _SendCode() when sendCode != null:
return sendCode();case _OtpChanged() when otpChanged != null:
return otpChanged(_that.value);case _Verify() when verify != null:
return verify();case _Resend() when resend != null:
return resend();case _Tick() when tick != null:
return tick();case _Reset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class _SignIn implements SocialAuthEvent {
  const _SignIn(this.provider);
  

 final  SocialProvider provider;

/// Create a copy of SocialAuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInCopyWith<_SignIn> get copyWith => __$SignInCopyWithImpl<_SignIn>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignIn&&(identical(other.provider, provider) || other.provider == provider));
}


@override
int get hashCode {
    return Object.hash(runtimeType,provider);
}

@override
String toString() {
    return 'SocialAuthEvent.signIn(provider: $provider)';
}


}

/// @nodoc
abstract mixin class _$SignInCopyWith<$Res> implements $SocialAuthEventCopyWith<$Res> {
  factory _$SignInCopyWith(_SignIn value, $Res Function(_SignIn) _then) = __$SignInCopyWithImpl;
@useResult
$Res call({
 SocialProvider provider
});




}
/// @nodoc
class __$SignInCopyWithImpl<$Res>
    implements _$SignInCopyWith<$Res> {
  __$SignInCopyWithImpl(this._self, this._then);

  final _SignIn _self;
  final $Res Function(_SignIn) _then;

/// Create a copy of SocialAuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? provider = null,}) {
  return _then(_SignIn(
null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as SocialProvider,
  ));
}


}

/// @nodoc


class _PasswordChanged implements SocialAuthEvent {
  const _PasswordChanged(this.value);
  

 final  String value;

/// Create a copy of SocialAuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PasswordChangedCopyWith<_PasswordChanged> get copyWith => __$PasswordChangedCopyWithImpl<_PasswordChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode {
    return Object.hash(runtimeType,value);
}

@override
String toString() {
    return 'SocialAuthEvent.passwordChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$PasswordChangedCopyWith<$Res> implements $SocialAuthEventCopyWith<$Res> {
  factory _$PasswordChangedCopyWith(_PasswordChanged value, $Res Function(_PasswordChanged) _then) = __$PasswordChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$PasswordChangedCopyWithImpl<$Res>
    implements _$PasswordChangedCopyWith<$Res> {
  __$PasswordChangedCopyWithImpl(this._self, this._then);

  final _PasswordChanged _self;
  final $Res Function(_PasswordChanged) _then;

/// Create a copy of SocialAuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_PasswordChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Link implements SocialAuthEvent {
  const _Link();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Link);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SocialAuthEvent.link()';
}


}




/// @nodoc


class _PhoneChanged implements SocialAuthEvent {
  const _PhoneChanged(this.value);
  

 final  String value;

/// Create a copy of SocialAuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneChangedCopyWith<_PhoneChanged> get copyWith => __$PhoneChangedCopyWithImpl<_PhoneChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode {
    return Object.hash(runtimeType,value);
}

@override
String toString() {
    return 'SocialAuthEvent.phoneChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$PhoneChangedCopyWith<$Res> implements $SocialAuthEventCopyWith<$Res> {
  factory _$PhoneChangedCopyWith(_PhoneChanged value, $Res Function(_PhoneChanged) _then) = __$PhoneChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$PhoneChangedCopyWithImpl<$Res>
    implements _$PhoneChangedCopyWith<$Res> {
  __$PhoneChangedCopyWithImpl(this._self, this._then);

  final _PhoneChanged _self;
  final $Res Function(_PhoneChanged) _then;

/// Create a copy of SocialAuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_PhoneChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CountryChanged implements SocialAuthEvent {
  const _CountryChanged(this.dialCode);
  

 final  String dialCode;

/// Create a copy of SocialAuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountryChangedCopyWith<_CountryChanged> get copyWith => __$CountryChangedCopyWithImpl<_CountryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CountryChanged&&(identical(other.dialCode, dialCode) || other.dialCode == dialCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,dialCode);
}

@override
String toString() {
    return 'SocialAuthEvent.countryChanged(dialCode: $dialCode)';
}


}

/// @nodoc
abstract mixin class _$CountryChangedCopyWith<$Res> implements $SocialAuthEventCopyWith<$Res> {
  factory _$CountryChangedCopyWith(_CountryChanged value, $Res Function(_CountryChanged) _then) = __$CountryChangedCopyWithImpl;
@useResult
$Res call({
 String dialCode
});




}
/// @nodoc
class __$CountryChangedCopyWithImpl<$Res>
    implements _$CountryChangedCopyWith<$Res> {
  __$CountryChangedCopyWithImpl(this._self, this._then);

  final _CountryChanged _self;
  final $Res Function(_CountryChanged) _then;

/// Create a copy of SocialAuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? dialCode = null,}) {
  return _then(_CountryChanged(
null == dialCode ? _self.dialCode : dialCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _NameChanged implements SocialAuthEvent {
  const _NameChanged(this.value);
  

 final  String value;

/// Create a copy of SocialAuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NameChangedCopyWith<_NameChanged> get copyWith => __$NameChangedCopyWithImpl<_NameChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NameChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode {
    return Object.hash(runtimeType,value);
}

@override
String toString() {
    return 'SocialAuthEvent.nameChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$NameChangedCopyWith<$Res> implements $SocialAuthEventCopyWith<$Res> {
  factory _$NameChangedCopyWith(_NameChanged value, $Res Function(_NameChanged) _then) = __$NameChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$NameChangedCopyWithImpl<$Res>
    implements _$NameChangedCopyWith<$Res> {
  __$NameChangedCopyWithImpl(this._self, this._then);

  final _NameChanged _self;
  final $Res Function(_NameChanged) _then;

/// Create a copy of SocialAuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_NameChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _SendCode implements SocialAuthEvent {
  const _SendCode();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SendCode);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SocialAuthEvent.sendCode()';
}


}




/// @nodoc


class _OtpChanged implements SocialAuthEvent {
  const _OtpChanged(this.value);
  

 final  String value;

/// Create a copy of SocialAuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpChangedCopyWith<_OtpChanged> get copyWith => __$OtpChangedCopyWithImpl<_OtpChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpChanged&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode {
    return Object.hash(runtimeType,value);
}

@override
String toString() {
    return 'SocialAuthEvent.otpChanged(value: $value)';
}


}

/// @nodoc
abstract mixin class _$OtpChangedCopyWith<$Res> implements $SocialAuthEventCopyWith<$Res> {
  factory _$OtpChangedCopyWith(_OtpChanged value, $Res Function(_OtpChanged) _then) = __$OtpChangedCopyWithImpl;
@useResult
$Res call({
 String value
});




}
/// @nodoc
class __$OtpChangedCopyWithImpl<$Res>
    implements _$OtpChangedCopyWith<$Res> {
  __$OtpChangedCopyWithImpl(this._self, this._then);

  final _OtpChanged _self;
  final $Res Function(_OtpChanged) _then;

/// Create a copy of SocialAuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? value = null,}) {
  return _then(_OtpChanged(
null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Verify implements SocialAuthEvent {
  const _Verify();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Verify);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SocialAuthEvent.verify()';
}


}




/// @nodoc


class _Resend implements SocialAuthEvent {
  const _Resend();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Resend);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SocialAuthEvent.resend()';
}


}




/// @nodoc


class _Tick implements SocialAuthEvent {
  const _Tick();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Tick);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SocialAuthEvent.tick()';
}


}




/// @nodoc


class _Reset implements SocialAuthEvent {
  const _Reset();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SocialAuthEvent.reset()';
}


}




/// @nodoc
mixin _$SocialAuthState {

 SocialStep get step; RequestState get state;/// Shown as a snackbar. Left empty when the error is drawn under a field.
 String get message; SocialProvider? get provider;/// From the provider; shown on the phone step.
 String? get email; String? get name; String? get signupToken; String? get linkToken; String? get otpToken; String get password; String? get passwordError; String get countryCode; String get phone; String? get phoneError;/// Apple gives the name once and Google may omit it: ask when it is
/// missing, or when the server answers `NAME_REQUIRED`.
 String get typedName; bool get nameRequired; String? get nameError;/// The number the code went to, as the server normalised it.
 String get sentTo; String get otp; String? get otpError; int get resendSeconds;
/// Create a copy of SocialAuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialAuthStateCopyWith<SocialAuthState> get copyWith => _$SocialAuthStateCopyWithImpl<SocialAuthState>(this as SocialAuthState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SocialAuthState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialAuthState&&(identical(other.step, _this.step) || other.step == _this.step)&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.provider, _this.provider) || other.provider == _this.provider)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.signupToken, _this.signupToken) || other.signupToken == _this.signupToken)&&(identical(other.linkToken, _this.linkToken) || other.linkToken == _this.linkToken)&&(identical(other.otpToken, _this.otpToken) || other.otpToken == _this.otpToken)&&(identical(other.password, _this.password) || other.password == _this.password)&&(identical(other.passwordError, _this.passwordError) || other.passwordError == _this.passwordError)&&(identical(other.countryCode, _this.countryCode) || other.countryCode == _this.countryCode)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.phoneError, _this.phoneError) || other.phoneError == _this.phoneError)&&(identical(other.typedName, _this.typedName) || other.typedName == _this.typedName)&&(identical(other.nameRequired, _this.nameRequired) || other.nameRequired == _this.nameRequired)&&(identical(other.nameError, _this.nameError) || other.nameError == _this.nameError)&&(identical(other.sentTo, _this.sentTo) || other.sentTo == _this.sentTo)&&(identical(other.otp, _this.otp) || other.otp == _this.otp)&&(identical(other.otpError, _this.otpError) || other.otpError == _this.otpError)&&(identical(other.resendSeconds, _this.resendSeconds) || other.resendSeconds == _this.resendSeconds));
}


@override
int get hashCode {
  final _this = this as SocialAuthState;
  return Object.hashAll([runtimeType,_this.step,_this.state,_this.message,_this.provider,_this.email,_this.name,_this.signupToken,_this.linkToken,_this.otpToken,_this.password,_this.passwordError,_this.countryCode,_this.phone,_this.phoneError,_this.typedName,_this.nameRequired,_this.nameError,_this.sentTo,_this.otp,_this.otpError,_this.resendSeconds]);
}

@override
String toString() {
  final _this = this as SocialAuthState;
  return 'SocialAuthState(step: ${_this.step}, state: ${_this.state}, message: ${_this.message}, provider: ${_this.provider}, email: ${_this.email}, name: ${_this.name}, signupToken: ${_this.signupToken}, linkToken: ${_this.linkToken}, otpToken: ${_this.otpToken}, password: ${_this.password}, passwordError: ${_this.passwordError}, countryCode: ${_this.countryCode}, phone: ${_this.phone}, phoneError: ${_this.phoneError}, typedName: ${_this.typedName}, nameRequired: ${_this.nameRequired}, nameError: ${_this.nameError}, sentTo: ${_this.sentTo}, otp: ${_this.otp}, otpError: ${_this.otpError}, resendSeconds: ${_this.resendSeconds})';
}


}

/// @nodoc
abstract mixin class $SocialAuthStateCopyWith<$Res>  {
  factory $SocialAuthStateCopyWith(SocialAuthState value, $Res Function(SocialAuthState) _then) = _$SocialAuthStateCopyWithImpl;
@useResult
$Res call({
 SocialStep step, RequestState state, String message, SocialProvider? provider, String? email, String? name, String? signupToken, String? linkToken, String? otpToken, String password, String? passwordError, String countryCode, String phone, String? phoneError, String typedName, bool nameRequired, String? nameError, String sentTo, String otp, String? otpError, int resendSeconds
});




}
/// @nodoc
class _$SocialAuthStateCopyWithImpl<$Res>
    implements $SocialAuthStateCopyWith<$Res> {
  _$SocialAuthStateCopyWithImpl(this._self, this._then);

  final SocialAuthState _self;
  final $Res Function(SocialAuthState) _then;

/// Create a copy of SocialAuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? state = null,Object? message = null,Object? provider = freezed,Object? email = freezed,Object? name = freezed,Object? signupToken = freezed,Object? linkToken = freezed,Object? otpToken = freezed,Object? password = null,Object? passwordError = freezed,Object? countryCode = null,Object? phone = null,Object? phoneError = freezed,Object? typedName = null,Object? nameRequired = null,Object? nameError = freezed,Object? sentTo = null,Object? otp = null,Object? otpError = freezed,Object? resendSeconds = null,}) {
  return _then(SocialAuthState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as SocialStep,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as SocialProvider?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,signupToken: freezed == signupToken ? _self.signupToken : signupToken // ignore: cast_nullable_to_non_nullable
as String?,linkToken: freezed == linkToken ? _self.linkToken : linkToken // ignore: cast_nullable_to_non_nullable
as String?,otpToken: freezed == otpToken ? _self.otpToken : otpToken // ignore: cast_nullable_to_non_nullable
as String?,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,phoneError: freezed == phoneError ? _self.phoneError : phoneError // ignore: cast_nullable_to_non_nullable
as String?,typedName: null == typedName ? _self.typedName : typedName // ignore: cast_nullable_to_non_nullable
as String,nameRequired: null == nameRequired ? _self.nameRequired : nameRequired // ignore: cast_nullable_to_non_nullable
as bool,nameError: freezed == nameError ? _self.nameError : nameError // ignore: cast_nullable_to_non_nullable
as String?,sentTo: null == sentTo ? _self.sentTo : sentTo // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,otpError: freezed == otpError ? _self.otpError : otpError // ignore: cast_nullable_to_non_nullable
as String?,resendSeconds: null == resendSeconds ? _self.resendSeconds : resendSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialAuthState].
extension SocialAuthStatePatterns on SocialAuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialAuthState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialAuthState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialAuthState value)  $default,){
final _that = this;
switch (_that) {
case _SocialAuthState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialAuthState value)?  $default,){
final _that = this;
switch (_that) {
case _SocialAuthState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SocialStep step,  RequestState state,  String message,  SocialProvider? provider,  String? email,  String? name,  String? signupToken,  String? linkToken,  String? otpToken,  String password,  String? passwordError,  String countryCode,  String phone,  String? phoneError,  String typedName,  bool nameRequired,  String? nameError,  String sentTo,  String otp,  String? otpError,  int resendSeconds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialAuthState() when $default != null:
return $default(_that.step,_that.state,_that.message,_that.provider,_that.email,_that.name,_that.signupToken,_that.linkToken,_that.otpToken,_that.password,_that.passwordError,_that.countryCode,_that.phone,_that.phoneError,_that.typedName,_that.nameRequired,_that.nameError,_that.sentTo,_that.otp,_that.otpError,_that.resendSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SocialStep step,  RequestState state,  String message,  SocialProvider? provider,  String? email,  String? name,  String? signupToken,  String? linkToken,  String? otpToken,  String password,  String? passwordError,  String countryCode,  String phone,  String? phoneError,  String typedName,  bool nameRequired,  String? nameError,  String sentTo,  String otp,  String? otpError,  int resendSeconds)  $default,) {final _that = this;
switch (_that) {
case _SocialAuthState():
return $default(_that.step,_that.state,_that.message,_that.provider,_that.email,_that.name,_that.signupToken,_that.linkToken,_that.otpToken,_that.password,_that.passwordError,_that.countryCode,_that.phone,_that.phoneError,_that.typedName,_that.nameRequired,_that.nameError,_that.sentTo,_that.otp,_that.otpError,_that.resendSeconds);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SocialStep step,  RequestState state,  String message,  SocialProvider? provider,  String? email,  String? name,  String? signupToken,  String? linkToken,  String? otpToken,  String password,  String? passwordError,  String countryCode,  String phone,  String? phoneError,  String typedName,  bool nameRequired,  String? nameError,  String sentTo,  String otp,  String? otpError,  int resendSeconds)?  $default,) {final _that = this;
switch (_that) {
case _SocialAuthState() when $default != null:
return $default(_that.step,_that.state,_that.message,_that.provider,_that.email,_that.name,_that.signupToken,_that.linkToken,_that.otpToken,_that.password,_that.passwordError,_that.countryCode,_that.phone,_that.phoneError,_that.typedName,_that.nameRequired,_that.nameError,_that.sentTo,_that.otp,_that.otpError,_that.resendSeconds);case _:
  return null;

}
}

}

/// @nodoc


class _SocialAuthState extends SocialAuthState {
  const _SocialAuthState({this.step = SocialStep.idle, this.state = RequestState.empty, this.message = '', this.provider, this.email, this.name, this.signupToken, this.linkToken, this.otpToken, this.password = '', this.passwordError, this.countryCode = '+91', this.phone = '', this.phoneError, this.typedName = '', this.nameRequired = false, this.nameError, this.sentTo = '', this.otp = '', this.otpError, this.resendSeconds = 0}): super._();
  

@override@JsonKey() final  SocialStep step;
@override@JsonKey() final  RequestState state;
/// Shown as a snackbar. Left empty when the error is drawn under a field.
@override@JsonKey() final  String message;
@override final  SocialProvider? provider;
/// From the provider; shown on the phone step.
@override final  String? email;
@override final  String? name;
@override final  String? signupToken;
@override final  String? linkToken;
@override final  String? otpToken;
@override@JsonKey() final  String password;
@override final  String? passwordError;
@override@JsonKey() final  String countryCode;
@override@JsonKey() final  String phone;
@override final  String? phoneError;
/// Apple gives the name once and Google may omit it: ask when it is
/// missing, or when the server answers `NAME_REQUIRED`.
@override@JsonKey() final  String typedName;
@override@JsonKey() final  bool nameRequired;
@override final  String? nameError;
/// The number the code went to, as the server normalised it.
@override@JsonKey() final  String sentTo;
@override@JsonKey() final  String otp;
@override final  String? otpError;
@override@JsonKey() final  int resendSeconds;

/// Create a copy of SocialAuthState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialAuthStateCopyWith<_SocialAuthState> get copyWith => __$SocialAuthStateCopyWithImpl<_SocialAuthState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialAuthState&&(identical(other.step, step) || other.step == step)&&(identical(other.state, state) || other.state == state)&&(identical(other.message, message) || other.message == message)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.signupToken, signupToken) || other.signupToken == signupToken)&&(identical(other.linkToken, linkToken) || other.linkToken == linkToken)&&(identical(other.otpToken, otpToken) || other.otpToken == otpToken)&&(identical(other.password, password) || other.password == password)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.phoneError, phoneError) || other.phoneError == phoneError)&&(identical(other.typedName, typedName) || other.typedName == typedName)&&(identical(other.nameRequired, nameRequired) || other.nameRequired == nameRequired)&&(identical(other.nameError, nameError) || other.nameError == nameError)&&(identical(other.sentTo, sentTo) || other.sentTo == sentTo)&&(identical(other.otp, otp) || other.otp == otp)&&(identical(other.otpError, otpError) || other.otpError == otpError)&&(identical(other.resendSeconds, resendSeconds) || other.resendSeconds == resendSeconds));
}


@override
int get hashCode {
    return Object.hashAll([runtimeType,step,state,message,provider,email,name,signupToken,linkToken,otpToken,password,passwordError,countryCode,phone,phoneError,typedName,nameRequired,nameError,sentTo,otp,otpError,resendSeconds]);
}

@override
String toString() {
    return 'SocialAuthState(step: $step, state: $state, message: $message, provider: $provider, email: $email, name: $name, signupToken: $signupToken, linkToken: $linkToken, otpToken: $otpToken, password: $password, passwordError: $passwordError, countryCode: $countryCode, phone: $phone, phoneError: $phoneError, typedName: $typedName, nameRequired: $nameRequired, nameError: $nameError, sentTo: $sentTo, otp: $otp, otpError: $otpError, resendSeconds: $resendSeconds)';
}


}

/// @nodoc
abstract mixin class _$SocialAuthStateCopyWith<$Res> implements $SocialAuthStateCopyWith<$Res> {
  factory _$SocialAuthStateCopyWith(_SocialAuthState value, $Res Function(_SocialAuthState) _then) = __$SocialAuthStateCopyWithImpl;
@override @useResult
$Res call({
 SocialStep step, RequestState state, String message, SocialProvider? provider, String? email, String? name, String? signupToken, String? linkToken, String? otpToken, String password, String? passwordError, String countryCode, String phone, String? phoneError, String typedName, bool nameRequired, String? nameError, String sentTo, String otp, String? otpError, int resendSeconds
});




}
/// @nodoc
class __$SocialAuthStateCopyWithImpl<$Res>
    implements _$SocialAuthStateCopyWith<$Res> {
  __$SocialAuthStateCopyWithImpl(this._self, this._then);

  final _SocialAuthState _self;
  final $Res Function(_SocialAuthState) _then;

/// Create a copy of SocialAuthState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? state = null,Object? message = null,Object? provider = freezed,Object? email = freezed,Object? name = freezed,Object? signupToken = freezed,Object? linkToken = freezed,Object? otpToken = freezed,Object? password = null,Object? passwordError = freezed,Object? countryCode = null,Object? phone = null,Object? phoneError = freezed,Object? typedName = null,Object? nameRequired = null,Object? nameError = freezed,Object? sentTo = null,Object? otp = null,Object? otpError = freezed,Object? resendSeconds = null,}) {
  return _then(_SocialAuthState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as SocialStep,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,provider: freezed == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as SocialProvider?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,signupToken: freezed == signupToken ? _self.signupToken : signupToken // ignore: cast_nullable_to_non_nullable
as String?,linkToken: freezed == linkToken ? _self.linkToken : linkToken // ignore: cast_nullable_to_non_nullable
as String?,otpToken: freezed == otpToken ? _self.otpToken : otpToken // ignore: cast_nullable_to_non_nullable
as String?,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,phoneError: freezed == phoneError ? _self.phoneError : phoneError // ignore: cast_nullable_to_non_nullable
as String?,typedName: null == typedName ? _self.typedName : typedName // ignore: cast_nullable_to_non_nullable
as String,nameRequired: null == nameRequired ? _self.nameRequired : nameRequired // ignore: cast_nullable_to_non_nullable
as bool,nameError: freezed == nameError ? _self.nameError : nameError // ignore: cast_nullable_to_non_nullable
as String?,sentTo: null == sentTo ? _self.sentTo : sentTo // ignore: cast_nullable_to_non_nullable
as String,otp: null == otp ? _self.otp : otp // ignore: cast_nullable_to_non_nullable
as String,otpError: freezed == otpError ? _self.otpError : otpError // ignore: cast_nullable_to_non_nullable
as String?,resendSeconds: null == resendSeconds ? _self.resendSeconds : resendSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
