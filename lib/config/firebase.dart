import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pay_qr/firebase_options.dart';

final Future<FirebaseApp> initialization = Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseStorage storage = FirebaseStorage.instance;
// const storagePrefs = FlutterSecureStorage();
FirebaseAnalytics analytics = FirebaseAnalytics.instance;
