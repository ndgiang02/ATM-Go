import 'package:freezed_annotation/freezed_annotation.dart';

part 'locationc.freezed.dart';
part 'locationc.g.dart';

@freezed
abstract class LocationCount with _$LocationCount {
  const factory LocationCount({
    @Default(0) int branch,
    @Default(0) int atm,
    @Default(0) int cdm,
  }) = _LocationCount;

  factory LocationCount.fromJson(Map<String, dynamic> json) =>
      _$LocationCountFromJson(json);
}
