import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class MarkerClickListener implements OnPointAnnotationClickListener {
  MarkerClickListener({required this.onClick});
  final Function(PointAnnotation) onClick;

  @override
  void onPointAnnotationClick(PointAnnotation annotation) {
    onClick(annotation);
  }
}
