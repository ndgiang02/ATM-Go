import 'package:atmgo/core/common/theme/app_color.dart';
import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  const GradientWidget({
    super.key,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  });
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.tertiary],
          begin: begin,
          end: end,
        ),
      ),
    );
  }
}
