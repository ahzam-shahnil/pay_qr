// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/controller/qr_controller.dart';
import 'package:pay_qr/view/demo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(App());
}

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  //? use api controler here
  final searchController = Get.lazyPut(() => QrController(), fenix: true);

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
            .copyWith(secondary: Colors.deepOrange),
      ),
      home: const DemoScreen(),
    );
  }
}
