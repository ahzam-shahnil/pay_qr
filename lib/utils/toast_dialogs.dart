// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';

// Project imports:
import 'package:pay_qr/config/app_constants.dart';

void showToast({required String msg, Color? backColor, Color? textColor}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: backColor ?? kTealColor,
    textColor: textColor ?? kTextFieldColor,
  );
}

ProgressDialog getProgressDialog(
    {required String title,
    required String msg,
    required BuildContext context}) {
  return ProgressDialog(
    context,
    title: Text(title, style: const TextStyle(color: kPrimaryColor)),
    message: Text(msg, style: const TextStyle(color: kPrimaryColor)),
    dismissable: false,
    blur: 2,
  );
}
