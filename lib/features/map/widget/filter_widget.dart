import 'package:atmgo/core/common/widget/widget_loading.dart';
import 'package:atmgo/core/response/status.dart';
import 'package:atmgo/core/utils/ultils.dart';
import 'package:atmgo/features/map/map_viewmodel/map_viewmodel.dart';
import 'package:atmgo/features/map/widget/dropdown_widget.dart';
import 'package:atmgo/features/map/widget/item_widget.dart';
import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key, required this.viewModel});
  final MapViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> dropdownItems = [];

    switch (viewModel.banksResponse.status) {
      case Status.LOADING:
        dropdownItems = const [
          DropdownMenuItem<String>(
            value: null,
            child: LoadingWidget(),
          ),
        ];
        break;
      case Status.ERROR:
        dropdownItems = [
          DropdownMenuItem<String>(
            value: null,
            child: Text(
              viewModel.banksResponse.message ?? 'Lỗi tải ngân hàng',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ];
        break;
      case Status.COMPLETED:
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
        break;
      default:
        dropdownItems = [];
    }

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomDropdown<String>(
                value: viewModel.selectedBank,
                hint: 'Chọn ngân hàng',
                items: dropdownItems,
                onChanged: viewModel.banksResponse.status == Status.COMPLETED
                    ? viewModel.onBankSelected
                    : null,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomDropdown<String>(
                value: viewModel.selectedServiceType,
                hint: 'Loại dịch vụ',
                items: Utils.serviceTypes.map((serviceType) {
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
    );
  }
}
