import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:atmgo/core/constant/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<Uint8List> createCustomMarker(String url, double size) async {
  final dio = Dio();
  final response = await dio.get<List<int>>(
    '${AppConstants.BASE_URL}$url',
    options: Options(responseType: ResponseType.bytes),
  );

  final codec = await ui.instantiateImageCodec(
    Uint8List.fromList(response.data!),
    targetWidth: (size * 0.8).toInt(),
    targetHeight: (size * 0.8).toInt(),
  );
  final frame = await codec.getNextFrame();
  final image = frame.image;

  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);

  final width = size;
  final height = size * 1.4;

  final circleCenter = Offset(width / 2, size / 2);
  final circleRadius = size * 0.5;

  final stickWidth = size * 0.08;
  final stickHeight = height - size;
  final stickRect = Rect.fromCenter(
    center: Offset(width / 2, size + stickHeight / 2),
    width: stickWidth,
    height: stickHeight,
  );

  canvas.drawRRect(
    RRect.fromRectAndRadius(stickRect, Radius.circular(stickWidth / 2)),
    Paint()..color = const Color(0xFF4285F4),
  );

  canvas.drawCircle(
    circleCenter,
    circleRadius,
    Paint()..color = const Color(0xFF4285F4),
  );

  canvas.drawCircle(
    circleCenter,
    circleRadius,
    Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3,
  );

  final logoRadius = circleRadius * 0.75;
  final imageRect = Rect.fromCenter(
    center: circleCenter,
    width: logoRadius * 2,
    height: logoRadius * 2,
  );

  canvas.save();
  canvas.clipPath(Path()..addOval(imageRect));
  canvas.drawImageRect(
    image,
    Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
    imageRect,
    Paint(),
  );
  canvas.restore();

  final picture = recorder.endRecording();
  final finalImage = await picture.toImage(width.toInt(), height.toInt());
  final byteData = await finalImage.toByteData(format: ui.ImageByteFormat.png);
  return byteData!.buffer.asUint8List();
}
