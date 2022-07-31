// Dart imports:
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
// Package imports:
// Project imports:
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';
import 'package:share_plus/share_plus.dart';

Future<void> captureAndShare({
  required GlobalKey globalKey,
  required String name,
}) async {
  try {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    logger.d(boundary);
    var image = await boundary.toImage(pixelRatio: 10);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    // var result = await ImageGallerySaver.saveImage(
    //   Uint8List.fromList(pngBytes),
    //   quality: 80,
    //   name: name,
    // );
    // logger.d(result);
    int rand = Random().nextInt(10000);
// Uint8List imageInUnit8List = // store unit8List image here ;
    final tempDir = await getTemporaryDirectory();
    File file =
        await File('${tempDir.path}/${name + rand.toString()}.png').create();
    file.writeAsBytesSync(pngBytes);
    await Share.shareFiles(
      [(file.path)],
      subject: 'Share $name',
      text: 'Hello, check this out',
    );
    // log.i(qrImgUrl);
  } catch (e) {
    logger.e(e.toString());
    showSnackBar(
      msg: "Error",
    );
  }
}
