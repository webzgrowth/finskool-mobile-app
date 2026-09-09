// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_form_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginFormEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginFormEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LoginFormEvent()';
}


}

/// @nodoc
class $LoginFormEventCopyWith<$Res>  {
$LoginFormEventCopyWith(LoginFormEvent _, $Res Function(LoginFormEvent) __);
}


/// Adds pattern-matching-related methods to [LoginFormEvent].
extension LoginFormEventPatterns on LoginFormEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _EmailChanged value)?  emailChanged,TResult Function( _PasswordChanged value)?  passwordChanged,TResult Function( _TogglePasswordVisibility value)?  togglePasswordVisibility,TResult Function( _Submit value)?  submit,TResult Function( _LoginWith value)?  loginWith,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _EmailChanged() when emailChanged != null:
return emailChanged(_that);case _PasswordChanged() when passwordChanged != null:
return passwordChanged(_that);case _TogglePasswordVisibility() when togglePasswordVisibility != null:
return togglePasswordVisibility(_that);case _Submit() when submit != null:
return submit(_that);case _LoginWith() when loginWith != null:
return loginWith(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _EmailChanged value)  emailChanged,required TResult Function( _PasswordChanged value)  passwordChanged,required TResult Function( _TogglePasswordVisibility value)  togglePasswordVisibility,required TResult Function( _Submit value)  submit,required TResult Function( _LoginWith value)  loginWith,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _EmailChanged():
return emailChanged(_that);case _PasswordChanged():
return passwordChanged(_that);case _TogglePasswordVisibility():
return togglePasswordVisibility(_that);case _Submit():
return submit(_that);case _LoginWith():
return loginWith(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _EmailChanged value)?  emailChanged,TResult? Function( _PasswordChanged value)?  passwordChanged,TResult? Function( _TogglePasswordVisibility value)?  togglePasswordVisibility,TResult? Function( _Submit value)?  submit,TResult? Function( _LoginWith value)?  loginWith,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _EmailChanged() when emailChanged != null:
return emailChanged(_that);case _PasswordChanged() when passwordChanged != null:
return passwordChanged(_that);case _TogglePasswordVisibility() when togglePasswordVisibility != null:
return togglePasswordVisibility(_that);case _Submit() when submit != null:
return submit(_that);case _LoginWith() when loginWith != null:
return loginWith(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( String email)?  emailChanged,TResult Function( String password)?  passwordChanged,TResult Function()?  togglePasswordVisibility,TResult Function()?  submit,TResult Function( String email,  String password)?  loginWith,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _EmailChanged() when emailChanged != null:
return emailChanged(_that.email);case _PasswordChanged() when passwordChanged != null:
return passwordChanged(_that.password);case _TogglePasswordVisibility() when togglePasswordVisibility != null:
return togglePasswordVisibility();case _Submit() when submit != null:
return submit();case _LoginWith() when loginWith != null:
return loginWith(_that.email,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( String email)  emailChanged,required TResult Function( String password)  passwordChanged,required TResult Function()  togglePasswordVisibility,required TResult Function()  submit,required TResult Function( String email,  String password)  loginWith,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _EmailChanged():
return emailChanged(_that.email);case _PasswordChanged():
return passwordChanged(_that.password);case _TogglePasswordVisibility():
return togglePasswordVisibility();case _Submit():
return submit();case _LoginWith():
return loginWith(_that.email,_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( String email)?  emailChanged,TResult? Function( String password)?  passwordChanged,TResult? Function()?  togglePasswordVisibility,TResult? Function()?  submit,TResult? Function( String email,  String password)?  loginWith,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _EmailChanged() when emailChanged != null:
return emailChanged(_that.email);case _PasswordChanged() when passwordChanged != null:
return passwordChanged(_that.password);case _TogglePasswordVisibility() when togglePasswordVisibility != null:
return togglePasswordVisibility();case _Submit() when submit != null:
return submit();case _LoginWith() when loginWith != null:
return loginWith(_that.email,_that.password);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements LoginFormEvent {
  const _Initial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LoginFormEvent.initial()';
}


}




/// @nodoc


class _EmailChanged implements LoginFormEvent {
  const _EmailChanged(this.email);
  

 final  String email;

/// Create a copy of LoginFormEvent
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
    return 'LoginFormEvent.emailChanged(email: $email)';
}


}

/// @nodoc
abstract mixin class _$EmailChangedCopyWith<$Res> implements $LoginFormEventCopyWith<$Res> {
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

/// Create a copy of LoginFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_EmailChanged(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PasswordChanged implements LoginFormEvent {
  const _PasswordChanged(this.password);
  

 final  String password;

/// Create a copy of LoginFormEvent
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
    return 'LoginFormEvent.passwordChanged(password: $password)';
}


}

