// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'services_catalog_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServicesCatalogEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicesCatalogEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServicesCatalogEvent()';
}


}

/// @nodoc
class $ServicesCatalogEventCopyWith<$Res>  {
$ServicesCatalogEventCopyWith(ServicesCatalogEvent _, $Res Function(ServicesCatalogEvent) __);
}


/// Adds pattern-matching-related methods to [ServicesCatalogEvent].
extension ServicesCatalogEventPatterns on ServicesCatalogEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Load value)?  load,TResult Function( _Refresh value)?  refresh,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _Refresh() when refresh != null:
return refresh(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Load value)  load,required TResult Function( _Refresh value)  refresh,}){
final _that = this;
switch (_that) {
case _Load():
return load(_that);case _Refresh():
return refresh(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Load value)?  load,TResult? Function( _Refresh value)?  refresh,}){
final _that = this;
switch (_that) {
case _Load() when load != null:
return load(_that);case _Refresh() when refresh != null:
return refresh(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  load,TResult Function()?  refresh,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load();case _Refresh() when refresh != null:
return refresh();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  load,required TResult Function()  refresh,}) {final _that = this;
switch (_that) {
case _Load():
return load();case _Refresh():
return refresh();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  load,TResult? Function()?  refresh,}) {final _that = this;
switch (_that) {
case _Load() when load != null:
return load();case _Refresh() when refresh != null:
return refresh();case _:
  return null;

}
}

}

/// @nodoc


class _Load implements ServicesCatalogEvent {
  const _Load();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Load);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServicesCatalogEvent.load()';
}


}




/// @nodoc


class _Refresh implements ServicesCatalogEvent {
  const _Refresh();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Refresh);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ServicesCatalogEvent.refresh()';
}


}




/// @nodoc
mixin _$ServicesCatalogState {

 RequestState get state; List<ServiceModel> get services; String get message;
/// Create a copy of ServicesCatalogState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServicesCatalogStateCopyWith<ServicesCatalogState> get copyWith => _$ServicesCatalogStateCopyWithImpl<ServicesCatalogState>(this as ServicesCatalogState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ServicesCatalogState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicesCatalogState&&(identical(other.state, _this.state) || other.state == _this.state)&&const DeepCollectionEquality().equals(other.services, _this.services)&&(identical(other.message, _this.message) || other.message == _this.message));
}


@override
int get hashCode {
  final _this = this as ServicesCatalogState;
  return Object.hash(runtimeType,_this.state,const DeepCollectionEquality().hash(_this.services),_this.message);
}

@override
String toString() {
  final _this = this as ServicesCatalogState;
  return 'ServicesCatalogState(state: ${_this.state}, services: ${_this.services}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $ServicesCatalogStateCopyWith<$Res>  {
  factory $ServicesCatalogStateCopyWith(ServicesCatalogState value, $Res Function(ServicesCatalogState) _then) = _$ServicesCatalogStateCopyWithImpl;
@useResult
$Res call({
 RequestState state, List<ServiceModel> services, String message
});




}
/// @nodoc
class _$ServicesCatalogStateCopyWithImpl<$Res>
    implements $ServicesCatalogStateCopyWith<$Res> {
  _$ServicesCatalogStateCopyWithImpl(this._self, this._then);

  final ServicesCatalogState _self;
  final $Res Function(ServicesCatalogState) _then;

/// Create a copy of ServicesCatalogState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? state = null,Object? services = null,Object? message = null,}) {
  return _then(ServicesCatalogState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,services: null == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as List<ServiceModel>,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ServicesCatalogState].
extension ServicesCatalogStatePatterns on ServicesCatalogState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServicesCatalogState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServicesCatalogState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServicesCatalogState value)  $default,){
final _that = this;
switch (_that) {
case _ServicesCatalogState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServicesCatalogState value)?  $default,){
final _that = this;
switch (_that) {
case _ServicesCatalogState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestState state,  List<ServiceModel> services,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServicesCatalogState() when $default != null:
return $default(_that.state,_that.services,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestState state,  List<ServiceModel> services,  String message)  $default,) {final _that = this;
switch (_that) {
case _ServicesCatalogState():
return $default(_that.state,_that.services,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestState state,  List<ServiceModel> services,  String message)?  $default,) {final _that = this;
switch (_that) {
case _ServicesCatalogState() when $default != null:
return $default(_that.state,_that.services,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _ServicesCatalogState implements ServicesCatalogState {
  const _ServicesCatalogState({required this.state, required  List<ServiceModel> services, required this.message}): _services = services;
  

@override final  RequestState state;
 final  List<ServiceModel> _services;
@override List<ServiceModel> get services {
  if (_services is EqualUnmodifiableListView) return _services;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_services);
}

@override final  String message;

/// Create a copy of ServicesCatalogState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServicesCatalogStateCopyWith<_ServicesCatalogState> get copyWith => __$ServicesCatalogStateCopyWithImpl<_ServicesCatalogState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServicesCatalogState&&(identical(other.state, state) || other.state == state)&&const DeepCollectionEquality().equals(other.services, _services)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,state,const DeepCollectionEquality().hash(_services),message);
}

@override
String toString() {
    return 'ServicesCatalogState(state: $state, services: $services, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ServicesCatalogStateCopyWith<$Res> implements $ServicesCatalogStateCopyWith<$Res> {
  factory _$ServicesCatalogStateCopyWith(_ServicesCatalogState value, $Res Function(_ServicesCatalogState) _then) = __$ServicesCatalogStateCopyWithImpl;
@override @useResult
$Res call({
 RequestState state, List<ServiceModel> services, String message
});




}
/// @nodoc
class __$ServicesCatalogStateCopyWithImpl<$Res>
    implements _$ServicesCatalogStateCopyWith<$Res> {
  __$ServicesCatalogStateCopyWithImpl(this._self, this._then);

  final _ServicesCatalogState _self;
  final $Res Function(_ServicesCatalogState) _then;

/// Create a copy of ServicesCatalogState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? state = null,Object? services = null,Object? message = null,}) {
  return _then(_ServicesCatalogState(
state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as RequestState,services: null == services ? _self._services : services // ignore: cast_nullable_to_non_nullable
as List<ServiceModel>,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
