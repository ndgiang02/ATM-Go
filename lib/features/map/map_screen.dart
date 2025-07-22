import 'package:atmgo/core/common/widget/widget_loading.dart';
import 'package:atmgo/core/response/status.dart';
import 'package:atmgo/core/utils/ultils.dart';
import 'package:atmgo/data/models/location/location.dart';
import 'package:atmgo/di/locator.dart';
import 'package:atmgo/features/map/map_viewmodel/map_viewmodel.dart';
import 'package:atmgo/features/map/widget/bottomsheet_widget.dart';
import 'package:atmgo/features/map/widget/dropdown_widget.dart';
import 'package:atmgo/features/map/widget/item_widget.dart';
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
  late MapViewModel _viewModel;

  @override
  void initState() {
    super.initState();
  }

  void _showLocationDetailBottomSheet(Location location) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.25,
            minChildSize: 0.1,
            maxChildSize: 0.3,
            builder:
                (_, controller) => Container(
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
        locator<MapViewModel>();
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

                Positioned(
                  top: 60,
                  left: 16,
                  right: 16,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Builder(
                              builder: (context) {
                                List<DropdownMenuItem<String>> dropdownItems =
                                    [];

                                if (viewModel.banksResponse.status ==
                                    Status.LOADING) {
                                  dropdownItems = const [
                                    DropdownMenuItem<String>(
                                      value: null,
                                      child: LoadingWidget(),
                                    ),
                                  ];
                                } else if (viewModel.banksResponse.status ==
                                    Status.ERROR) {
                                  dropdownItems = [
                                    DropdownMenuItem<String>(
                                      value: null,
                                      child: Text(
                                        viewModel.banksResponse.message ??
                                            'Lỗi tải ngân hàng',
                                        style: const TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ];
                                } else if (viewModel.banksResponse.status ==
                                    Status.COMPLETED) {
                                  final banks = viewModel.banksResponse.data!;
                                  dropdownItems = [
                                    const DropdownMenuItem<String>(
                                      value: 'all',
                                      child: Text('Tất cả ngân hàng'),
                                    ),
                                    ...banks.map((bank) {
                                      return DropdownMenuItem<String>(
                                        value: bank.code,
                                        child: Item(
                                          name: bank.name,
                                          logoUrl: bank.logo_url,
                                        ),
                                      );
                                    }),
                                  ];
                                }

                                return CustomDropdown<String>(
                                  value: viewModel.selectedBank,
                                  hint: 'Chọn ngân hàng',
                                  items: dropdownItems,
                                  onChanged:
                                      viewModel.banksResponse.status ==
                                              Status.COMPLETED
                                          ? viewModel.onBankSelected
                                          : null,
                                );
                              },
                            ),
                          ),

                          const SizedBox(width: 8),

                          Expanded(
                            child: CustomDropdown<String>(
                              value: viewModel.selectedServiceType,
                              hint: 'Loại dịch vụ',
                              items:
                                  Utils.serviceTypes.map((serviceType) {
                                    return DropdownMenuItem<String>(
                                      value: serviceType['id'],
                                      child: Text(serviceType['title'] ?? ''),
                                    );
                                  }).toList(),
                              onChanged: viewModel.onServiceTypeSelected,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      if (viewModel.selectedBank != 'all' &&
                          viewModel.selectedServiceType != 'all')
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton.icon(
                            onPressed: viewModel.resetFilters,
                            icon: const Icon(Icons.clear, size: 16),
                            label: const Text('Đặt lại'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

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
