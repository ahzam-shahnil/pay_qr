// // Flutter imports:
// import 'package:flutter/material.dart';

// // Package imports:
// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:get/get.dart';

// // Project imports:
// import 'package:pay_qr/config/app_constants.dart';
// import 'package:pay_qr/config/shop/controllers.dart';
// import '../main_views/auth/login_screen.dart';
// import '../main_views/home/nav_home.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   // final loginController = Get.find<LoginController>();

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSplashScreen.withScreenFunction(
//       // splash: 'images/splash.png',
//       splash: Text('PayQr', style: Get.textTheme.headline2),
//       screenFunction: () async {
//         // await loginController.checkLogin();
//         // setState(() {});

//         //TOdo: Testing Logged in via User controller
//         return userController.firebaseUser.value != null
//             ? const NavHomeScreen()
//             : const LoginScreen();
//         // return loginController.isLoggedIn.value
//         //     ? const NavHomeScreen()
//         //     : const LoginScreen();
//       },
//       backgroundColor: kPrimaryColor,
//       splashTransition: SplashTransition.fadeTransition,
//     );
//   }
// }
