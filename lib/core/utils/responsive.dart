import 'package:flutter/material.dart';

class Responsive {
  static double width(double size, BuildContext context) {
    return MediaQuery.of(context).size.width * (size / 100);
  }

  static double height(double size, BuildContext context) {
    return MediaQuery.of(context).size.height * (size / 100);
  }

  static double fontSize(double size, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return size * (screenWidth / 375);
  }
}
