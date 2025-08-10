import 'package:atmgo/core/common/theme/app_color.dart';
import 'package:atmgo/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    required this.iconPath,
    this.size,
    this.color,
    required this.isActive,
  });
  final String iconPath;
  final double? size;
  final Color? color;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = true;
    Color effectiveColor =
        color ??
        (isActive
            ? AppColors.tertiary
            : (isDarkMode ? Colors.white : Colors.black));

    return SizedBox(
      width: size ?? Responsive.width(6, context),
      height: size ?? Responsive.width(6, context),
      child: Image.asset(iconPath, color: effectiveColor, fit: BoxFit.contain),
    );
  }
}
