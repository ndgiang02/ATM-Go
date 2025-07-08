import 'package:atmgo/core/common/theme/app_color.dart';
import 'package:atmgo/core/common/theme/app_theme.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.textColor,
    this.backgroundColor,
    this.verticalPadding = 14,
    this.isEnable = true,
  });
  final String text;
  final Function() onPressed;
  final Widget? icon;
  final Color? textColor;
  final Color? backgroundColor;
  final double verticalPadding;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border:
            isEnable
                ? Border.all(color: AppColors.secondary, width: 1.5)
                : null,
      ),
      child: InkWell(
        onTap: onPressed,
        radius: 16,
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          child:
              icon != null
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon!,
                      const SizedBox(width: 8),
                      Text(
                        text,
                        style: AppTheme.title14.copyWith(color: textColor),
                      ),
                    ],
                  )
                  : Text(
                    text,
                    style: AppTheme.title14.copyWith(color: textColor),
                  ),
        ),
      ),
    );
  }
}
