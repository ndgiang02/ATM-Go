import 'package:atmgo/core/common/asset/app_assets.dart';
import 'package:atmgo/core/constant/constants.dart';
import 'package:flutter/material.dart';

class BankItem extends StatelessWidget {
  const BankItem({super.key, this.logo, this.name, this.logoSize = 40});
  final String? logo;

  final String? name;

  final double logoSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
      ),
      child: Row(
        children: [
          ClipOval(
            child:
                (logo != null && logo!.isNotEmpty)
                    ? Image.network(
                      '${AppConstants.BASE_URL}$logo',
                      width: logoSize,
                      height: logoSize,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          AppAssets.imgBank,
                          width: logoSize,
                          height: logoSize,
                          fit: BoxFit.cover,
                        );
                      },
                    )
                    : Image.asset(
                      AppAssets.imgBank,
                      width: logoSize,
                      height: logoSize,
                      fit: BoxFit.cover,
                    ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              name!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
