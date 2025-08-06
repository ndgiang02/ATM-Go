// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locationc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LocationCount _$LocationCountFromJson(Map<String, dynamic> json) =>
    _LocationCount(
      branch: (json['branch'] as num?)?.toInt() ?? 0,
      atm: (json['atm'] as num?)?.toInt() ?? 0,
      cdm: (json['cdm'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$LocationCountToJson(_LocationCount instance) =>
    <String, dynamic>{
      'branch': instance.branch,
      'atm': instance.atm,
      'cdm': instance.cdm,
    };
