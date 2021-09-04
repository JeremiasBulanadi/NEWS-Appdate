import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:typed_data';
import 'dart:ui' as ui;

class MarkerIcon {
  Future<Uint8List> getMakerIconFromAssets(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
    targetWidth: width);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
  Future<Uint8List> getBytesFromCanvas(int width, int height) async{
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    final Paint paint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(width / 2, height / 2), 20, paint);
    paint.color = Colors.greenAccent;
    canvas.drawCircle(Offset(width / 2, height / 2), 15, paint);

    final img = await pictureRecorder.endRecording().toImage(width, height);
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }

}