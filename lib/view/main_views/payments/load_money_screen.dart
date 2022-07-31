import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/payment_qr_model.dart';
import 'package:pay_qr/utils/image_saver.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class LoadMoneyScreen extends StatefulWidget {
  const LoadMoneyScreen({Key? key}) : super(key: key);

  @override
  State<LoadMoneyScreen> createState() => _LoadMoneyScreenState();
}

class _LoadMoneyScreenState extends State<LoadMoneyScreen> {
  final GlobalKey _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Load Money'),
        backgroundColor: kTealColor,
      ),
      backgroundColor: kScanBackColor,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() => Text(
                  'Your Current balance is ${userController.userModel.value.balance.toStringAsFixed(2)}',
                  style: Get.textTheme.headline6?.copyWith(color: kTealColor),
                )),
            SizedBox(
              height: kHeight * 0.05,
            ),
            Obx(
              () => RepaintBoundary(
                key: _globalKey,
                child: Center(
                  child: Container(
                    height: kHeight * 0.45,
                    width: kWidth * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: SizedBox(
                      height: kHeight * 0.3,
                      child: SfBarcodeGenerator(
                        value: PaymentQrModel(
                                name: userController.userModel.value.fullName!,
                                uid: userController.userModel.value.uid!)
                            .toJson()
                            .toString(),
                        symbology: QRCode(),
                        barColor: kTealColor,
                        showValue: false,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: kHeight * 0.05,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: kTealColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              onPressed: () async {
                // if (productsAddController.data.value.trim().isNotEmpty) {
                // var progress = getProgressDialog(
                //   title: 'QR Code Image',
                //   msg: 'Saving....',
                //   context: context,
                //   textColor: kTealColor,
                // );
                // progress.show();
                await captureAndShare(
                  globalKey: _globalKey,
                  name: userController.userModel.value.fullName!,
                );
                // logger.i("Qr Saved");
                // progress.dismiss();
                // showSnackBar(
                //   msg: "Qr Code Image Saved",
                //   backColor: Colors.green,
                //   textColor: Colors.white,
                //   iconData: Icons.done_rounded,
                // );
              },
              child: Text("Save As Image", style: Get.textTheme.headline6),
            ),
          ]),
    );
  }
}
