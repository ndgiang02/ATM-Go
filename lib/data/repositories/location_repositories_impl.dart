import 'package:atmgo/data/models/location/location.dart';
import 'package:atmgo/data/remote/location_api_service.dart';

class LocationRepositoryImpl {
  final LocationApiService _apiService = LocationApiService();

  Future<List<Location>> getLocationNearest(double lat, double lng) async {
    return _apiService.getLocationNearest(lat, lng);
  }

  Future<List<Location>> getLocationByBankType(
    String bankCode,
    String type,
  ) async {
    return _apiService.getLocationByBankType(bankCode, type);
  }
}
