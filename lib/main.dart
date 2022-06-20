// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/firebase.dart';
import 'package:pay_qr/controller/cart_controller.dart';
import 'package:pay_qr/controller/digi_khata/amount_controller.dart';
import 'package:pay_qr/controller/digi_khata/digi_controller.dart';
import 'package:pay_qr/controller/product_controller.dart';
import 'package:pay_qr/controller/profile_controller.dart';
import 'package:pay_qr/controller/sign_up_controller.dart';
import 'package:pay_qr/controller/user_controller.dart';
import 'controller/login_controller.dart';

import 'controller/product_add_controller.dart';

import 'view/intro_views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialization.then((value) {
    Get.put(UserController());
    // Get.put(AmountController());
    Get.put(LoginController());
    Get.put(ProductController());
    Get.put(CartController());
    Get.put(SignUpController());
    Get.put(ProfileController());
    Get.put(ProductAddController());
    // Get.put(PaymentsController());
    Get.put(DigiController());
    // Get.put(CashbookController());
  });

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.leftToRightWithFade,
      theme: ThemeData(
        scaffoldBackgroundColor: kPrimaryColor,

        scrollbarTheme: ScrollbarThemeData(
          interactive: true,
          thumbColor: MaterialStateProperty.all(Colors.deepOrange),
          radius: const Radius.circular(60),
        ),
        iconTheme: const IconThemeData(color: kScanBackColor),
        textTheme: const TextTheme(
          // button: TextStyle(color: Colors.white),
          headline6: TextStyle(color: Colors.white),
          headline5: TextStyle(color: Colors.white),
          headline4: TextStyle(color: Colors.white),
          headline3: TextStyle(color: Colors.white),
          headline2: TextStyle(color: Colors.white),
          headline1: TextStyle(color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: kPrimaryColor,
            elevation: 1,
            textStyle: Get.textTheme.bodyMedium,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
              textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1,
                  fontSize: Get.textTheme.bodyMedium?.fontSize,
                  color: kPrimaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              primary: kPrimaryColor),
        ),

        useMaterial3: true,
        // textTheme: GoogleFonts.lato(),
        appBarTheme: const AppBarTheme(
          color: kPrimaryColor,
          // color: kPrimaryColor,
          foregroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          iconTheme: IconThemeData(color: kScanBackColor),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
        ),

        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange)
            .copyWith(secondary: Colors.deepOrangeAccent),
      ),
      home: const SplashScreen(),
    );
  }
}
