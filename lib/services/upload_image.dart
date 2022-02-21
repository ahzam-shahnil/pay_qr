import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as path;

import '../config/app_exceptions.dart';

Logger log = Logger();
FirebaseStorage storage = FirebaseStorage.instance;
Future<String?> uploadImage(
    {required File imageFile, Map<String, String>? metaData}) async {
  try {
    final String fileName = path.basename(imageFile.path);
    log.i(fileName);
    String? imgUrl;

    try {
      // Uploading the selected image with some custom meta data
      var taskSnapshot = await storage
          .ref(fileName)
          .putFile(imageFile, SettableMetadata(customMetadata: metaData));
      //     .then((taskSnapshot) {
      //   taskSnapshot.ref.getDownloadURL().then(
      //     (value) {
      //       log.i("Done: $value");
      //       imgUrl = value;
      //     },
      //   );
      // });

      imgUrl = await taskSnapshot.ref.getDownloadURL();
      log.i("Done: $imgUrl");
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
