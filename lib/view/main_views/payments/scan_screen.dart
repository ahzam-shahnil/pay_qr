// Dart imports:
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
// Project imports:
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/payment_qr_model.dart';
import 'package:pay_qr/model/qr_model.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';
import 'package:pay_qr/view/main_views/payments/send_money_screen.dart';
import 'package:pay_qr/view/main_views/shopping/shop_homepage.dart';
import 'package:scan/scan.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key, required this.isFromShopScreen})
      : super(key: key);
  final bool isFromShopScreen;

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final MobileScannerController cameraController = MobileScannerController();

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  final picker = ImagePicker();

  Future pickQrImageAndConvert() async {
    File? imageFile;

    logger.i('add Image');

    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        imageQuality: 50,
      );

      imageFile = File(pickedImage!.path);

      String? result = await Scan.parse(imageFile.path);
      if (result != null) {
        try {
          logger.d(result);
          if (widget.isFromShopScreen) {
            var qrModel = QrModel.fromMap(jsonDecode(result));
            //? to turn off the torch if on
            if (cameraController.torchState.value == TorchState.on) {
              cameraController.toggleTorch();
            }
            if (qrModel.uid == userController.userModel.value.uid) {
              showSnackBar(msg: 'You cannot do shopping🤨 your own shop');
              return;
            }

            Get.to(() => ShopHomePage(
                  qrModel: qrModel,
                ));
          } else {
            var qrModel = PaymentQrModel.fromMap(jsonDecode(result));
            //? to turn off the torch if on
            if (cameraController.torchState.value == TorchState.on) {
              cameraController.toggleTorch();
            }
            if (qrModel.uid == userController.userModel.value.uid) {
              showSnackBar(msg: 'You cannot scan your own Qr🤨');
              return;
            }

            Get.to(() => SendMoneyScreen(paymentQrModel: qrModel));
          }
        } catch (e) {
          logger.e(e);
          showSnackBar(msg: "Invalid Qr");
        }
      } else {
        showSnackBar(msg: "Invalid Qr");
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: kAppBarPrefSize,
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AppBar(
              backgroundColor: kPrimaryColor.withOpacity(0.6),
              title: const Text(
                'Scan To Shop',
              ),
              actions: [
                IconButton(
                  color: Colors.white,
                  icon: ValueListenableBuilder(
                    valueListenable: cameraController.torchState,
                    builder: (context, state, child) {
                      switch (state as TorchState) {
                        case TorchState.off:
                          return const Icon(Icons.flash_off,
                              color: Colors.grey);
                        case TorchState.on:
                          return const Icon(Icons.flash_on,
                              color: Colors.yellow);
                      }
                    },
                  ),
                  iconSize: 32.0,
                  onPressed: () => cameraController.toggleTorch(),
                ),
                IconButton(
                  color: Colors.white,
                  icon: ValueListenableBuilder(
                    valueListenable: cameraController.cameraFacingState,
                    builder: (context, state, child) {
                      switch (state as CameraFacing) {
                        case CameraFacing.front:
                          return const Icon(Icons.camera_front);
                        case CameraFacing.back:
                          return const Icon(Icons.camera_rear);
                      }
                    },
                  ),
                  iconSize: 32.0,
                  onPressed: () => cameraController.switchCamera(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor.withOpacity(0.6),
        onPressed: () => pickQrImageAndConvert(),
        child: const Icon(Icons.add_a_photo_rounded),
      ),
      body: MobileScanner(
          controller: cameraController,
          onDetect: (barcode, args) {
            final String? code = barcode.rawValue;

            if (code != null) {
              try {
                if (widget.isFromShopScreen) {
                  var qrModel = QrModel.fromMap(jsonDecode(code));
                  //? to turn off the torch if on
                  if (cameraController.torchState.value == TorchState.on) {
                    cameraController.toggleTorch();
                  }
                  if (qrModel.uid == userController.userModel.value.uid) {
                    showSnackBar(msg: 'You cannot do shopping🤨 your own shop');
                    return;
                  }
                  Get.to(() => ShopHomePage(
                        qrModel: qrModel,
                      ));
                } else {
                  logger.i('Qr Code found! $code');
                  var qrModel = PaymentQrModel.fromJson(code);
                  // Get.to(() => ProductShop(qrModel: qrModel));
                  //? to turn off the torch if on
                  if (cameraController.torchState.value == TorchState.on) {
                    cameraController.toggleTorch();
                  }

                  //TODO: check this to coni=firm that it exits on this condition
                  if (qrModel.uid == userController.userModel.value.uid) {
                    showSnackBar(msg: 'You cannot scan your own Qr🤨');
                    return;
                  }

                  Get.to(() => SendMoneyScreen(paymentQrModel: qrModel));
                }
              } catch (e) {
                logger.e(e);
                showSnackBar(msg: "Incorrect Qr");
              }
            }
          }),
    );
  }
}
