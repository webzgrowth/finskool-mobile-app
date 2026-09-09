// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_form_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignUpFormEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpFormEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignUpFormEvent()';
}


}

/// @nodoc
class $SignUpFormEventCopyWith<$Res>  {
$SignUpFormEventCopyWith(SignUpFormEvent _, $Res Function(SignUpFormEvent) __);
}


/// Adds pattern-matching-related methods to [SignUpFormEvent].
extension SignUpFormEventPatterns on SignUpFormEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _initials value)?  initial,TResult Function( _Register value)?  registerUser,TResult Function( _EmailOnChanged value)?  emailOnChanged,TResult Function( _FirstNameChanged value)?  firstNameChanged,TResult Function( _LastNameChanged value)?  lastNameChanged,TResult Function( _CountryCodeChanged value)?  countryCodeChanged,TResult Function( _PhonenumberChanged value)?  phonenumberChanged,TResult Function( _PasswordChanged value)?  passwordChanged,TResult Function( _ConfirmPasswordChanged value)?  confirmPasswordChanged,TResult Function( _TogglePasswordVisibility value)?  togglePasswordVisibility,TResult Function( _ToggleConfirmPasswordVisibility value)?  toggleConfirmPasswordVisibility,TResult Function( _IsFromSocial value)?  isFromSocial,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _initials() when initial != null:
return initial(_that);case _Register() when registerUser != null:
return registerUser(_that);case _EmailOnChanged() when emailOnChanged != null:
return emailOnChanged(_that);case _FirstNameChanged() when firstNameChanged != null:
return firstNameChanged(_that);case _LastNameChanged() when lastNameChanged != null:
return lastNameChanged(_that);case _CountryCodeChanged() when countryCodeChanged != null:
return countryCodeChanged(_that);case _PhonenumberChanged() when phonenumberChanged != null:
return phonenumberChanged(_that);case _PasswordChanged() when passwordChanged != null:
return passwordChanged(_that);case _ConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that);case _TogglePasswordVisibility() when togglePasswordVisibility != null:
return togglePasswordVisibility(_that);case _ToggleConfirmPasswordVisibility() when toggleConfirmPasswordVisibility != null:
return toggleConfirmPasswordVisibility(_that);case _IsFromSocial() when isFromSocial != null:
return isFromSocial(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _initials value)  initial,required TResult Function( _Register value)  registerUser,required TResult Function( _EmailOnChanged value)  emailOnChanged,required TResult Function( _FirstNameChanged value)  firstNameChanged,required TResult Function( _LastNameChanged value)  lastNameChanged,required TResult Function( _CountryCodeChanged value)  countryCodeChanged,required TResult Function( _PhonenumberChanged value)  phonenumberChanged,required TResult Function( _PasswordChanged value)  passwordChanged,required TResult Function( _ConfirmPasswordChanged value)  confirmPasswordChanged,required TResult Function( _TogglePasswordVisibility value)  togglePasswordVisibility,required TResult Function( _ToggleConfirmPasswordVisibility value)  toggleConfirmPasswordVisibility,required TResult Function( _IsFromSocial value)  isFromSocial,}){
final _that = this;
switch (_that) {
case _initials():
return initial(_that);case _Register():
return registerUser(_that);case _EmailOnChanged():
return emailOnChanged(_that);case _FirstNameChanged():
return firstNameChanged(_that);case _LastNameChanged():
return lastNameChanged(_that);case _CountryCodeChanged():
return countryCodeChanged(_that);case _PhonenumberChanged():
return phonenumberChanged(_that);case _PasswordChanged():
return passwordChanged(_that);case _ConfirmPasswordChanged():
return confirmPasswordChanged(_that);case _TogglePasswordVisibility():
return togglePasswordVisibility(_that);case _ToggleConfirmPasswordVisibility():
return toggleConfirmPasswordVisibility(_that);case _IsFromSocial():
return isFromSocial(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _initials value)?  initial,TResult? Function( _Register value)?  registerUser,TResult? Function( _EmailOnChanged value)?  emailOnChanged,TResult? Function( _FirstNameChanged value)?  firstNameChanged,TResult? Function( _LastNameChanged value)?  lastNameChanged,TResult? Function( _CountryCodeChanged value)?  countryCodeChanged,TResult? Function( _PhonenumberChanged value)?  phonenumberChanged,TResult? Function( _PasswordChanged value)?  passwordChanged,TResult? Function( _ConfirmPasswordChanged value)?  confirmPasswordChanged,TResult? Function( _TogglePasswordVisibility value)?  togglePasswordVisibility,TResult? Function( _ToggleConfirmPasswordVisibility value)?  toggleConfirmPasswordVisibility,TResult? Function( _IsFromSocial value)?  isFromSocial,}){
final _that = this;
switch (_that) {
case _initials() when initial != null:
return initial(_that);case _Register() when registerUser != null:
return registerUser(_that);case _EmailOnChanged() when emailOnChanged != null:
return emailOnChanged(_that);case _FirstNameChanged() when firstNameChanged != null:
return firstNameChanged(_that);case _LastNameChanged() when lastNameChanged != null:
return lastNameChanged(_that);case _CountryCodeChanged() when countryCodeChanged != null:
return countryCodeChanged(_that);case _PhonenumberChanged() when phonenumberChanged != null:
return phonenumberChanged(_that);case _PasswordChanged() when passwordChanged != null:
return passwordChanged(_that);case _ConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that);case _TogglePasswordVisibility() when togglePasswordVisibility != null:
return togglePasswordVisibility(_that);case _ToggleConfirmPasswordVisibility() when toggleConfirmPasswordVisibility != null:
return toggleConfirmPasswordVisibility(_that);case _IsFromSocial() when isFromSocial != null:
return isFromSocial(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( bool isSocialLogin)?  registerUser,TResult Function( String email)?  emailOnChanged,TResult Function( String firstName)?  firstNameChanged,TResult Function( String lastName)?  lastNameChanged,TResult Function( String countryCode)?  countryCodeChanged,TResult Function( String phonenumber)?  phonenumberChanged,TResult Function( String password)?  passwordChanged,TResult Function( String confirmPassword)?  confirmPasswordChanged,TResult Function()?  togglePasswordVisibility,TResult Function()?  toggleConfirmPasswordVisibility,TResult Function( bool isFromSocial)?  isFromSocial,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _initials() when initial != null:
return initial();case _Register() when registerUser != null:
return registerUser(_that.isSocialLogin);case _EmailOnChanged() when emailOnChanged != null:
return emailOnChanged(_that.email);case _FirstNameChanged() when firstNameChanged != null:
return firstNameChanged(_that.firstName);case _LastNameChanged() when lastNameChanged != null:
return lastNameChanged(_that.lastName);case _CountryCodeChanged() when countryCodeChanged != null:
return countryCodeChanged(_that.countryCode);case _PhonenumberChanged() when phonenumberChanged != null:
return phonenumberChanged(_that.phonenumber);case _PasswordChanged() when passwordChanged != null:
return passwordChanged(_that.password);case _ConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that.confirmPassword);case _TogglePasswordVisibility() when togglePasswordVisibility != null:
return togglePasswordVisibility();case _ToggleConfirmPasswordVisibility() when toggleConfirmPasswordVisibility != null:
return toggleConfirmPasswordVisibility();case _IsFromSocial() when isFromSocial != null:
return isFromSocial(_that.isFromSocial);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( bool isSocialLogin)  registerUser,required TResult Function( String email)  emailOnChanged,required TResult Function( String firstName)  firstNameChanged,required TResult Function( String lastName)  lastNameChanged,required TResult Function( String countryCode)  countryCodeChanged,required TResult Function( String phonenumber)  phonenumberChanged,required TResult Function( String password)  passwordChanged,required TResult Function( String confirmPassword)  confirmPasswordChanged,required TResult Function()  togglePasswordVisibility,required TResult Function()  toggleConfirmPasswordVisibility,required TResult Function( bool isFromSocial)  isFromSocial,}) {final _that = this;
switch (_that) {
case _initials():
return initial();case _Register():
return registerUser(_that.isSocialLogin);case _EmailOnChanged():
return emailOnChanged(_that.email);case _FirstNameChanged():
return firstNameChanged(_that.firstName);case _LastNameChanged():
return lastNameChanged(_that.lastName);case _CountryCodeChanged():
return countryCodeChanged(_that.countryCode);case _PhonenumberChanged():
return phonenumberChanged(_that.phonenumber);case _PasswordChanged():
return passwordChanged(_that.password);case _ConfirmPasswordChanged():
return confirmPasswordChanged(_that.confirmPassword);case _TogglePasswordVisibility():
return togglePasswordVisibility();case _ToggleConfirmPasswordVisibility():
return toggleConfirmPasswordVisibility();case _IsFromSocial():
return isFromSocial(_that.isFromSocial);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( bool isSocialLogin)?  registerUser,TResult? Function( String email)?  emailOnChanged,TResult? Function( String firstName)?  firstNameChanged,TResult? Function( String lastName)?  lastNameChanged,TResult? Function( String countryCode)?  countryCodeChanged,TResult? Function( String phonenumber)?  phonenumberChanged,TResult? Function( String password)?  passwordChanged,TResult? Function( String confirmPassword)?  confirmPasswordChanged,TResult? Function()?  togglePasswordVisibility,TResult? Function()?  toggleConfirmPasswordVisibility,TResult? Function( bool isFromSocial)?  isFromSocial,}) {final _that = this;
switch (_that) {
case _initials() when initial != null:
return initial();case _Register() when registerUser != null:
return registerUser(_that.isSocialLogin);case _EmailOnChanged() when emailOnChanged != null:
return emailOnChanged(_that.email);case _FirstNameChanged() when firstNameChanged != null:
return firstNameChanged(_that.firstName);case _LastNameChanged() when lastNameChanged != null:
return lastNameChanged(_that.lastName);case _CountryCodeChanged() when countryCodeChanged != null:
return countryCodeChanged(_that.countryCode);case _PhonenumberChanged() when phonenumberChanged != null:
return phonenumberChanged(_that.phonenumber);case _PasswordChanged() when passwordChanged != null:
return passwordChanged(_that.password);case _ConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that.confirmPassword);case _TogglePasswordVisibility() when togglePasswordVisibility != null:
return togglePasswordVisibility();case _ToggleConfirmPasswordVisibility() when toggleConfirmPasswordVisibility != null:
return toggleConfirmPasswordVisibility();case _IsFromSocial() when isFromSocial != null:
return isFromSocial(_that.isFromSocial);case _:
  return null;

}
}

}

