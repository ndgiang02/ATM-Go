import 'package:flutter/material.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: const Center(child: Icon(Icons.my_location, size: 18)),
        ),
      ),
    );
  }
}
