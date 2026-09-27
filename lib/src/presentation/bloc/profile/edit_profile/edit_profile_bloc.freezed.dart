// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EditProfileEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'EditProfileEvent()';
}


}

/// @nodoc
class $EditProfileEventCopyWith<$Res>  {
$EditProfileEventCopyWith(EditProfileEvent _, $Res Function(EditProfileEvent) __);
}


/// Adds pattern-matching-related methods to [EditProfileEvent].
extension EditProfileEventPatterns on EditProfileEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Prefill value)?  prefill,TResult Function( _EditToggled value)?  editToggled,TResult Function( _NameChanged value)?  nameChanged,TResult Function( _EmailChanged value)?  emailChanged,TResult Function( _PhoneChanged value)?  phoneChanged,TResult Function( _CountryChanged value)?  countryChanged,TResult Function( _Submit value)?  submit,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Prefill() when prefill != null:
return prefill(_that);case _EditToggled() when editToggled != null:
return editToggled(_that);case _NameChanged() when nameChanged != null:
return nameChanged(_that);case _EmailChanged() when emailChanged != null:
return emailChanged(_that);case _PhoneChanged() when phoneChanged != null:
return phoneChanged(_that);case _CountryChanged() when countryChanged != null:
return countryChanged(_that);case _Submit() when submit != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Prefill value)  prefill,required TResult Function( _EditToggled value)  editToggled,required TResult Function( _NameChanged value)  nameChanged,required TResult Function( _EmailChanged value)  emailChanged,required TResult Function( _PhoneChanged value)  phoneChanged,required TResult Function( _CountryChanged value)  countryChanged,required TResult Function( _Submit value)  submit,}){
final _that = this;
switch (_that) {
case _Prefill():
return prefill(_that);case _EditToggled():
return editToggled(_that);case _NameChanged():
return nameChanged(_that);case _EmailChanged():
return emailChanged(_that);case _PhoneChanged():
return phoneChanged(_that);case _CountryChanged():
return countryChanged(_that);case _Submit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Prefill value)?  prefill,TResult? Function( _EditToggled value)?  editToggled,TResult? Function( _NameChanged value)?  nameChanged,TResult? Function( _EmailChanged value)?  emailChanged,TResult? Function( _PhoneChanged value)?  phoneChanged,TResult? Function( _CountryChanged value)?  countryChanged,TResult? Function( _Submit value)?  submit,}){
final _that = this;
switch (_that) {
case _Prefill() when prefill != null:
return prefill(_that);case _EditToggled() when editToggled != null:
return editToggled(_that);case _NameChanged() when nameChanged != null:
return nameChanged(_that);case _EmailChanged() when emailChanged != null:
return emailChanged(_that);case _PhoneChanged() when phoneChanged != null:
return phoneChanged(_that);case _CountryChanged() when countryChanged != null:
return countryChanged(_that);case _Submit() when submit != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( UserModel? user)?  prefill,TResult Function()?  editToggled,TResult Function( String name)?  nameChanged,TResult Function( String email)?  emailChanged,TResult Function( String phone)?  phoneChanged,TResult Function( Country country)?  countryChanged,TResult Function()?  submit,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Prefill() when prefill != null:
return prefill(_that.user);case _EditToggled() when editToggled != null:
return editToggled();case _NameChanged() when nameChanged != null:
return nameChanged(_that.name);case _EmailChanged() when emailChanged != null:
return emailChanged(_that.email);case _PhoneChanged() when phoneChanged != null:
return phoneChanged(_that.phone);case _CountryChanged() when countryChanged != null:
return countryChanged(_that.country);case _Submit() when submit != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( UserModel? user)  prefill,required TResult Function()  editToggled,required TResult Function( String name)  nameChanged,required TResult Function( String email)  emailChanged,required TResult Function( String phone)  phoneChanged,required TResult Function( Country country)  countryChanged,required TResult Function()  submit,}) {final _that = this;
switch (_that) {
case _Prefill():
return prefill(_that.user);case _EditToggled():
return editToggled();case _NameChanged():
return nameChanged(_that.name);case _EmailChanged():
return emailChanged(_that.email);case _PhoneChanged():
return phoneChanged(_that.phone);case _CountryChanged():
return countryChanged(_that.country);case _Submit():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( UserModel? user)?  prefill,TResult? Function()?  editToggled,TResult? Function( String name)?  nameChanged,TResult? Function( String email)?  emailChanged,TResult? Function( String phone)?  phoneChanged,TResult? Function( Country country)?  countryChanged,TResult? Function()?  submit,}) {final _that = this;
switch (_that) {
case _Prefill() when prefill != null:
return prefill(_that.user);case _EditToggled() when editToggled != null:
return editToggled();case _NameChanged() when nameChanged != null:
return nameChanged(_that.name);case _EmailChanged() when emailChanged != null:
return emailChanged(_that.email);case _PhoneChanged() when phoneChanged != null:
return phoneChanged(_that.phone);case _CountryChanged() when countryChanged != null:
return countryChanged(_that.country);case _Submit() when submit != null:
return submit();case _:
  return null;

}
}

}

