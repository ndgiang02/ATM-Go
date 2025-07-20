import 'package:atmgo/core/network/api_client.dart';
import 'package:atmgo/data/models/location/location.dart';

class LocationApiService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Location>> getLocationNearest(double lat, double lng) async {
    final response = await _apiClient.get(
      'location/get-nearest-locations',
      queryParams: {'latitude': lat, 'longitude': lng},
    );

    final List data = response.data;
    return data.map((json) => Location.fromJson(json)).toList();
  }

  Future<List<Location>> getLocationByBankType(
    String bankCode,
    String type,
  ) async {
    final response = await _apiClient.get(
      'location/get-by-bank-and-type',
      queryParams: {'bank_code': bankCode, 'type': type},
    );

    final List data = response.data;
    return data.map((json) => Location.fromJson(json)).toList();
  }
}
