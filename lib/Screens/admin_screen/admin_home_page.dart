// // Flutter imports:
// import 'package:flutter/material.dart';

// // Package imports:
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';

// // Project imports:
// import 'package:pay_qr/Screens/admin_screen/admin_retailer.dart';
// import 'package:pay_qr/Screens/login_screen/login_page.dart';

// import 'admin_user.dart';

// // Project imports:
// //statefulwidget can be change
// class AdminHomePage extends StatefulWidget {
//   static String id = 'admin_home_page';

//   const AdminHomePage({Key? key}) : super(key: key);

//   @override
//   _AdminHomePageState createState() => _AdminHomePageState();
// }

// class _AdminHomePageState extends State<AdminHomePage> {
// //main method of a screen
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Admin Home'),
//         centerTitle: true,
//         elevation: 2.0,

//         // shadowColor: kActiveBtnColor,
//         actions: [
//           IconButton(
//             onPressed: () {
//               _logoutUser(context);
//             },
//             icon: const Icon(
//               Icons.logout,
//               color: Colors.white,
//             ),
//             iconSize: 25,
//           )
//         ],
//       ),
//       //widgets in form of list
//       body: ListView(
//         children: [
//           const SizedBox(
//             height: 100,
//           ),
//           //elevatedbutton
//           ElevatedButton(
//               onPressed: () {
//                 Get.to(() => const AdminRetailer());
//               },
//               child: const Text('Manage Retailers')),
//           ElevatedButton(
//               onPressed: () {
//                 Get.to(() => const AdminUser());
//               },
//               child: const Text('Manage Customers')),
//         ],
//       ),
//     );
//   }
// }

// _logoutUser(BuildContext context) async {
//   showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (ctx) {
//         return AlertDialog(
//           title: const Text('Confirmation !!!'),
//           content: const Text('Are you sure to Log Out ? '),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 //navigator ek screens e dusri screen p le k jai ga
//                 Navigator.of(ctx).pop();
//               },
//               child: const Text('No'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Get.to(() => const LoginPage());

//                 FirebaseAuth.instance.signOut();

//                 Navigator.of(context)
//                     .pushReplacement(MaterialPageRoute(builder: (context) {
//                   return const LoginPage();
//                 }));
//               },
//               child: const Text('Yes'),
//             ),
//           ],
//         );
//       });
// }
