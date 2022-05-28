// // Dart imports:
// import 'dart:io';

// // Flutter imports:
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// // Package imports:
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:get/get.dart';

// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:pay_qr/config/app_constants.dart';
// import 'package:tflite/tflite.dart';



// class Classify extends StatefulWidget {
//   const Classify({
//     Key? key,
//     required this.image,
//     this.ratio,
//     required this.isFromSelfieScreen,
//   }) : super(key: key);
//   final File image;

//   final bool isFromSelfieScreen;
//   final double? ratio;

//   @override
//   _ClassifyState createState() => _ClassifyState();
// }

// class _ClassifyState extends State<Classify> with TickerProviderStateMixin {
//   List _recognitions = [];
//   double imageQuality = 85;
//   late AnimationController _controller;

//   String blurGroup = "";
//   String sharpGroup = "";
//   String blurValue = "0";
//   String sharpValue = "0";

//   bool _isLoading = false;
//   @override
//   void dispose() {
//     _recognitions.clear();
//     _controller.dispose();
//     Tflite.close();
//     super.dispose();
//   }

//   void _setLoading(bool value) {
//     setState(() {
//       _isLoading = value;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     loadModel().then((val) {
//       _predictImage(widget.image);
//     });

//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 500),
//     );
//   }

//   loadModel() async {
//     // Tflite.close();
//     try {
//       await Tflite.loadModel(
//         model: "assets/tflite/model.tflite",
//         labels: "assets/tflite/labels.txt",
//       );
//     } on PlatformException {
//       logger.e("Failed to load the model");
//     }
//   }

//   _predictImage(File image) async {
//     _setLoading(true);

//     await _checkImageForBlur(image);

//     _setLoading(false);
//   }

//   _checkImageForBlur(File image) async {
//     var recognitions = await Tflite.runModelOnImage(
//         path: image.path, // required
//         imageMean: 0.0, // defaults to 117.0
//         imageStd: 255.0, // defaults to 1.0
//         numResults: 2, // defaults to 5
//         threshold: 0.2, // defaults to 0.1
//         asynch: true // defaults to true
//         );
//     setState(() {
//       _recognitions = recognitions ?? [];
//       // log.d(_recognitions);

//       if (_recognitions[0]['label'].toString() == "BLUR") {
//         blurGroup = "BLUR";
//         blurValue =
//             '${(_recognitions[0]["confidence"] * 100).toStringAsFixed(0)}';
//       } else {
//         blurGroup = '';
//         blurValue =
//             (100 - (_recognitions[0]["confidence"] * 100)).toStringAsFixed(0);
//       }

//       if (_recognitions[0]['label'].toString() == "SHARP") {
//         sharpGroup = "SHARP";
//         sharpValue =
//             '${(_recognitions[0]["confidence"] * 100).toStringAsFixed(0)}';
//       } else {
//         sharpGroup = "";
//         sharpValue =
//             (100 - (_recognitions[0]["confidence"] * 100)).toStringAsFixed(0);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: ModalProgressHUD(
//         inAsyncCall: _isLoading,
//         progressIndicator: const SpinKitWanderingCubes(color: kPrimaryColor),
//         child: Scaffold(backgroundColor: Colors.transparent, body: _content()),
//       ),
//     );
//   }

//   _content() {
//     _controller.reverse();

//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xFF4F2FC1),
//             Color(0xFF8A1DB4),
//           ],
//         ),
//       ),
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: Get.size.width * 0.08, vertical: 20),
//         child: ListView(
//           children: <Widget>[
//             Text(
//               'Kartenbild-Ergebnis',
//               textAlign: TextAlign.start,
//               style: TextStyle(
//                   fontWeight: FontWeight.w400,
//                   color: Colors.white,
//                   fontSize: Get.textTheme.headline4?.fontSize),
//             ),
//             SizedBox(
//               height: Get.height * 0.05,
//             ),
//             if (double.parse(sharpValue) < 80) ...[
//               Text(
//                 'Bild ist verschwommen',
//                 textAlign: TextAlign.start,
//                 style: TextStyle(
//                     fontWeight: FontWeight.w400,
//                     color: Colors.white,
//                     fontSize: Get.textTheme.headline3?.fontSize),
//               ),
//               widget.isFromSelfieScreen
//                   ? SizedBox(
//                       height: Get.size.height * 0.6,
//                       child: Image.file(
//                         File(
//                           widget.image.path,
//                         ),
//                       ),
//                     )
//                   : SizedBox(
//                       width: double.infinity,
//                       child: AspectRatio(
//                         aspectRatio: widget.ratio!,
//                         child: Container(
//                             padding: const EdgeInsets.all(15),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(color: Colors.white54),
//                               shape: BoxShape.rectangle,
//                               image: DecorationImage(
//                                 fit: BoxFit.fitWidth,
//                                 alignment: FractionalOffset.center,
//                                 image: FileImage(widget.image),
//                               ),
//                             )),
//                       ),
//                     ),
//               SizedBox(
//                 height: Get.size.height * 0.1,
//               ),
//               SizedBox(
//                 width: Get.size.width * 0.8,
//                 height: kToolbarHeight,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
//                   child: Text(
//                     'Versuch es noch einmal',
//                     style:
//                         Get.textTheme.headline5?.copyWith(color: Colors.black),
//                   ),
//                   onPressed: () {
//                     Get.back();
//                   },
//                 ),
//               ),
//             ],
//             if (double.parse(sharpValue) > 80) ...[
//               widget.isFromSelfieScreen
//                   ? SizedBox(
//                       height: Get.size.height * 0.6,
//                       child: Image.file(
//                         File(
//                           widget.image.path,
//                         ),
//                       ),
//                     )
//                   : SizedBox(
//                       width: double.infinity,
//                       child: AspectRatio(
//                         aspectRatio: widget.ratio!,
//                         child: Container(
//                             padding: const EdgeInsets.all(15),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(color: Colors.white54),
//                               shape: BoxShape.rectangle,
//                               image: DecorationImage(
//                                 fit: BoxFit.fitWidth,
//                                 alignment: FractionalOffset.center,
//                                 image: FileImage(widget.image),
//                               ),
//                             )),
//                       ),
//                     ),
//               SizedBox(
//                 height: Get.size.height * 0.1,
//               ),
//               SizedBox(
//                 width: Get.size.width * 0.8,
//                 height: kToolbarHeight,
//                 child: ElevatedButton(
//                   child: Text(
//                     kOnBoardBtnText,
//                     style:
//                         Get.textTheme.headline5?.copyWith(color: Colors.black),
//                   ),
//                   onPressed: () {
//                     // widget.isFromSelfieScreen
//                     //     ? clubEntryController.saveImageFile(widget.image)
//                     //     : signUpController.signUp(
//                     //         context: context,
//                     //         imageFile: widget.image,
//                     //         userData: signUpController.user);
//                     // showToast(
//                     //     msg: "Registration Success", backColor: Colors.green);
//                   },
//                 ),
//               ),
//             ]
//           ],
//         ),
//       ),
//     );
//   }
// }
