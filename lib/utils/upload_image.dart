// Dart imports:
import 'dart:async';
import 'dart:io';
import 'dart:math';

// Package imports:
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
// Project imports:
import 'package:pay_qr/config/firebase.dart';

import '../config/app_constants.dart';
import '../config/app_exceptions.dart';

// Flutter imports:

// Project imports:
Future<File?> compressFile(File imgFile, String name) async {
  // logger.d(file.absolute.path);
  var result = await FlutterImageCompress.compressWithFile(
    imgFile.absolute.path,
    minWidth: 2300,
    minHeight: 1500,
    quality: 60,
  );
  int rand = Random().nextInt(10000);
// Uint8List imageInUnit8List = // store unit8List image here ;
  final tempDir = await getTemporaryDirectory();
  File file =
      await File('${tempDir.path}/${name + rand.toString()}.png').create();
  file.writeAsBytesSync(result!);
  return file;
}

Future<String?> uploadImage(
    {required File imageFile,
    Map<String, String>? metaData,
    required String userName}) async {
  try {
    var image = await compressFile(imageFile, metaData?['name'] ?? '');
    if (image == null) {
      throw Exception;
    }

    String? imgUrl;

    try {
      // Uploading the selected image with some custom meta data
      var taskSnapshot = await storage
          .ref()
          .child('images/users/$userName/${uid.v4()}')
          .putFile(image, SettableMetadata(customMetadata: metaData));

      imgUrl = await taskSnapshot.ref.getDownloadURL();
      // Refresh the UI
      return imgUrl;
    } on FirebaseException {
      rethrow;
    }
  } on TimeoutException {
    throw ApiNotRespondingException(
      'API not responded in time',
    );
  } catch (err) {
    rethrow;
  }
}
