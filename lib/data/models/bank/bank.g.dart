// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Bank _$BankFromJson(Map<String, dynamic> json) => _Bank(
  id: json['id'] as String,
  name: json['name'] as String,
  logoUrl: json['logoUrl'] as String,
  distance: (json['distance'] as num?)?.toDouble(),
);

Map<String, dynamic> _$BankToJson(_Bank instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'logoUrl': instance.logoUrl,
  'distance': instance.distance,
};
