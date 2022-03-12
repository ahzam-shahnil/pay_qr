// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

// Project imports:
import 'package:pay_qr/config/firebase.dart';
import '../config/app_constants.dart';
import '../config/app_exceptions.dart';

Future<String?> uploadImage(
    {required File imageFile, Map<String, String>? metaData}) async {
  try {
    final String fileName = path.basename(imageFile.path);
    logger.i(fileName);
    String? imgUrl;

    try {
      // Uploading the selected image with some custom meta data
      var taskSnapshot = await storage
          .ref(fileName)
          .putFile(imageFile, SettableMetadata(customMetadata: metaData));

      imgUrl = await taskSnapshot.ref.getDownloadURL();
      logger.i("Done: $imgUrl");
      // Refresh the UI
      return imgUrl;
      // setState(() {});
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
  } on TimeoutException {
    throw ApiNotRespondingException(
      'API not responded in time',
    );
  } catch (err) {
    if (kDebugMode) {
      print(err);
    }
  }
  return null;
}
