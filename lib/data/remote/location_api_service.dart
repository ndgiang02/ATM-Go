import 'package:atmgo/core/network/api_client.dart';
import 'package:atmgo/data/models/location/location.dart';

class LocationApiService {
  final ApiClient _apiClient = ApiClient();

  Future<List<Location>> getLocationNearest(double lat, double lng) async {
    final response = await _apiClient.get(
      'location/get_nearest_locations',
      queryParams: {'latitude': lat, 'longitude': lng},
    );

    final List data = response.data;
    return data.map((json) => Location.fromJson(json)).toList();
  }
}
