// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/firebase.dart';
import 'package:pay_qr/controller/cart_controller.dart';
import 'package:pay_qr/controller/digi_khata/digi_controller.dart';
import 'package:pay_qr/controller/product_controller.dart';
import 'package:pay_qr/controller/profile_controller.dart';
import 'package:pay_qr/controller/sign_up_controller.dart';
import 'package:pay_qr/controller/user_controller.dart';
import 'controller/login_controller.dart';
import 'controller/payment/payments_controller.dart';
import 'controller/product_add_controller.dart';
import 'view/intro_views/splash.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  await initialization.then((value) {
    Get.put(UserController());
    Get.put(LoginController());
    Get.put(ProductController());
    Get.put(CartController());
    Get.put(SignUpController());
    Get.put(ProfileController());
    Get.put(ProductAddController());
    Get.put(PaymentsController());
    Get.put(DigiController());
  });

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

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
        iconTheme: const IconThemeData(color: kScanBackColor),
        textTheme: const TextTheme(
          headline6: TextStyle(color: Colors.white),
          headline5: TextStyle(color: Colors.white),
          headline4: TextStyle(color: Colors.white),
          headline3: TextStyle(color: Colors.white),
          headline2: TextStyle(color: Colors.white),
          headline1: TextStyle(color: Colors.white),
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
          iconTheme: const IconThemeData(color: kScanBackColor),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
        ),
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
            .copyWith(secondary: Colors.deepPurpleAccent),
      ),
      home: const SplashScreen(),
    );
  }
}
