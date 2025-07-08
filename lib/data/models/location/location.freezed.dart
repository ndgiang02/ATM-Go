// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Location {

 int get id; String? get link; String? get title; String? get category; String? get address; String? get website; String? get phone; double? get latitude; double? get longitude; String? get descriptions; String? get owner; String? get type; String? get openHours; String? get bankCode; String? get logo; double? get reviewRating; double? get distance;
/// Create a copy of Location
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationCopyWith<Location> get copyWith => _$LocationCopyWithImpl<Location>(this as Location, _$identity);

  /// Serializes this Location to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Location&&(identical(other.id, id) || other.id == id)&&(identical(other.link, link) || other.link == link)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.address, address) || other.address == address)&&(identical(other.website, website) || other.website == website)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.descriptions, descriptions) || other.descriptions == descriptions)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.type, type) || other.type == type)&&(identical(other.openHours, openHours) || other.openHours == openHours)&&(identical(other.bankCode, bankCode) || other.bankCode == bankCode)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.reviewRating, reviewRating) || other.reviewRating == reviewRating)&&(identical(other.distance, distance) || other.distance == distance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,link,title,category,address,website,phone,latitude,longitude,descriptions,owner,type,openHours,bankCode,logo,reviewRating,distance);

@override
String toString() {
  return 'Location(id: $id, link: $link, title: $title, category: $category, address: $address, website: $website, phone: $phone, latitude: $latitude, longitude: $longitude, descriptions: $descriptions, owner: $owner, type: $type, openHours: $openHours, bankCode: $bankCode, logo: $logo, reviewRating: $reviewRating, distance: $distance)';
}


}

/// @nodoc
abstract mixin class $LocationCopyWith<$Res>  {
  factory $LocationCopyWith(Location value, $Res Function(Location) _then) = _$LocationCopyWithImpl;
@useResult
$Res call({
 int id, String? link, String? title, String? category, String? address, String? website, String? phone, double? latitude, double? longitude, String? descriptions, String? owner, String? type, String? openHours, String? bankCode, String? logo, double? reviewRating, double? distance
});




}
/// @nodoc
class _$LocationCopyWithImpl<$Res>
    implements $LocationCopyWith<$Res> {
  _$LocationCopyWithImpl(this._self, this._then);

  final Location _self;
  final $Res Function(Location) _then;

/// Create a copy of Location
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? link = freezed,Object? title = freezed,Object? category = freezed,Object? address = freezed,Object? website = freezed,Object? phone = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? descriptions = freezed,Object? owner = freezed,Object? type = freezed,Object? openHours = freezed,Object? bankCode = freezed,Object? logo = freezed,Object? reviewRating = freezed,Object? distance = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,descriptions: freezed == descriptions ? _self.descriptions : descriptions // ignore: cast_nullable_to_non_nullable
as String?,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,openHours: freezed == openHours ? _self.openHours : openHours // ignore: cast_nullable_to_non_nullable
as String?,bankCode: freezed == bankCode ? _self.bankCode : bankCode // ignore: cast_nullable_to_non_nullable
as String?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,reviewRating: freezed == reviewRating ? _self.reviewRating : reviewRating // ignore: cast_nullable_to_non_nullable
as double?,distance: freezed == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Location implements Location {
  const _Location({required this.id, this.link, this.title, this.category, this.address, this.website, this.phone, this.latitude, this.longitude, this.descriptions, this.owner, this.type, this.openHours, this.bankCode, this.logo, this.reviewRating, this.distance});
  factory _Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

@override final  int id;
@override final  String? link;
@override final  String? title;
@override final  String? category;
@override final  String? address;
@override final  String? website;
@override final  String? phone;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? descriptions;
@override final  String? owner;
@override final  String? type;
@override final  String? openHours;
@override final  String? bankCode;
@override final  String? logo;
@override final  double? reviewRating;
@override final  double? distance;

/// Create a copy of Location
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationCopyWith<_Location> get copyWith => __$LocationCopyWithImpl<_Location>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Location&&(identical(other.id, id) || other.id == id)&&(identical(other.link, link) || other.link == link)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.address, address) || other.address == address)&&(identical(other.website, website) || other.website == website)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.descriptions, descriptions) || other.descriptions == descriptions)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.type, type) || other.type == type)&&(identical(other.openHours, openHours) || other.openHours == openHours)&&(identical(other.bankCode, bankCode) || other.bankCode == bankCode)&&(identical(other.logo, logo) || other.logo == logo)&&(identical(other.reviewRating, reviewRating) || other.reviewRating == reviewRating)&&(identical(other.distance, distance) || other.distance == distance));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,link,title,category,address,website,phone,latitude,longitude,descriptions,owner,type,openHours,bankCode,logo,reviewRating,distance);

@override
String toString() {
  return 'Location(id: $id, link: $link, title: $title, category: $category, address: $address, website: $website, phone: $phone, latitude: $latitude, longitude: $longitude, descriptions: $descriptions, owner: $owner, type: $type, openHours: $openHours, bankCode: $bankCode, logo: $logo, reviewRating: $reviewRating, distance: $distance)';
}


}

/// @nodoc
abstract mixin class _$LocationCopyWith<$Res> implements $LocationCopyWith<$Res> {
  factory _$LocationCopyWith(_Location value, $Res Function(_Location) _then) = __$LocationCopyWithImpl;
@override @useResult
$Res call({
 int id, String? link, String? title, String? category, String? address, String? website, String? phone, double? latitude, double? longitude, String? descriptions, String? owner, String? type, String? openHours, String? bankCode, String? logo, double? reviewRating, double? distance
});




}
/// @nodoc
class __$LocationCopyWithImpl<$Res>
    implements _$LocationCopyWith<$Res> {
  __$LocationCopyWithImpl(this._self, this._then);

  final _Location _self;
  final $Res Function(_Location) _then;

/// Create a copy of Location
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? link = freezed,Object? title = freezed,Object? category = freezed,Object? address = freezed,Object? website = freezed,Object? phone = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? descriptions = freezed,Object? owner = freezed,Object? type = freezed,Object? openHours = freezed,Object? bankCode = freezed,Object? logo = freezed,Object? reviewRating = freezed,Object? distance = freezed,}) {
  return _then(_Location(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,descriptions: freezed == descriptions ? _self.descriptions : descriptions // ignore: cast_nullable_to_non_nullable
as String?,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,openHours: freezed == openHours ? _self.openHours : openHours // ignore: cast_nullable_to_non_nullable
as String?,bankCode: freezed == bankCode ? _self.bankCode : bankCode // ignore: cast_nullable_to_non_nullable
as String?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,reviewRating: freezed == reviewRating ? _self.reviewRating : reviewRating // ignore: cast_nullable_to_non_nullable
as double?,distance: freezed == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
