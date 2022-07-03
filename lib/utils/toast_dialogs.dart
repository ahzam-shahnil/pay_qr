// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:ndialog/ndialog.dart';

// Project imports:
import 'package:pay_qr/config/app_constants.dart';

void showToast(
    {required String msg,
    Color? backColor,
    Color? textColor,
    IconData? iconData}) {
  // Fluttertoast.showToast(
  //   msg: msg,

  //   toastLength: Toast.LENGTH_SHORT,
  //   gravity: ToastGravity.TOP,
  //   timeInSecForIosWeb: 1,
  //   backgroundColor: backColor ?? kTealColor,
  //   textColor: textColor ?? kScanBackColor,
  // );
  Get.snackbar(
    "",
    '',
    icon: Icon(iconData ?? Icons.close_rounded, color: Colors.white),
    snackPosition: SnackPosition.TOP,
    backgroundColor: backColor ?? kTealColor,
    borderRadius: 20,
    messageText: Text(msg, style: Get.textTheme.headline6),
    margin: const EdgeInsets.all(10),
    colorText: textColor ?? kScanBackColor,
    duration: const Duration(seconds: 2),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}

ProgressDialog getProgressDialog(
    {required String title,
    required String msg,
    required BuildContext context,
    Color? textColor}) {
  return ProgressDialog(
    context,
    title: Text(title, style: TextStyle(color: textColor ?? kPrimaryColor)),
    message: Text(msg, style: TextStyle(color: textColor ?? kPrimaryColor)),
    dismissable: false,
    blur: 2,
  );
}
