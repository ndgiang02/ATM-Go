import 'package:atmgo/data/models/location/location.dart';
import 'package:atmgo/di/locator.dart';
import 'package:atmgo/features/map/map_viewmodel/map_viewmodel.dart';
import 'package:atmgo/features/map/widget/bottomsheet_widget.dart';
import 'package:atmgo/features/map/widget/filter_widget.dart';
import 'package:atmgo/features/map/widget/location_widget.dart';
import 'package:atmgo/features/map/widget/zoom_widget.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  void _showLocationDetailBottomSheet(Location location) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.25,
        minChildSize: 0.1,
        maxChildSize: 0.3,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            controller: controller,
            child: LocationDetailSheet(detail: location),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final vm = locator<MapViewModel>();
        vm.onMarkerTapped = (location) {
          _showLocationDetailBottomSheet(location);
        };
        return vm;
      },
      child: Consumer<MapViewModel>(
        builder: (context, viewModel, _) {
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
                      zoom: 13.0,
                    ),
                    styleUri: MapboxStyles.STANDARD,
                    textureView: true,
                    onMapCreated: viewModel.setMap,
                    onMapLoadedListener: (_) {
                      viewModel.getLocationInit();
                      viewModel.getAllBanks();
                    },
                  ),
                ),

                // Bộ lọc dropdown
                Positioned(
                  top: 60,
                  left: 16,
                  right: 16,
                  child: FilterBar(viewModel: viewModel),
                ),

                // Nút zoom và vị trí
                Positioned(
                  bottom: 100,
                  right: 10,
                  child: Column(
                    children: [
                      ZoomButton(
                        onZoomIn: viewModel.zoomIn,
                        onZoomOut: viewModel.zoomOut,
                      ),
                      const SizedBox(height: 10),
                      LocationButton(onPressed: viewModel.getCurrentLocation),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}