/// @nodoc


class _Prefill implements EditProfileEvent {
  const _Prefill(this.user);
  

 final  UserModel? user;

/// Create a copy of EditProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrefillCopyWith<_Prefill> get copyWith => __$PrefillCopyWithImpl<_Prefill>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Prefill&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode {
    return Object.hash(runtimeType,user);
}

@override
String toString() {
    return 'EditProfileEvent.prefill(user: $user)';
}


}

/// @nodoc
abstract mixin class _$PrefillCopyWith<$Res> implements $EditProfileEventCopyWith<$Res> {
  factory _$PrefillCopyWith(_Prefill value, $Res Function(_Prefill) _then) = __$PrefillCopyWithImpl;
@useResult
$Res call({
 UserModel? user
});




}
/// @nodoc
class __$PrefillCopyWithImpl<$Res>
    implements _$PrefillCopyWith<$Res> {
  __$PrefillCopyWithImpl(this._self, this._then);

  final _Prefill _self;
  final $Res Function(_Prefill) _then;

/// Create a copy of EditProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = freezed,}) {
  return _then(_Prefill(
freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel?,
  ));
}


}

/// @nodoc


class _EditToggled implements EditProfileEvent {
  const _EditToggled();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'EditProfileEvent.editToggled()';
}


}




/// @nodoc


class _NameChanged implements EditProfileEvent {
  const _NameChanged(this.name);
  

 final  String name;

/// Create a copy of EditProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NameChangedCopyWith<_NameChanged> get copyWith => __$NameChangedCopyWithImpl<_NameChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NameChanged&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name);
}

@override
String toString() {
    return 'EditProfileEvent.nameChanged(name: $name)';
}


}

/// @nodoc
abstract mixin class _$NameChangedCopyWith<$Res> implements $EditProfileEventCopyWith<$Res> {
  factory _$NameChangedCopyWith(_NameChanged value, $Res Function(_NameChanged) _then) = __$NameChangedCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class __$NameChangedCopyWithImpl<$Res>
    implements _$NameChangedCopyWith<$Res> {
  __$NameChangedCopyWithImpl(this._self, this._then);

  final _NameChanged _self;
  final $Res Function(_NameChanged) _then;

/// Create a copy of EditProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(_NameChanged(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _EmailChanged implements EditProfileEvent {
  const _EmailChanged(this.email);
  

 final  String email;

/// Create a copy of EditProfileEvent
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
    return 'EditProfileEvent.emailChanged(email: $email)';
}


}

/// @nodoc
abstract mixin class _$EmailChangedCopyWith<$Res> implements $EditProfileEventCopyWith<$Res> {
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

/// Create a copy of EditProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(_EmailChanged(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _PhoneChanged implements EditProfileEvent {
  const _PhoneChanged(this.phone);
  

 final  String phone;

/// Create a copy of EditProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneChangedCopyWith<_PhoneChanged> get copyWith => __$PhoneChangedCopyWithImpl<_PhoneChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneChanged&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode {
    return Object.hash(runtimeType,phone);
}

@override
String toString() {
    return 'EditProfileEvent.phoneChanged(phone: $phone)';
}


}

