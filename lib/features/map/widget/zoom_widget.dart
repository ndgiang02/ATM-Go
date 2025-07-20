import 'package:flutter/material.dart';

class ZoomButton extends StatelessWidget {
  const ZoomButton({
    super.key,
    required this.onZoomIn,
    required this.onZoomOut,
  });

  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: Container(
        width: 40,
        height: 80,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: onZoomIn,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: const Center(child: Icon(Icons.add, size: 18)),
              ),
            ),
            Container(height: 1, color: Colors.grey.shade300),
            Expanded(
              child: InkWell(
                onTap: onZoomOut,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: const Center(child: Icon(Icons.remove, size: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
