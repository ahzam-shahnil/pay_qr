import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:logger/logger.dart';

Logger log = Logger();
Future<void> captureAndSavePng(
    {required GlobalKey globalKey, required String name}) async {
  try {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 10);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // final tempDir = await getTemporaryDirectory();
    // final file = await File('${tempDir.path}/image.png').create();
    // await file.writeAsBytes(pngBytes);
    await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes),
        quality: 100, name: name);
    // log.i(qrImgUrl);
  } catch (e) {
    log.e(e.toString());
  }
}
