import 'package:atmgo/data/models/location/location.dart';
import 'package:flutter/material.dart';

class LocationDetailSheet extends StatelessWidget {
  const LocationDetailSheet({required this.detail, super.key});
  final Location detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail.title!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text("Địa chỉ: ${detail.address}"),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
