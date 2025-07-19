// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bank.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Bank {

 int get id; String get name; String? get code; String? get logo_url; double? get distance;
/// Create a copy of Bank
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BankCopyWith<Bank> get copyWith => _$BankCopyWithImpl<Bank>(this as Bank, _$identity);

  /// Serializes this Bank to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Bank&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.logo_url, logo_url) || other.logo_url == logo_url)&&(identical(other.distance, distance) || other.distance == distance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code,logo_url,distance);

@override
String toString() {
  return 'Bank(id: $id, name: $name, code: $code, logo_url: $logo_url, distance: $distance)';
}


}

/// @nodoc
abstract mixin class $BankCopyWith<$Res>  {
  factory $BankCopyWith(Bank value, $Res Function(Bank) _then) = _$BankCopyWithImpl;
@useResult
$Res call({
 int id, String name, String? code, String? logo_url, double? distance
});




}
/// @nodoc
class _$BankCopyWithImpl<$Res>
    implements $BankCopyWith<$Res> {
  _$BankCopyWithImpl(this._self, this._then);

  final Bank _self;
  final $Res Function(Bank) _then;

/// Create a copy of Bank
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? code = freezed,Object? logo_url = freezed,Object? distance = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,logo_url: freezed == logo_url ? _self.logo_url : logo_url // ignore: cast_nullable_to_non_nullable
as String?,distance: freezed == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Bank implements Bank {
  const _Bank({required this.id, required this.name, this.code, this.logo_url, this.distance});
  factory _Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);

@override final  int id;
@override final  String name;
@override final  String? code;
@override final  String? logo_url;
@override final  double? distance;

/// Create a copy of Bank
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BankCopyWith<_Bank> get copyWith => __$BankCopyWithImpl<_Bank>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BankToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Bank&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.code, code) || other.code == code)&&(identical(other.logo_url, logo_url) || other.logo_url == logo_url)&&(identical(other.distance, distance) || other.distance == distance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,code,logo_url,distance);

@override
String toString() {
  return 'Bank(id: $id, name: $name, code: $code, logo_url: $logo_url, distance: $distance)';
}


}

/// @nodoc
abstract mixin class _$BankCopyWith<$Res> implements $BankCopyWith<$Res> {
  factory _$BankCopyWith(_Bank value, $Res Function(_Bank) _then) = __$BankCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String? code, String? logo_url, double? distance
});




}
/// @nodoc
class __$BankCopyWithImpl<$Res>
    implements _$BankCopyWith<$Res> {
  __$BankCopyWithImpl(this._self, this._then);

  final _Bank _self;
  final $Res Function(_Bank) _then;

/// Create a copy of Bank
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? code = freezed,Object? logo_url = freezed,Object? distance = freezed,}) {
  return _then(_Bank(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,logo_url: freezed == logo_url ? _self.logo_url : logo_url // ignore: cast_nullable_to_non_nullable
as String?,distance: freezed == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