/// @nodoc


class _initials implements SignUpFormEvent {
  const _initials();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _initials);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignUpFormEvent.initial()';
}


}




/// @nodoc


class _Register implements SignUpFormEvent {
  const _Register(this.isSocialLogin);
  

 final  bool isSocialLogin;

/// Create a copy of SignUpFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterCopyWith<_Register> get copyWith => __$RegisterCopyWithImpl<_Register>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Register&&(identical(other.isSocialLogin, isSocialLogin) || other.isSocialLogin == isSocialLogin));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isSocialLogin);
}

@override
String toString() {
    return 'SignUpFormEvent.registerUser(isSocialLogin: $isSocialLogin)';
}


}

/// @nodoc
abstract mixin class _$RegisterCopyWith<$Res> implements $SignUpFormEventCopyWith<$Res> {
  factory _$RegisterCopyWith(_Register value, $Res Function(_Register) _then) = __$RegisterCopyWithImpl;
@useResult
$Res call({
 bool isSocialLogin
});




}
/// @nodoc
class __$RegisterCopyWithImpl<$Res>
    implements _$RegisterCopyWith<$Res> {
  __$RegisterCopyWithImpl(this._self, this._then);

  final _Register _self;
  final $Res Function(_Register) _then;

/// Create a copy of SignUpFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isSocialLogin = null,}) {
  return _then(_Register(
null == isSocialLogin ? _self.isSocialLogin : isSocialLogin // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _EmailOnChanged implements SignUpFormEvent {
  const _EmailOnChanged(this.email);
  

 final  String email;

/// Create a copy of SignUpFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailOnChangedCopyWith<_EmailOnChanged> get copyWith => __$EmailOnChangedCopyWithImpl<_EmailOnChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailOnChanged&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode {
    return Object.hash(runtimeType,email);
}

@override
String toString() {
    return 'SignUpFormEvent.emailOnChanged(email: $email)';
}


}

/// @nodoc
abstract mixin class _$EmailOnChangedCopyWith<$Res> implements $SignUpFormEventCopyWith<$Res> {
  factory _$EmailOnChangedCopyWith(_EmailOnChanged value, $Res Function(_EmailOnChanged) _then) = __$EmailOnChangedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class __$EmailOnChangedCopyWithImpl<$Res>
    implements _$EmailOnChangedCopyWith<$Res> {
  __$EmailOnChangedCopyWithImpl(this._self, this._then);

  final _EmailOnChanged _self;
  final $Res Function(_EmailOnChanged) _then;

/// Create a copy of SignUpFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_EmailOnChanged(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _FirstNameChanged implements SignUpFormEvent {
  const _FirstNameChanged(this.firstName);
  

 final  String firstName;

/// Create a copy of SignUpFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FirstNameChangedCopyWith<_FirstNameChanged> get copyWith => __$FirstNameChangedCopyWithImpl<_FirstNameChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _FirstNameChanged&&(identical(other.firstName, firstName) || other.firstName == firstName));
}


@override
int get hashCode {
    return Object.hash(runtimeType,firstName);
}

@override
String toString() {
    return 'SignUpFormEvent.firstNameChanged(firstName: $firstName)';
}


}

/// @nodoc
abstract mixin class _$FirstNameChangedCopyWith<$Res> implements $SignUpFormEventCopyWith<$Res> {
  factory _$FirstNameChangedCopyWith(_FirstNameChanged value, $Res Function(_FirstNameChanged) _then) = __$FirstNameChangedCopyWithImpl;
@useResult
$Res call({
 String firstName
});




}
/// @nodoc
class __$FirstNameChangedCopyWithImpl<$Res>
    implements _$FirstNameChangedCopyWith<$Res> {
  __$FirstNameChangedCopyWithImpl(this._self, this._then);

  final _FirstNameChanged _self;
  final $Res Function(_FirstNameChanged) _then;

/// Create a copy of SignUpFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? firstName = null,}) {
  return _then(_FirstNameChanged(
null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _LastNameChanged implements SignUpFormEvent {
  const _LastNameChanged(this.lastName);
  

 final  String lastName;

/// Create a copy of SignUpFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LastNameChangedCopyWith<_LastNameChanged> get copyWith => __$LastNameChangedCopyWithImpl<_LastNameChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LastNameChanged&&(identical(other.lastName, lastName) || other.lastName == lastName));
}


@override
int get hashCode {
    return Object.hash(runtimeType,lastName);
}

@override
String toString() {
    return 'SignUpFormEvent.lastNameChanged(lastName: $lastName)';
}


}

/// @nodoc
abstract mixin class _$LastNameChangedCopyWith<$Res> implements $SignUpFormEventCopyWith<$Res> {
  factory _$LastNameChangedCopyWith(_LastNameChanged value, $Res Function(_LastNameChanged) _then) = __$LastNameChangedCopyWithImpl;
@useResult
$Res call({
 String lastName
});




}
/// @nodoc
class __$LastNameChangedCopyWithImpl<$Res>
    implements _$LastNameChangedCopyWith<$Res> {
  __$LastNameChangedCopyWithImpl(this._self, this._then);

  final _LastNameChanged _self;
  final $Res Function(_LastNameChanged) _then;

/// Create a copy of SignUpFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? lastName = null,}) {
  return _then(_LastNameChanged(
null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CountryCodeChanged implements SignUpFormEvent {
  const _CountryCodeChanged(this.countryCode);
  

 final  String countryCode;

/// Create a copy of SignUpFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountryCodeChangedCopyWith<_CountryCodeChanged> get copyWith => __$CountryCodeChangedCopyWithImpl<_CountryCodeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CountryCodeChanged&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,countryCode);
}

@override
String toString() {
    return 'SignUpFormEvent.countryCodeChanged(countryCode: $countryCode)';
}


}

/// @nodoc
abstract mixin class _$CountryCodeChangedCopyWith<$Res> implements $SignUpFormEventCopyWith<$Res> {
  factory _$CountryCodeChangedCopyWith(_CountryCodeChanged value, $Res Function(_CountryCodeChanged) _then) = __$CountryCodeChangedCopyWithImpl;
@useResult
$Res call({
 String countryCode
});




}
/// @nodoc
class __$CountryCodeChangedCopyWithImpl<$Res>
    implements _$CountryCodeChangedCopyWith<$Res> {
  __$CountryCodeChangedCopyWithImpl(this._self, this._then);

  final _CountryCodeChanged _self;
  final $Res Function(_CountryCodeChanged) _then;

/// Create a copy of SignUpFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? countryCode = null,}) {
  return _then(_CountryCodeChanged(
null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PhonenumberChanged implements SignUpFormEvent {
  const _PhonenumberChanged(this.phonenumber);
  

 final  String phonenumber;

/// Create a copy of SignUpFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhonenumberChangedCopyWith<_PhonenumberChanged> get copyWith => __$PhonenumberChangedCopyWithImpl<_PhonenumberChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhonenumberChanged&&(identical(other.phonenumber, phonenumber) || other.phonenumber == phonenumber));
}


@override
int get hashCode {
    return Object.hash(runtimeType,phonenumber);
}

@override
String toString() {
    return 'SignUpFormEvent.phonenumberChanged(phonenumber: $phonenumber)';
}


}

/// @nodoc
abstract mixin class _$PhonenumberChangedCopyWith<$Res> implements $SignUpFormEventCopyWith<$Res> {
  factory _$PhonenumberChangedCopyWith(_PhonenumberChanged value, $Res Function(_PhonenumberChanged) _then) = __$PhonenumberChangedCopyWithImpl;
@useResult
$Res call({
 String phonenumber
});




}
/// @nodoc
class __$PhonenumberChangedCopyWithImpl<$Res>
    implements _$PhonenumberChangedCopyWith<$Res> {
  __$PhonenumberChangedCopyWithImpl(this._self, this._then);

  final _PhonenumberChanged _self;
  final $Res Function(_PhonenumberChanged) _then;

/// Create a copy of SignUpFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phonenumber = null,}) {
  return _then(_PhonenumberChanged(
null == phonenumber ? _self.phonenumber : phonenumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PasswordChanged implements SignUpFormEvent {
  const _PasswordChanged(this.password);
  

 final  String password;

/// Create a copy of SignUpFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PasswordChangedCopyWith<_PasswordChanged> get copyWith => __$PasswordChangedCopyWithImpl<_PasswordChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordChanged&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode {
    return Object.hash(runtimeType,password);
}

@override
String toString() {
    return 'SignUpFormEvent.passwordChanged(password: $password)';
}


}

/// @nodoc
abstract mixin class _$PasswordChangedCopyWith<$Res> implements $SignUpFormEventCopyWith<$Res> {
  factory _$PasswordChangedCopyWith(_PasswordChanged value, $Res Function(_PasswordChanged) _then) = __$PasswordChangedCopyWithImpl;
@useResult
$Res call({
 String password
});




}
/// @nodoc
class __$PasswordChangedCopyWithImpl<$Res>
    implements _$PasswordChangedCopyWith<$Res> {
  __$PasswordChangedCopyWithImpl(this._self, this._then);

  final _PasswordChanged _self;
  final $Res Function(_PasswordChanged) _then;

/// Create a copy of SignUpFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? password = null,}) {
  return _then(_PasswordChanged(
null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _ConfirmPasswordChanged implements SignUpFormEvent {
  const _ConfirmPasswordChanged(this.confirmPassword);
  

 final  String confirmPassword;

/// Create a copy of SignUpFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfirmPasswordChangedCopyWith<_ConfirmPasswordChanged> get copyWith => __$ConfirmPasswordChangedCopyWithImpl<_ConfirmPasswordChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfirmPasswordChanged&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword));
}


@override
int get hashCode {
    return Object.hash(runtimeType,confirmPassword);
}

@override
String toString() {
    return 'SignUpFormEvent.confirmPasswordChanged(confirmPassword: $confirmPassword)';
}


}

/// @nodoc
abstract mixin class _$ConfirmPasswordChangedCopyWith<$Res> implements $SignUpFormEventCopyWith<$Res> {
  factory _$ConfirmPasswordChangedCopyWith(_ConfirmPasswordChanged value, $Res Function(_ConfirmPasswordChanged) _then) = __$ConfirmPasswordChangedCopyWithImpl;
@useResult
$Res call({
 String confirmPassword
});




}
/// @nodoc
class __$ConfirmPasswordChangedCopyWithImpl<$Res>
    implements _$ConfirmPasswordChangedCopyWith<$Res> {
  __$ConfirmPasswordChangedCopyWithImpl(this._self, this._then);

  final _ConfirmPasswordChanged _self;
  final $Res Function(_ConfirmPasswordChanged) _then;

/// Create a copy of SignUpFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? confirmPassword = null,}) {
  return _then(_ConfirmPasswordChanged(
null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TogglePasswordVisibility implements SignUpFormEvent {
  const _TogglePasswordVisibility();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TogglePasswordVisibility);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignUpFormEvent.togglePasswordVisibility()';
}


}




/// @nodoc


class _ToggleConfirmPasswordVisibility implements SignUpFormEvent {
  const _ToggleConfirmPasswordVisibility();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleConfirmPasswordVisibility);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'SignUpFormEvent.toggleConfirmPasswordVisibility()';
}


}




/// @nodoc


class _IsFromSocial implements SignUpFormEvent {
  const _IsFromSocial(this.isFromSocial);
  

 final  bool isFromSocial;

/// Create a copy of SignUpFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IsFromSocialCopyWith<_IsFromSocial> get copyWith => __$IsFromSocialCopyWithImpl<_IsFromSocial>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _IsFromSocial&&(identical(other.isFromSocial, isFromSocial) || other.isFromSocial == isFromSocial));
}


@override
int get hashCode {
    return Object.hash(runtimeType,isFromSocial);
}

@override
String toString() {
    return 'SignUpFormEvent.isFromSocial(isFromSocial: $isFromSocial)';
}


}

/// @nodoc
abstract mixin class _$IsFromSocialCopyWith<$Res> implements $SignUpFormEventCopyWith<$Res> {
  factory _$IsFromSocialCopyWith(_IsFromSocial value, $Res Function(_IsFromSocial) _then) = __$IsFromSocialCopyWithImpl;
@useResult
$Res call({
 bool isFromSocial
});




}
/// @nodoc
class __$IsFromSocialCopyWithImpl<$Res>
    implements _$IsFromSocialCopyWith<$Res> {
  __$IsFromSocialCopyWithImpl(this._self, this._then);

  final _IsFromSocial _self;
  final $Res Function(_IsFromSocial) _then;

/// Create a copy of SignUpFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isFromSocial = null,}) {
  return _then(_IsFromSocial(
null == isFromSocial ? _self.isFromSocial : isFromSocial // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$SignUpFormState {

 RequestState get state; String get message; String get firstName; String get lastName; String get countryCode; String get phonenumber; String get email; String get password; String get confirmPassword; bool get obscurePassword; bool get obscureConfirmPassword; bool get isFromSocial; String? get fullNameError; String? get emailError; String? get phoneError; String? get passwordError; String? get confirmPasswordError;/// Handed back by `POST /register` and required by both `verify-otp` and
/// `resend-otp`. The verification screen reads it from here via
/// `SignupVerificationEvent.prefill`.
 String? get userId;/// The API's machine-readable failure code, e.g. `ALREADY_REGISTERED`.
 String? get errorCode;
/// Create a copy of SignUpFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignUpFormStateCopyWith<SignUpFormState> get copyWith => _$SignUpFormStateCopyWithImpl<SignUpFormState>(this as SignUpFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SignUpFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignUpFormState&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.countryCode, _this.countryCode) || other.countryCode == _this.countryCode)&&(identical(other.phonenumber, _this.phonenumber) || other.phonenumber == _this.phonenumber)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.password, _this.password) || other.password == _this.password)&&(identical(other.confirmPassword, _this.confirmPassword) || other.confirmPassword == _this.confirmPassword)&&(identical(other.obscurePassword, _this.obscurePassword) || other.obscurePassword == _this.obscurePassword)&&(identical(other.obscureConfirmPassword, _this.obscureConfirmPassword) || other.obscureConfirmPassword == _this.obscureConfirmPassword)&&(identical(other.isFromSocial, _this.isFromSocial) || other.isFromSocial == _this.isFromSocial)&&(identical(other.fullNameError, _this.fullNameError) || other.fullNameError == _this.fullNameError)&&(identical(other.emailError, _this.emailError) || other.emailError == _this.emailError)&&(identical(other.phoneError, _this.phoneError) || other.phoneError == _this.phoneError)&&(identical(other.passwordError, _this.passwordError) || other.passwordError == _this.passwordError)&&(identical(other.confirmPasswordError, _this.confirmPasswordError) || other.confirmPasswordError == _this.confirmPasswordError)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode));
}


@override
int get hashCode {
  final _this = this as SignUpFormState;
  return Object.hashAll([runtimeType,_this.state,_this.message,_this.firstName,_this.lastName,_this.countryCode,_this.phonenumber,_this.email,_this.password,_this.confirmPassword,_this.obscurePassword,_this.obscureConfirmPassword,_this.isFromSocial,_this.fullNameError,_this.emailError,_this.phoneError,_this.passwordError,_this.confirmPasswordError,_this.userId,_this.errorCode]);
}

@override
String toString() {
  final _this = this as SignUpFormState;
  return 'SignUpFormState(state: ${_this.state}, message: ${_this.message}, firstName: ${_this.firstName}, lastName: ${_this.lastName}, countryCode: ${_this.countryCode}, phonenumber: ${_this.phonenumber}, email: ${_this.email}, password: ${_this.password}, confirmPassword: ${_this.confirmPassword}, obscurePassword: ${_this.obscurePassword}, obscureConfirmPassword: ${_this.obscureConfirmPassword}, isFromSocial: ${_this.isFromSocial}, fullNameError: ${_this.fullNameError}, emailError: ${_this.emailError}, phoneError: ${_this.phoneError}, passwordError: ${_this.passwordError}, confirmPasswordError: ${_this.confirmPasswordError}, userId: ${_this.userId}, errorCode: ${_this.errorCode})';
}


}

/// @nodoc
abstract mixin class $SignUpFormStateCopyWith<$Res>  {
  factory $SignUpFormStateCopyWith(SignUpFormState value, $Res Function(SignUpFormState) _then) = _$SignUpFormStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, String message, String firstName, String lastName, String countryCode, String phonenumber, String email, String password, String confirmPassword, bool obscurePassword, bool obscureConfirmPassword, bool isFromSocial, String? fullNameError, String? emailError, String? phoneError, String? passwordError, String? confirmPasswordError, String? userId, String? errorCode
});




}
/// @nodoc
class _$SignUpFormStateCopyWithImpl<$Res>
    implements $SignUpFormStateCopyWith<$Res> {
  _$SignUpFormStateCopyWithImpl(this._self, this._then);

  final SignUpFormState _self;
  final $Res Function(SignUpFormState) _then;

/// Create a copy of SignUpFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? message = null,Object? firstName = null,Object? lastName = null,Object? countryCode = null,Object? phonenumber = null,Object? email = null,Object? password = null,Object? confirmPassword = null,Object? obscurePassword = null,Object? obscureConfirmPassword = null,Object? isFromSocial = null,Object? fullNameError = freezed,Object? emailError = freezed,Object? phoneError = freezed,Object? passwordError = freezed,Object? confirmPasswordError = freezed,Object? userId = freezed,Object? errorCode = freezed,}) {
  return _then(SignUpFormState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,phonenumber: null == phonenumber ? _self.phonenumber : phonenumber // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,obscurePassword: null == obscurePassword ? _self.obscurePassword : obscurePassword // ignore: cast_nullable_to_non_nullable
as bool,obscureConfirmPassword: null == obscureConfirmPassword ? _self.obscureConfirmPassword : obscureConfirmPassword // ignore: cast_nullable_to_non_nullable
as bool,isFromSocial: null == isFromSocial ? _self.isFromSocial : isFromSocial // ignore: cast_nullable_to_non_nullable
as bool,fullNameError: freezed == fullNameError ? _self.fullNameError : fullNameError // ignore: cast_nullable_to_non_nullable
as String?,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as String?,phoneError: freezed == phoneError ? _self.phoneError : phoneError // ignore: cast_nullable_to_non_nullable
as String?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,confirmPasswordError: freezed == confirmPasswordError ? _self.confirmPasswordError : confirmPasswordError // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SignUpFormState].
extension SignUpFormStatePatterns on SignUpFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignUpFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignUpFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignUpFormState value)  $default,){
final _that = this;
switch (_that) {
case _SignUpFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignUpFormState value)?  $default,){
final _that = this;
switch (_that) {
case _SignUpFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  String message,  String firstName,  String lastName,  String countryCode,  String phonenumber,  String email,  String password,  String confirmPassword,  bool obscurePassword,  bool obscureConfirmPassword,  bool isFromSocial,  String? fullNameError,  String? emailError,  String? phoneError,  String? passwordError,  String? confirmPasswordError,  String? userId,  String? errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignUpFormState() when $default != null:
return $default(_that.state,_that.message,_that.firstName,_that.lastName,_that.countryCode,_that.phonenumber,_that.email,_that.password,_that.confirmPassword,_that.obscurePassword,_that.obscureConfirmPassword,_that.isFromSocial,_that.fullNameError,_that.emailError,_that.phoneError,_that.passwordError,_that.confirmPasswordError,_that.userId,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  String message,  String firstName,  String lastName,  String countryCode,  String phonenumber,  String email,  String password,  String confirmPassword,  bool obscurePassword,  bool obscureConfirmPassword,  bool isFromSocial,  String? fullNameError,  String? emailError,  String? phoneError,  String? passwordError,  String? confirmPasswordError,  String? userId,  String? errorCode)  $default,) {final _that = this;
switch (_that) {
case _SignUpFormState():
return $default(_that.state,_that.message,_that.firstName,_that.lastName,_that.countryCode,_that.phonenumber,_that.email,_that.password,_that.confirmPassword,_that.obscurePassword,_that.obscureConfirmPassword,_that.isFromSocial,_that.fullNameError,_that.emailError,_that.phoneError,_that.passwordError,_that.confirmPasswordError,_that.userId,_that.errorCode);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  String message,  String firstName,  String lastName,  String countryCode,  String phonenumber,  String email,  String password,  String confirmPassword,  bool obscurePassword,  bool obscureConfirmPassword,  bool isFromSocial,  String? fullNameError,  String? emailError,  String? phoneError,  String? passwordError,  String? confirmPasswordError,  String? userId,  String? errorCode)?  $default,) {final _that = this;
switch (_that) {
case _SignUpFormState() when $default != null:
return $default(_that.state,_that.message,_that.firstName,_that.lastName,_that.countryCode,_that.phonenumber,_that.email,_that.password,_that.confirmPassword,_that.obscurePassword,_that.obscureConfirmPassword,_that.isFromSocial,_that.fullNameError,_that.emailError,_that.phoneError,_that.passwordError,_that.confirmPasswordError,_that.userId,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc


class _SignUpFormState implements SignUpFormState {
  const _SignUpFormState({required this.state, required this.message, required this.firstName, required this.lastName, required this.countryCode, required this.phonenumber, required this.email, required this.password, required this.confirmPassword, required this.obscurePassword, required this.obscureConfirmPassword, required this.isFromSocial, this.fullNameError, this.emailError, this.phoneError, this.passwordError, this.confirmPasswordError, this.userId, this.errorCode});
  

@override final  RequestState state;
@override final  String message;
@override final  String firstName;
@override final  String lastName;
@override final  String countryCode;
@override final  String phonenumber;
@override final  String email;
@override final  String password;
@override final  String confirmPassword;
@override final  bool obscurePassword;
@override final  bool obscureConfirmPassword;
@override final  bool isFromSocial;
@override final  String? fullNameError;
@override final  String? emailError;
@override final  String? phoneError;
@override final  String? passwordError;
@override final  String? confirmPasswordError;
/// Handed back by `POST /register` and required by both `verify-otp` and
/// `resend-otp`. The verification screen reads it from here via
/// `SignupVerificationEvent.prefill`.
@override final  String? userId;
/// The API's machine-readable failure code, e.g. `ALREADY_REGISTERED`.
@override final  String? errorCode;

/// Create a copy of SignUpFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignUpFormStateCopyWith<_SignUpFormState> get copyWith => __$SignUpFormStateCopyWithImpl<_SignUpFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignUpFormState&&(identical(other.state, state) || other.state == state)&&(identical(other.message, message) || other.message == message)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.phonenumber, phonenumber) || other.phonenumber == phonenumber)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword)&&(identical(other.obscurePassword, obscurePassword) || other.obscurePassword == obscurePassword)&&(identical(other.obscureConfirmPassword, obscureConfirmPassword) || other.obscureConfirmPassword == obscureConfirmPassword)&&(identical(other.isFromSocial, isFromSocial) || other.isFromSocial == isFromSocial)&&(identical(other.fullNameError, fullNameError) || other.fullNameError == fullNameError)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.phoneError, phoneError) || other.phoneError == phoneError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.confirmPasswordError, confirmPasswordError) || other.confirmPasswordError == confirmPasswordError)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hashAll([runtimeType,state,message,firstName,lastName,countryCode,phonenumber,email,password,confirmPassword,obscurePassword,obscureConfirmPassword,isFromSocial,fullNameError,emailError,phoneError,passwordError,confirmPasswordError,userId,errorCode]);
}

@override
String toString() {
    return 'SignUpFormState(state: $state, message: $message, firstName: $firstName, lastName: $lastName, countryCode: $countryCode, phonenumber: $phonenumber, email: $email, password: $password, confirmPassword: $confirmPassword, obscurePassword: $obscurePassword, obscureConfirmPassword: $obscureConfirmPassword, isFromSocial: $isFromSocial, fullNameError: $fullNameError, emailError: $emailError, phoneError: $phoneError, passwordError: $passwordError, confirmPasswordError: $confirmPasswordError, userId: $userId, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$SignUpFormStateCopyWith<$Res> implements $SignUpFormStateCopyWith<$Res> {
  factory _$SignUpFormStateCopyWith(_SignUpFormState value, $Res Function(_SignUpFormState) _then) = __$SignUpFormStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, String message, String firstName, String lastName, String countryCode, String phonenumber, String email, String password, String confirmPassword, bool obscurePassword, bool obscureConfirmPassword, bool isFromSocial, String? fullNameError, String? emailError, String? phoneError, String? passwordError, String? confirmPasswordError, String? userId, String? errorCode
});




}
/// @nodoc
class __$SignUpFormStateCopyWithImpl<$Res>
    implements _$SignUpFormStateCopyWith<$Res> {
  __$SignUpFormStateCopyWithImpl(this._self, this._then);

  final _SignUpFormState _self;
  final $Res Function(_SignUpFormState) _then;

/// Create a copy of SignUpFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? message = null,Object? firstName = null,Object? lastName = null,Object? countryCode = null,Object? phonenumber = null,Object? email = null,Object? password = null,Object? confirmPassword = null,Object? obscurePassword = null,Object? obscureConfirmPassword = null,Object? isFromSocial = null,Object? fullNameError = freezed,Object? emailError = freezed,Object? phoneError = freezed,Object? passwordError = freezed,Object? confirmPasswordError = freezed,Object? userId = freezed,Object? errorCode = freezed,}) {
  return _then(_SignUpFormState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,phonenumber: null == phonenumber ? _self.phonenumber : phonenumber // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,obscurePassword: null == obscurePassword ? _self.obscurePassword : obscurePassword // ignore: cast_nullable_to_non_nullable
as bool,obscureConfirmPassword: null == obscureConfirmPassword ? _self.obscureConfirmPassword : obscureConfirmPassword // ignore: cast_nullable_to_non_nullable
as bool,isFromSocial: null == isFromSocial ? _self.isFromSocial : isFromSocial // ignore: cast_nullable_to_non_nullable
as bool,fullNameError: freezed == fullNameError ? _self.fullNameError : fullNameError // ignore: cast_nullable_to_non_nullable
as String?,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as String?,phoneError: freezed == phoneError ? _self.phoneError : phoneError // ignore: cast_nullable_to_non_nullable
as String?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,confirmPasswordError: freezed == confirmPasswordError ? _self.confirmPasswordError : confirmPasswordError // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
