import 'package:atmgo/core/response/api_response.dart';
import 'package:atmgo/data/models/location/location.dart';
import 'package:atmgo/data/repositories/location_repositories_impl.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;

class HomeViewModel extends ChangeNotifier {
  HomeViewModel(this._locationRepository);
  final LocationRepositoryImpl _locationRepository;

  ApiResponse<List<Location>> locationsResponse = ApiResponse.loading();

  void _setLocationsResponse(ApiResponse<List<Location>> response) {
    locationsResponse = response;
    notifyListeners();
  }

  Future<void> getLocationNearest() async {
    final position = await geo.Geolocator.getCurrentPosition();

    _setLocationsResponse(ApiResponse.loading());

    try {
      final locations = await _locationRepository.getLocationNearest(
        position.latitude,
        position.longitude,
      );
      _setLocationsResponse(ApiResponse.completed(locations));
    } catch (e) {
      _setLocationsResponse(ApiResponse.error('Không thể tải danh sách'));
    }
  }
}
