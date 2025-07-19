import 'package:atmgo/core/common/asset/app_assets.dart';
import 'package:atmgo/core/constant/constants.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  const Item({
    super.key,
    required this.name,
    this.logoUrl,
    this.isSelected = false,
  });
  final String name;
  final String? logoUrl;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (logoUrl != null && logoUrl!.isNotEmpty)
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(
              '${AppConstants.BASE_URL}${logoUrl!}',
              width: 24,
              height: 24,
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) => Image.asset(
                    AppAssets.imgBank,
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
            ),
          )
        else
          Image.asset(
            AppAssets.imgBank,
            width: 24,
            height: 24,
            fit: BoxFit.cover,
          ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.black : Colors.grey.shade800,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