/// @nodoc
abstract mixin class _$PasswordChangedCopyWith<$Res> implements $LoginFormEventCopyWith<$Res> {
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

/// Create a copy of LoginFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? password = null,}) {
  return _then(_PasswordChanged(
null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _TogglePasswordVisibility implements LoginFormEvent {
  const _TogglePasswordVisibility();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TogglePasswordVisibility);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LoginFormEvent.togglePasswordVisibility()';
}


}




/// @nodoc


class _Submit implements LoginFormEvent {
  const _Submit();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submit);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LoginFormEvent.submit()';
}


}




/// @nodoc


class _LoginWith implements LoginFormEvent {
  const _LoginWith({required this.email, required this.password});
  

 final  String email;
 final  String password;

/// Create a copy of LoginFormEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginWithCopyWith<_LoginWith> get copyWith => __$LoginWithCopyWithImpl<_LoginWith>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginWith&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode {
    return Object.hash(runtimeType,email,password);
}

@override
String toString() {
    return 'LoginFormEvent.loginWith(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$LoginWithCopyWith<$Res> implements $LoginFormEventCopyWith<$Res> {
  factory _$LoginWithCopyWith(_LoginWith value, $Res Function(_LoginWith) _then) = __$LoginWithCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class __$LoginWithCopyWithImpl<$Res>
    implements _$LoginWithCopyWith<$Res> {
  __$LoginWithCopyWithImpl(this._self, this._then);

  final _LoginWith _self;
  final $Res Function(_LoginWith) _then;

/// Create a copy of LoginFormEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(_LoginWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$LoginFormState {

 RequestState get state; String get message; String get email; String get password; bool get obscurePassword; String? get emailError; String? get passwordError;/// The API's machine-readable failure code, so the UI can route on
/// `NOT_REGISTERED` / `PHONE_NOT_VERIFIED` rather than parse [message].
 String? get errorCode;
/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginFormStateCopyWith<LoginFormState> get copyWith => _$LoginFormStateCopyWithImpl<LoginFormState>(this as LoginFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LoginFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginFormState&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.password, _this.password) || other.password == _this.password)&&(identical(other.obscurePassword, _this.obscurePassword) || other.obscurePassword == _this.obscurePassword)&&(identical(other.emailError, _this.emailError) || other.emailError == _this.emailError)&&(identical(other.passwordError, _this.passwordError) || other.passwordError == _this.passwordError)&&(identical(other.errorCode, _this.errorCode) || other.errorCode == _this.errorCode));
}


@override
int get hashCode {
  final _this = this as LoginFormState;
  return Object.hash(runtimeType,_this.state,_this.message,_this.email,_this.password,_this.obscurePassword,_this.emailError,_this.passwordError,_this.errorCode);
}

@override
String toString() {
  final _this = this as LoginFormState;
  return 'LoginFormState(state: ${_this.state}, message: ${_this.message}, email: ${_this.email}, password: ${_this.password}, obscurePassword: ${_this.obscurePassword}, emailError: ${_this.emailError}, passwordError: ${_this.passwordError}, errorCode: ${_this.errorCode})';
}


}

