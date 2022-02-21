// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';

void showToast({required String msg, Color? backColor, Color? textColor}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: backColor ?? Colors.red,
    textColor: textColor ?? Colors.white,
  );
}

ProgressDialog getProgressDialog(
    {required String title,
    required String msg,
    required BuildContext context}) {
  return ProgressDialog(
    context,
    title: Text(title),
    message: Text(msg),
    dismissable: false,
    blur: 2,
  );
}
