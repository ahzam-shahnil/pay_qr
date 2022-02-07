// Dart imports:
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:logger/logger.dart';
import 'package:qr_flutter/qr_flutter.dart';

// Project imports:
import 'package:pay_qr/components/rounded_input_field.dart';
import 'package:pay_qr/controller/qr_controller.dart';
import 'package:pay_qr/model/product.dart';
import 'package:pay_qr/services/show_toast.dart';

class QrGenerateScreen extends StatefulWidget {
  const QrGenerateScreen({Key? key}) : super(key: key);

  @override
  State<QrGenerateScreen> createState() => _QrGenerateScreenState();
}

class _QrGenerateScreenState extends State<QrGenerateScreen> {
  Logger log = Logger();
  bool permissionGranted = false;
  @override
  void initState() {
    // _getStoragePermission();
    super.initState();
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  //Create an instance of ScreenshotController
  final GlobalKey globalKey = GlobalKey();

  // Future _getStoragePermission() async {
  //   if (await Permission.storage.request().isGranted) {
  //     setState(() {
  //       permissionGranted = true;
  //     });
  //   } else if (await Permission.storage.request().isPermanentlyDenied) {
  //     await openAppSettings();
  //   } else if (await Permission.storage.request().isDenied) {
  //     setState(() {
  //       permissionGranted = false;
  //     });
  //   }
  // }

  //* Controllers
  final qrController = Get.find<QrController>();

  @override
  Widget build(BuildContext context) {
    Future<void> _captureAndSavePng() async {
      try {
        RenderRepaintBoundary boundary = globalKey.currentContext!
            .findRenderObject() as RenderRepaintBoundary;
        var image = await boundary.toImage();
        ByteData? byteData =
            await image.toByteData(format: ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();

        // final tempDir = await getTemporaryDirectory();
        // final file = await File('${tempDir.path}/image.png').create();
        // await file.writeAsBytes(pngBytes);
        await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes),
            quality: 100, name: _nameController.text);
      } catch (e) {
        log.e(e.toString());
      }
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Qr"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          Column(
            children: [
              Obx(() => RepaintBoundary(
                    key: globalKey,
                    child: QrImage(
                      backgroundColor: Colors.white,
                      data: qrController.data.value,
                      version: QrVersions.auto,

                      // eyeStyle: const QrEyeStyle(
                      //     eyeShape: QrEyeShape.square, color: Colors.green),
                      // dataModuleStyle: const QrDataModuleStyle(
                      //     dataModuleShape: QrDataModuleShape.circle,
                      //     color: Colors.green),
                      size: 200.0,
                      errorStateBuilder: (cxt, err) {
                        return const Center(
                          child: Text(
                            "Uh oh! Something went wrong...",
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  )),
              RoundedInputField(
                  hintText: "Enter Item Name", textController: _nameController),
              RoundedInputField(
                hintText: "Enter Item Price",
                icon: Icons.monetization_on_rounded,
                textController: _priceController,
              ),
              RoundedInputField(
                hintText: "Enter Item Quantity",
                icon: Icons.confirmation_number_rounded,
                textController: _qtyController,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.yellow.shade900,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () async {
                        Product product;
                        final String? name = _nameController.text;
                        final String? price = _priceController.text;
                        final String? qty = _qtyController.text;

                        if (_nameController.text.trim().isNotEmpty &&
                            _nameController.text.trim().isNotEmpty &&
                            _nameController.text.trim().isNotEmpty) {
                          product = Product.fromJson(
                              {"name": name, "price": price, "quantity": qty});

                          //? saving the product to database and savinf Db ref to Qr
                          await qrController.generateQr(product);
                          // Clear the text fields
                          _nameController.text = '';
                          _priceController.text = '';
                          _qtyController.clear();
                          log.i("Qr created");
                          showToast(
                              msg: "Qr Created",
                              backColor: Colors.green,
                              textColor: Colors.white);
                        } else {
                          showToast(
                            msg: "Enter item Details ",
                            backColor: Colors.red,
                            textColor: Colors.white,
                          );
                        }
                      },
                      child: const Text("Create Qr"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () async {
                        if (qrController.data.value.trim().isNotEmpty) {
                          _captureAndSavePng();
                          log.i("Qr Saved");
                          showToast(
                              msg: "Qr Saved",
                              backColor: Colors.green,
                              textColor: Colors.white);
                        } else {
                          showToast(
                              msg: "Create Qr First, then save",
                              backColor: Colors.red,
                              textColor: Colors.white);
                        }
                      },
                      child: const Text("Save Qr"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
