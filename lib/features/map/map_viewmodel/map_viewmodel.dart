import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:atmgo/core/response/api_response.dart';
import 'package:atmgo/data/models/bank/bank.dart';
import 'package:atmgo/data/models/location/location.dart';
import 'package:atmgo/data/repositories/bank_repositories_impl.dart';
import 'package:atmgo/data/repositories/location_repositories_impl.dart';
import 'package:atmgo/features/map/extension.dart';
import 'package:atmgo/features/map/listener.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapViewModel extends ChangeNotifier {
  MapViewModel(this._locationRepository, this._bankRepository);

  final LocationRepositoryImpl _locationRepository;
  final BankRepositoryImpl _bankRepository;

  MapboxMap? _mapboxMap;
  PointAnnotationManager? _annotationManager;

  ApiResponse<List<Bank>> banksResponse = ApiResponse.loading();
  ApiResponse<List<Location>> locationsResponse = ApiResponse.loading();

  static const double minZoom = 5.0;
  static const double maxZoom = 18.0;

  String selectedBank = 'all';
  String selectedServiceType = 'all';

  final Map<String, Location> _markerLocationMap = {};

  Location? _selectedLocation;
  Location? get selectedLocation => _selectedLocation;

  void Function(Location)? onMarkerTapped;

  void _setBanksResponse(ApiResponse<List<Bank>> response) {
    banksResponse = response;
    notifyListeners();
  }

  void _setLocationsResponse(ApiResponse<List<Location>> response) {
    locationsResponse = response;
    notifyListeners();
  }

  void onBankSelected(String? value) {
    if (value == null) return;
    selectedBank = value;
    if (selectedBank != 'all' && selectedServiceType != 'all') {
      getLocationByBankType(selectedBank, selectedServiceType);
    }
    notifyListeners();
  }

  void onServiceTypeSelected(String? value) {
    if (value == null) return;
    selectedServiceType = value;
    if (selectedBank != 'all' && selectedServiceType != 'all') {
      getLocationByBankType(selectedBank, selectedServiceType);
    }
    notifyListeners();
  }

  void resetFilters() async {
    selectedBank = 'all';
    selectedServiceType = 'all';
    await _annotationManager?.deleteAll();
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

    _annotationManager?.addOnPointAnnotationClickListener(
      MarkerClickListener(
        onClick: (annotation) {
          final location = _markerLocationMap[annotation.id];
          if (location != null) {
            onMarkerTapped?.call(location);
            notifyListeners();
          }
        },
      ),
    );
  }

  Future<void> zoomIn() async {
    if (_mapboxMap == null) {
      return;
    }

    final camera = await _mapboxMap!.getCameraState();
    double newZoom = camera.zoom + 1;
    if (newZoom > maxZoom) {
      newZoom = maxZoom;
    }

    await _mapboxMap!.setCamera(CameraOptions(zoom: newZoom));
  }

  Future<void> zoomOut() async {
    if (_mapboxMap == null) {
      return;
    }

    final camera = await _mapboxMap!.getCameraState();
    double newZoom = camera.zoom - 1;
    if (newZoom < minZoom) {
      newZoom = minZoom;
    }

    await _mapboxMap!.setCamera(CameraOptions(zoom: newZoom));
  }

  Future<void> getCurrentLocation() async {
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
    required Location location,
    required String markerId,
  }) async {
    try {
      final imageUint8List = await createCustomMarker(location.logo!, 96);
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
        geometry: Point(
          coordinates: Position(location.longitude!, location.latitude!),
        ),
        iconImage: markerId,
        iconSize: 0.5,
      );

      final annotation = await _annotationManager!.create(annotationOptions);
      _markerLocationMap[annotation.id] = location;
    } catch (e) {
      log("Error add Marker: $e");
    }
  }

  Future<void> mapMarker(Location location) async {
    await addMarker(
      markerId: 'marker_${location.latitude}_${location.longitude}',
      location: location,
    );
  }

  Future<void> getLocationInit() async {
    _setLocationsResponse(ApiResponse.loading());
    try {
      final position = await geo.Geolocator.getCurrentPosition();
      final locations = await _locationRepository.getLocationNearest(
        position.latitude,
        position.longitude,
      );
      _setLocationsResponse(ApiResponse.completed(locations));
      await _annotationManager?.deleteAll();

      for (final marker in locations) {
        await mapMarker(marker);
      }

      final camera = calculateCameraOptions();
      _mapboxMap?.flyTo(camera, MapAnimationOptions(duration: 1000));
    } catch (e) {
      _setLocationsResponse(ApiResponse.error('Không thể tải địa điểm'));
    }
  }

  Future<void> getAllBanks() async {
    _setBanksResponse(ApiResponse.loading());
    try {
      final banks = await _bankRepository.getAllBanks();
      _setBanksResponse(ApiResponse.completed(banks));
    } catch (e) {
      log("$e");
      _setBanksResponse(ApiResponse.error('Không thể tải danh sách ngân hàng'));
    }
  }

  Future<void> getLocationByBankType(String bankCode, String type) async {
    _setLocationsResponse(ApiResponse.loading());

    try {
      final locations = await _locationRepository.getLocationByBankType(
        bankCode,
        type,
      );
      _setLocationsResponse(ApiResponse.completed(locations));
      await _annotationManager?.deleteAll();

      for (final marker in locations) {
        await mapMarker(marker);
      }

      final camera = calculateCameraOptions();
      _mapboxMap?.flyTo(camera, MapAnimationOptions(duration: 1000));
    } catch (e) {
      _setLocationsResponse(ApiResponse.error('Không thể tải danh sách'));
    }
  }

  CameraOptions calculateCameraOptions() {
    final markers = _markerLocationMap.values.toList();

    if (markers.isEmpty) {
      return CameraOptions(
        center: Point(coordinates: Position(18.423300, -33.918861)),
        zoom: 5,
        bearing: 0,
        pitch: 0,
      );
    }

    double minLat = markers.first.latitude!;
    double maxLat = markers.first.latitude!;
    double minLng = markers.first.longitude!;
    double maxLng = markers.first.longitude!;

    for (var m in markers) {
      if (m.latitude! < minLat) minLat = m.latitude!;
      if (m.latitude! > maxLat) maxLat = m.latitude!;
      if (m.longitude! < minLng) minLng = m.longitude!;
      if (m.longitude! > maxLng) maxLng = m.longitude!;
    }

    double centerLat = (minLat + maxLat) / 2;
    double centerLng = (minLng + maxLng) / 2;

    double latSpan = (maxLat - minLat).abs();
    double lngSpan = (maxLng - minLng).abs();

    latSpan = math.max(latSpan, 0.01);
    lngSpan = math.max(lngSpan, 0.01);

    double zoom =
        (latSpan > lngSpan)
            ? (6 - math.log(latSpan) / math.log(2))
            : (6 - math.log(lngSpan) / math.log(2));

    zoom = zoom.clamp(3.0, 15.0);

    return CameraOptions(
      center: Point(coordinates: Position(centerLng, centerLat)),
      zoom: zoom,
      bearing: 0,
      pitch: 0,
    );
  }
}
