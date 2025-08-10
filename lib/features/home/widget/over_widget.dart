import 'package:atmgo/core/common/asset/app_assets.dart';
import 'package:atmgo/core/common/widget/glass_widget.dart';
import 'package:flutter/material.dart';

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({
    super.key,
    required this.totalBranches,
    required this.totalATMs,
    required this.totalCDMs,
  });

  final int totalBranches;
  final int totalATMs;
  final int totalCDMs;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: _buildItem(
              'Chi nhánh',
              totalBranches,
              AppAssets.iconBranch,
              Colors.lightBlueAccent.shade200,
            ),
          ),
          Expanded(
            child: _buildItem(
              'ATM',
              totalATMs,
              AppAssets.iconATM,
              Colors.greenAccent.shade200,
            ),
          ),
          Expanded(
            child: _buildItem(
              'CDM',
              totalCDMs,
              AppAssets.iconCDM,
              Colors.orangeAccent.shade200,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String label, int count, String icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Image.asset(icon, width: 20, height: 20, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.9),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
