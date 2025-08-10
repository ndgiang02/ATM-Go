import 'package:freezed_annotation/freezed_annotation.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@freezed
abstract class Location with _$Location {
  const factory Location({
    required int id,
    String? link,
    String? title,
    String? category,
    String? address,
    String? website,
    String? phone,
    double? latitude,
    double? longitude,
    String? descriptions,
    String? owner,
    String? type,
    String? openHours,
    String? bankCode,
    String? logo,
    double? review_rating,
    double? distance,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
