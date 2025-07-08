import 'package:atmgo/core/common/widget/toggle_button.dart';
import 'package:atmgo/features/map/widget/locaton_button.dart';
import 'package:atmgo/features/map/widget/zoom_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMap? _mapboxMap;
  final geo.GeolocatorPlatform _geolocatorPlatform =
      geo.GeolocatorPlatform.instance;

  bool isEnabled = false;
  void _onMapCreated(MapboxMap mapboxMap) {
    _mapboxMap = mapboxMap;
  }

  Future<void> _zoomIn() async {
    final camera = await _mapboxMap?.getCameraState();
    if (camera != null) {
      _mapboxMap?.setCamera(CameraOptions(zoom: camera.zoom + 1));
    }
  }

  Future<void> _zoomOut() async {
    final camera = await _mapboxMap?.getCameraState();
    if (camera != null) {
      _mapboxMap?.setCamera(CameraOptions(zoom: camera.zoom - 1));
    }
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final currentGeoPosition = await _geolocatorPlatform.getCurrentPosition();
    _mapboxMap?.setCamera(
      CameraOptions(
        center: Point(
          coordinates: Position(
            currentGeoPosition.longitude,
            currentGeoPosition.latitude,
          ),
        ),
        zoom: 14.0,
      ),
    );
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    geo.LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == geo.LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == geo.LocationPermission.denied) {
        return false;
      }
    }

    if (permission == geo.LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: MapWidget(
              key: const ValueKey("mapWidget"),
              mapOptions: MapOptions(
                pixelRatio: MediaQuery.of(context).devicePixelRatio,
              ),
              cameraOptions: CameraOptions(
                center: Point(coordinates: Position(105.8542, 21.0285)),
                bearing: 0.0,
                zoom: 13.0,
                pitch: 0.0,
              ),
              styleUri: MapboxStyles.STANDARD,
              textureView: true,
              onMapCreated: _onMapCreated,
            ),
          ),
          Positioned(
            bottom: 100,
            right: 10,
            child: Column(
              children: [
                ZoomButton(onZoomIn: _zoomIn, onZoomOut: _zoomOut),
                const SizedBox(height: 10),
                LocationButton(onPressed: _getCurrentPosition),
              ],
            ),
          ),

          Positioned(
            bottom: 100,
            right: 10,
            child: ToggleButton(
              value: isEnabled,
              onChanged: (val) {
                setState(() {
                  isEnabled = val;
                });
              },
              activeColor: Colors.green,
              inactiveColor: Colors.grey[300]!,
            ),
          ),
        ],
      ),
    );
  }
}