/// @nodoc
abstract mixin class _$PhoneChangedCopyWith<$Res> implements $EditProfileEventCopyWith<$Res> {
  factory _$PhoneChangedCopyWith(_PhoneChanged value, $Res Function(_PhoneChanged) _then) = __$PhoneChangedCopyWithImpl;
@useResult
$Res call({
 String phone
});




}
/// @nodoc
class __$PhoneChangedCopyWithImpl<$Res>
    implements _$PhoneChangedCopyWith<$Res> {
  __$PhoneChangedCopyWithImpl(this._self, this._then);

  final _PhoneChanged _self;
  final $Res Function(_PhoneChanged) _then;

/// Create a copy of EditProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phone = null,}) {
  return _then(_PhoneChanged(
null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _CountryChanged implements EditProfileEvent {
  const _CountryChanged(this.country);
  

 final  Country country;

/// Create a copy of EditProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CountryChangedCopyWith<_CountryChanged> get copyWith => __$CountryChangedCopyWithImpl<_CountryChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CountryChanged&&(identical(other.country, country) || other.country == country));
}


@override
int get hashCode {
    return Object.hash(runtimeType,country);
}

@override
String toString() {
    return 'EditProfileEvent.countryChanged(country: $country)';
}


}

/// @nodoc
abstract mixin class _$CountryChangedCopyWith<$Res> implements $EditProfileEventCopyWith<$Res> {
  factory _$CountryChangedCopyWith(_CountryChanged value, $Res Function(_CountryChanged) _then) = __$CountryChangedCopyWithImpl;
@useResult
$Res call({
 Country country
});




}
/// @nodoc
class __$CountryChangedCopyWithImpl<$Res>
    implements _$CountryChangedCopyWith<$Res> {
  __$CountryChangedCopyWithImpl(this._self, this._then);

  final _CountryChanged _self;
  final $Res Function(_CountryChanged) _then;

/// Create a copy of EditProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? country = null,}) {
  return _then(_CountryChanged(
null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as Country,
  ));
}


}

/// @nodoc


class _Submit implements EditProfileEvent {
  const _Submit();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Submit);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'EditProfileEvent.submit()';
}


}




/// @nodoc
mixin _$EditProfileState {

 RequestState get state; String get message; String get name; String get email; String get phone;/// Drives the dial-code chip and, via [Country.digits], what
/// `Validators.phone` treats as a valid length.
 Country get country;/// Fields are read-only until the header's pencil turns this on.
 bool get isEditing; String? get nameError; String? get emailError; String? get phoneError;
/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EditProfileStateCopyWith<EditProfileState> get copyWith => _$EditProfileStateCopyWithImpl<EditProfileState>(this as EditProfileState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as EditProfileState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EditProfileState&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.country, _this.country) || other.country == _this.country)&&(identical(other.isEditing, _this.isEditing) || other.isEditing == _this.isEditing)&&(identical(other.nameError, _this.nameError) || other.nameError == _this.nameError)&&(identical(other.emailError, _this.emailError) || other.emailError == _this.emailError)&&(identical(other.phoneError, _this.phoneError) || other.phoneError == _this.phoneError));
}


@override
int get hashCode {
  final _this = this as EditProfileState;
  return Object.hash(runtimeType,_this.state,_this.message,_this.name,_this.email,_this.phone,_this.country,_this.isEditing,_this.nameError,_this.emailError,_this.phoneError);
}

@override
String toString() {
  final _this = this as EditProfileState;
  return 'EditProfileState(state: ${_this.state}, message: ${_this.message}, name: ${_this.name}, email: ${_this.email}, phone: ${_this.phone}, country: ${_this.country}, isEditing: ${_this.isEditing}, nameError: ${_this.nameError}, emailError: ${_this.emailError}, phoneError: ${_this.phoneError})';
}


}

