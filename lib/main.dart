// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/constants.dart';
import 'package:pay_qr/controller/login_controller.dart';

// Project imports:
import 'package:pay_qr/controller/product_controller.dart';
import 'package:pay_qr/controller/profile_controller.dart';
import 'package:pay_qr/controller/sign_up_controller.dart';
import 'package:pay_qr/view/login_screen.dart';
import 'package:pay_qr/view/nav_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //? use api controler here
  Get.lazyPut(
    () => LoginController(),
  );
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  //? use api controler here
  final controller = Get.lazyPut(() => ProductController(), fenix: true);

  // final accountTypeController =
  final signUpController = Get.lazyPut(() => SignUpController(), fenix: true);
  final profileController = Get.lazyPut(() => ProfileController(), fenix: true);

  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kPrimaryColor,
        scrollbarTheme: ScrollbarThemeData(
          interactive: true,
          thumbColor: MaterialStateProperty.all(Colors.deepPurple),
          radius: const Radius.circular(60),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: kPrimaryDarkColor,
              elevation: 1,
              textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                  fontSize: Get.textTheme.bodyMedium?.fontSize),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              )),
        ),
        useMaterial3: true,
        // textTheme: GoogleFonts.lato(),
        appBarTheme: AppBarTheme(
          color: Colors.deepPurple.withOpacity(0.5),
          // color: kPrimaryColor,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
        ),
        fontFamily: 'Nunito',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
            .copyWith(secondary: Colors.deepPurpleAccent),
      ),
      home: Obx(() => loginController.isLoggedIn.value == true
          ? const TabPage()
          : const LoginScreen()),
    );
  }
}