/// @nodoc
abstract mixin class $LoginFormStateCopyWith<$Res>  {
  factory $LoginFormStateCopyWith(LoginFormState value, $Res Function(LoginFormState) _then) = _$LoginFormStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, String message, String email, String password, bool obscurePassword, String? emailError, String? passwordError, String? errorCode
});




}
/// @nodoc
class _$LoginFormStateCopyWithImpl<$Res>
    implements $LoginFormStateCopyWith<$Res> {
  _$LoginFormStateCopyWithImpl(this._self, this._then);

  final LoginFormState _self;
  final $Res Function(LoginFormState) _then;

/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? message = null,Object? email = null,Object? password = null,Object? obscurePassword = null,Object? emailError = freezed,Object? passwordError = freezed,Object? errorCode = freezed,}) {
  return _then(LoginFormState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,obscurePassword: null == obscurePassword ? _self.obscurePassword : obscurePassword // ignore: cast_nullable_to_non_nullable
as bool,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as String?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginFormState].
extension LoginFormStatePatterns on LoginFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginFormState value)  $default,){
final _that = this;
switch (_that) {
case _LoginFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginFormState value)?  $default,){
final _that = this;
switch (_that) {
case _LoginFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  String message,  String email,  String password,  bool obscurePassword,  String? emailError,  String? passwordError,  String? errorCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginFormState() when $default != null:
return $default(_that.state,_that.message,_that.email,_that.password,_that.obscurePassword,_that.emailError,_that.passwordError,_that.errorCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  String message,  String email,  String password,  bool obscurePassword,  String? emailError,  String? passwordError,  String? errorCode)  $default,) {final _that = this;
switch (_that) {
case _LoginFormState():
return $default(_that.state,_that.message,_that.email,_that.password,_that.obscurePassword,_that.emailError,_that.passwordError,_that.errorCode);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  String message,  String email,  String password,  bool obscurePassword,  String? emailError,  String? passwordError,  String? errorCode)?  $default,) {final _that = this;
switch (_that) {
case _LoginFormState() when $default != null:
return $default(_that.state,_that.message,_that.email,_that.password,_that.obscurePassword,_that.emailError,_that.passwordError,_that.errorCode);case _:
  return null;

}
}

}

/// @nodoc


class _LoginFormState implements LoginFormState {
  const _LoginFormState({required this.state, required this.message, required this.email, required this.password, required this.obscurePassword, this.emailError, this.passwordError, this.errorCode});
  

@override final  RequestState state;
@override final  String message;
@override final  String email;
@override final  String password;
@override final  bool obscurePassword;
@override final  String? emailError;
@override final  String? passwordError;
/// The API's machine-readable failure code, so the UI can route on
/// `NOT_REGISTERED` / `PHONE_NOT_VERIFIED` rather than parse [message].
@override final  String? errorCode;

/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginFormStateCopyWith<_LoginFormState> get copyWith => __$LoginFormStateCopyWithImpl<_LoginFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginFormState&&(identical(other.state, state) || other.state == state)&&(identical(other.message, message) || other.message == message)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.obscurePassword, obscurePassword) || other.obscurePassword == obscurePassword)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.passwordError, passwordError) || other.passwordError == passwordError)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state,message,email,password,obscurePassword,emailError,passwordError,errorCode);
}

@override
String toString() {
    return 'LoginFormState(state: $state, message: $message, email: $email, password: $password, obscurePassword: $obscurePassword, emailError: $emailError, passwordError: $passwordError, errorCode: $errorCode)';
}


}

/// @nodoc
abstract mixin class _$LoginFormStateCopyWith<$Res> implements $LoginFormStateCopyWith<$Res> {
  factory _$LoginFormStateCopyWith(_LoginFormState value, $Res Function(_LoginFormState) _then) = __$LoginFormStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, String message, String email, String password, bool obscurePassword, String? emailError, String? passwordError, String? errorCode
});




}
/// @nodoc
class __$LoginFormStateCopyWithImpl<$Res>
    implements _$LoginFormStateCopyWith<$Res> {
  __$LoginFormStateCopyWithImpl(this._self, this._then);

  final _LoginFormState _self;
  final $Res Function(_LoginFormState) _then;

/// Create a copy of LoginFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? message = null,Object? email = null,Object? password = null,Object? obscurePassword = null,Object? emailError = freezed,Object? passwordError = freezed,Object? errorCode = freezed,}) {
  return _then(_LoginFormState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,obscurePassword: null == obscurePassword ? _self.obscurePassword : obscurePassword // ignore: cast_nullable_to_non_nullable
as bool,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as String?,passwordError: freezed == passwordError ? _self.passwordError : passwordError // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