/// @nodoc
abstract mixin class $EditProfileStateCopyWith<$Res>  {
  factory $EditProfileStateCopyWith(EditProfileState value, $Res Function(EditProfileState) _then) = _$EditProfileStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, String message, String name, String email, String phone, Country country, bool isEditing, String? nameError, String? emailError, String? phoneError
});




}
/// @nodoc
class _$EditProfileStateCopyWithImpl<$Res>
    implements $EditProfileStateCopyWith<$Res> {
  _$EditProfileStateCopyWithImpl(this._self, this._then);

  final EditProfileState _self;
  final $Res Function(EditProfileState) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? message = null,Object? name = null,Object? email = null,Object? phone = null,Object? country = null,Object? isEditing = null,Object? nameError = freezed,Object? emailError = freezed,Object? phoneError = freezed,}) {
  return _then(EditProfileState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as Country,isEditing: null == isEditing ? _self.isEditing : isEditing // ignore: cast_nullable_to_non_nullable
as bool,nameError: freezed == nameError ? _self.nameError : nameError // ignore: cast_nullable_to_non_nullable
as String?,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as String?,phoneError: freezed == phoneError ? _self.phoneError : phoneError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EditProfileState].
extension EditProfileStatePatterns on EditProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EditProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EditProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EditProfileState value)  $default,){
final _that = this;
switch (_that) {
case _EditProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EditProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _EditProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  String message,  String name,  String email,  String phone,  Country country,  bool isEditing,  String? nameError,  String? emailError,  String? phoneError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EditProfileState() when $default != null:
return $default(_that.state,_that.message,_that.name,_that.email,_that.phone,_that.country,_that.isEditing,_that.nameError,_that.emailError,_that.phoneError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  String message,  String name,  String email,  String phone,  Country country,  bool isEditing,  String? nameError,  String? emailError,  String? phoneError)  $default,) {final _that = this;
switch (_that) {
case _EditProfileState():
return $default(_that.state,_that.message,_that.name,_that.email,_that.phone,_that.country,_that.isEditing,_that.nameError,_that.emailError,_that.phoneError);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  String message,  String name,  String email,  String phone,  Country country,  bool isEditing,  String? nameError,  String? emailError,  String? phoneError)?  $default,) {final _that = this;
switch (_that) {
case _EditProfileState() when $default != null:
return $default(_that.state,_that.message,_that.name,_that.email,_that.phone,_that.country,_that.isEditing,_that.nameError,_that.emailError,_that.phoneError);case _:
  return null;

}
}

}

/// @nodoc


class _EditProfileState extends EditProfileState {
  const _EditProfileState({required this.state, required this.message, required this.name, required this.email, required this.phone, required this.country, required this.isEditing, this.nameError, this.emailError, this.phoneError}): super._();
  

@override final  RequestState state;
@override final  String message;
@override final  String name;
@override final  String email;
@override final  String phone;
/// Drives the dial-code chip and, via [Country.digits], what
/// `Validators.phone` treats as a valid length.
@override final  Country country;
/// Fields are read-only until the header's pencil turns this on.
@override final  bool isEditing;
@override final  String? nameError;
@override final  String? emailError;
@override final  String? phoneError;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditProfileStateCopyWith<_EditProfileState> get copyWith => __$EditProfileStateCopyWithImpl<_EditProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditProfileState&&(identical(other.state, state) || other.state == state)&&(identical(other.message, message) || other.message == message)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.country, country) || other.country == country)&&(identical(other.isEditing, isEditing) || other.isEditing == isEditing)&&(identical(other.nameError, nameError) || other.nameError == nameError)&&(identical(other.emailError, emailError) || other.emailError == emailError)&&(identical(other.phoneError, phoneError) || other.phoneError == phoneError));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state,message,name,email,phone,country,isEditing,nameError,emailError,phoneError);
}

@override
String toString() {
    return 'EditProfileState(state: $state, message: $message, name: $name, email: $email, phone: $phone, country: $country, isEditing: $isEditing, nameError: $nameError, emailError: $emailError, phoneError: $phoneError)';
}


}

/// @nodoc
abstract mixin class _$EditProfileStateCopyWith<$Res> implements $EditProfileStateCopyWith<$Res> {
  factory _$EditProfileStateCopyWith(_EditProfileState value, $Res Function(_EditProfileState) _then) = __$EditProfileStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, String message, String name, String email, String phone, Country country, bool isEditing, String? nameError, String? emailError, String? phoneError
});




}
/// @nodoc
class __$EditProfileStateCopyWithImpl<$Res>
    implements _$EditProfileStateCopyWith<$Res> {
  __$EditProfileStateCopyWithImpl(this._self, this._then);

  final _EditProfileState _self;
  final $Res Function(_EditProfileState) _then;

/// Create a copy of EditProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? message = null,Object? name = null,Object? email = null,Object? phone = null,Object? country = null,Object? isEditing = null,Object? nameError = freezed,Object? emailError = freezed,Object? phoneError = freezed,}) {
  return _then(_EditProfileState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as Country,isEditing: null == isEditing ? _self.isEditing : isEditing // ignore: cast_nullable_to_non_nullable
as bool,nameError: freezed == nameError ? _self.nameError : nameError // ignore: cast_nullable_to_non_nullable
as String?,emailError: freezed == emailError ? _self.emailError : emailError // ignore: cast_nullable_to_non_nullable
as String?,phoneError: freezed == phoneError ? _self.phoneError : phoneError // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
