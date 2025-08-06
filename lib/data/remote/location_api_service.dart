import 'package:atmgo/core/network/api_client.dart';
import 'package:atmgo/data/models/location/location.dart';
import 'package:atmgo/data/models/locationc/locationc.dart';

class LocationApiService {
  final ApiClient _apiClient = ApiClient();

  Future<LocationCount> getOverViews() async {
    final response = await _apiClient.get('/api/location/overview');

    return LocationCount.fromJson(response.data);
  }

  Future<List<Location>> getLocationNearest(double lat, double lng) async {
    final response = await _apiClient.get(
      '/api/location/get-nearest-locations',
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
      '/api/location/get-by-bank-and-type',
      queryParams: {'bank_code': bankCode, 'type': type},
    );

    final List data = response.data;
    return data.map((json) => Location.fromJson(json)).toList();
  }
}
