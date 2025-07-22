import 'package:atmgo/core/constant/constants.dart';
import 'package:atmgo/data/models/location/location.dart';
import 'package:flutter/material.dart';

class LocationDetailSheet extends StatelessWidget {
  const LocationDetailSheet({required this.detail, super.key});
  final Location detail;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title + Logo
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (detail.logo != null && detail.logo!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    '${AppConstants.BASE_URL}${detail.logo!}',
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => const Icon(Icons.location_on),
                  ),
                )
              else
                const Icon(Icons.location_on, size: 40, color: Colors.blue),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detail.title ?? 'Không rõ',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      detail.address ?? 'Không có địa chỉ',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              const Icon(Icons.access_time, size: 16, color: Colors.red),
              const SizedBox(width: 6),
              Text(
                detail.openHours ?? 'Không rõ giờ mở cửa',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
