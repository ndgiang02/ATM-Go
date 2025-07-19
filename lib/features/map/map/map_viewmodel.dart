import 'dart:async';
import 'dart:developer';

import 'package:atmgo/core/response/api_response.dart';
import 'package:atmgo/core/utils/ultils.dart';
import 'package:atmgo/data/models/bank/bank.dart';
import 'package:atmgo/data/models/location/location.dart';
import 'package:atmgo/data/repositories/bank_repositories_impl.dart';
import 'package:atmgo/data/repositories/location_repositories_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapViewModel extends ChangeNotifier {
  MapViewModel(this._locationRepository, this._bankRepository);

  final LocationRepositoryImpl _locationRepository;
  final BankRepositoryImpl _bankRepository;

  MapboxMap? _mapboxMap;
  PointAnnotationManager? _annotationManager;

  bool isTracking = false;

  ApiResponse<List<Bank>> banksResponse = ApiResponse.loading();
  ApiResponse<List<Location>> locationsResponse = ApiResponse.loading();

  static const double minZoom = 5.0;
  static const double maxZoom = 18.0;

  String selectedBank = 'all';
  String selectedServiceType = 'all';

  void onBankSelected(String? value) {
    if (value == null) return;
    selectedBank = value;
    notifyListeners();
  }

  void onServiceTypeSelected(String? value) {
    if (value == null) return;
    selectedServiceType = value;
    notifyListeners();
  }

  void resetFilters() {
    selectedBank = 'all';
    selectedServiceType = 'all';
    notifyListeners();
  }

  void _setBanksResponse(ApiResponse<List<Bank>> response) {
    banksResponse = response;
    notifyListeners();
  }

  void _setLocationsResponse(ApiResponse<List<Location>> response) {
    locationsResponse = response;
    notifyListeners();
  }

  void setMap(MapboxMap map) async {
    _mapboxMap = map;

    _mapboxMap?.location.updateSettings(
      LocationComponentSettings(enabled: true),
    );

    final position = await geo.Geolocator.getCurrentPosition();

    double initialZoom = 14.0;
    if (initialZoom < minZoom) {
      initialZoom = minZoom;
    } else if (initialZoom > maxZoom) {
      initialZoom = maxZoom;
    }

    _mapboxMap?.setCamera(
      CameraOptions(
        center: Point(
          coordinates: Position(position.longitude, position.latitude),
        ),
        zoom: initialZoom,
      ),
    );

    _annotationManager =
        await _mapboxMap?.annotations.createPointAnnotationManager();
  }

  Future<void> zoomIn() async {
    if (_mapboxMap == null) return;

    final camera = await _mapboxMap!.getCameraState();
    double newZoom = camera.zoom + 1;
    if (newZoom > maxZoom) newZoom = maxZoom;

    await _mapboxMap!.setCamera(CameraOptions(zoom: newZoom));
  }

  Future<void> zoomOut() async {
    if (_mapboxMap == null) return;

    final camera = await _mapboxMap!.getCameraState();
    double newZoom = camera.zoom - 1;
    if (newZoom < minZoom) newZoom = minZoom;

    await _mapboxMap!.setCamera(CameraOptions(zoom: newZoom));
  }

  Future<void> getCurrentLocation() async {
    final hasPermission = await Utils.checkLocatorPermission();
    if (!hasPermission) {
      return;
    }

    final position = await geo.Geolocator.getCurrentPosition();
    _mapboxMap?.setCamera(
      CameraOptions(
        center: Point(
          coordinates: Position(position.longitude, position.latitude),
        ),
        zoom: 14,
      ),
    );
  }

  Future<void> addMarker({
    required double lng,
    required double lat,
    required String markerId,
    required BuildContext context,
  }) async {
    try {
      final imageBytes = await rootBundle.load('assets/icons/marker-icon.png');
      final imageUint8List = imageBytes.buffer.asUint8List();
      final mbxImage = MbxImage(width: 48, height: 48, data: imageUint8List);

      await _mapboxMap!.style.addStyleImage(
        markerId,
        1.0,
        mbxImage,
        false,
        [],
        [],
        null,
      );

      final annotationOptions = PointAnnotationOptions(
        geometry: Point(coordinates: Position(lng, lat)),
        iconImage: markerId,
        iconSize: 0.5,
      );

      await _annotationManager!.create(annotationOptions);
    } catch (e) {
      log("Error: $e");
    }
  }

  Future<void> mapMarker({
    required double lat,
    required double lng,
    String? title,
    String? logoUrl,
    BuildContext? context,
  }) async {
    if (logoUrl != null) {
      await addMarker(
        lat: lat,
        lng: lng,
        markerId: 'marker_${lat}_$lng',
        context: context!,
      );
    }
  }

  Future<void> fetchMarkersFromApi(BuildContext context) async {
    _setLocationsResponse(ApiResponse.loading());
    try {
      final position = await geo.Geolocator.getCurrentPosition();
      final locations = await _locationRepository.getLocationNearest(
        position.latitude,
        position.longitude,
      );
      _setLocationsResponse(ApiResponse.completed(locations));

      for (final marker in locations) {
        await mapMarker(
          lat: marker.latitude!,
          lng: marker.longitude!,
          title: marker.title,
          logoUrl: marker.logo,
          context: context,
        );
      }
    } catch (e) {
      log("Failed to fetch markers: $e");
      _setLocationsResponse(ApiResponse.error('Không thể tải địa điểm'));
    }
  }

  Future<void> getAllBanks() async {
    _setBanksResponse(ApiResponse.loading());
    try {
      final banks = await _bankRepository.getAllBanks();
      _setBanksResponse(ApiResponse.completed(banks));
    } catch (e) {
      log("Failed to load banks: $e");
      _setBanksResponse(ApiResponse.error('Không thể tải danh sách ngân hàng'));
    }
  }

  void toggleTracking(bool value) {
    isTracking = value;
    notifyListeners();
  }
}
