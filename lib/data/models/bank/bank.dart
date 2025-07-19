import 'package:freezed_annotation/freezed_annotation.dart';

part 'bank.freezed.dart';
part 'bank.g.dart';

@freezed
abstract class Bank with _$Bank {
  const factory Bank({
    required int id,
    required String name,
    String? code,
    String? logo_url,
    double? distance,
  }) = _Bank;

  factory Bank.fromJson(Map<String, dynamic> json) => _$BankFromJson(json);
}
