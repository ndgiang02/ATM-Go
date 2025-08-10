import 'package:atmgo/core/common/asset/app_assets.dart';
import 'package:atmgo/core/constant/constants.dart';
import 'package:atmgo/data/models/location/location.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationDetailSheet extends StatelessWidget {
  const LocationDetailSheet({required this.detail, super.key});
  final Location detail;

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Thanh kéo
        Container(
          width: 40,
          height: 4,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(2),
          ),
        ),

        // Logo + Title + Address
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
              const Icon(Icons.location_on, size: 40, color: Colors.red),

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
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InfoItem(
              icon: AppAssets.iconClock,
              label: detail.openHours ?? 'Không rõ',
              color: Colors.orange,
            ),
            InfoItem(
              icon: AppAssets.iconRate,
              label:
                  detail.review_rating != null
                      ? '${detail.review_rating!.toStringAsFixed(1)}/5.0'
                      : 'Chưa có',
              color: Colors.yellow,
            ),
            InfoItem(
              icon: AppAssets.iconPhone,
              label: detail.phone ?? 'Không rõ',
              onTap:
                  detail.phone != null && detail.phone!.isNotEmpty
                      ? () => _launchUrl('tel:${detail.phone}')
                      : null,
              color: Colors.green,
            ),
            InfoItem(
              icon: AppAssets.iconDirection,
              label: '${detail.distance?.toStringAsFixed(1) ?? '?'} km',
              onTap:
                  detail.link != null && detail.link!.isNotEmpty
                      ? () => _launchUrl(detail.link!)
                      : null,
            ),
          ],
        ),

        const SizedBox(height: 12),

        if (detail.website != null && detail.website!.isNotEmpty)
          InkWell(
            onTap: () => _launchUrl(detail.website!),
            child: Row(
              children: [
                Image.asset(
                  AppAssets.iconWeb,
                  width: 20,
                  height: 20,
                  color: Colors.blue,
                ),
                const SizedBox(width: 6),
                Text(
                  detail.website!,
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ],
            ),
          ),

        const SizedBox(height: 12),
      ],
    );
  }
}

class InfoItem extends StatelessWidget {
  const InfoItem({
    super.key,
    required this.icon,
    required this.label,
    this.color,
    this.onTap,
  });
  final String icon;
  final String label;
  final VoidCallback? onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(icon, width: 20, height: 20, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );

    return Expanded(child: InkWell(onTap: onTap, child: content));
  }
}
