// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Location _$LocationFromJson(Map<String, dynamic> json) => _Location(
  id: (json['id'] as num).toInt(),
  link: json['link'] as String?,
  title: json['title'] as String?,
  category: json['category'] as String?,
  address: json['address'] as String?,
  website: json['website'] as String?,
  phone: json['phone'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  descriptions: json['descriptions'] as String?,
  owner: json['owner'] as String?,
  type: json['type'] as String?,
  openHours: json['openHours'] as String?,
  bankCode: json['bankCode'] as String?,
  logo: json['logo'] as String?,
  reviewRating: (json['reviewRating'] as num?)?.toDouble(),
  distance: (json['distance'] as num?)?.toDouble(),
);

Map<String, dynamic> _$LocationToJson(_Location instance) => <String, dynamic>{
  'id': instance.id,
  'link': instance.link,
  'title': instance.title,
  'category': instance.category,
  'address': instance.address,
  'website': instance.website,
  'phone': instance.phone,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'descriptions': instance.descriptions,
  'owner': instance.owner,
  'type': instance.type,
  'openHours': instance.openHours,
  'bankCode': instance.bankCode,
  'logo': instance.logo,
  'reviewRating': instance.reviewRating,
  'distance': instance.distance,
};
