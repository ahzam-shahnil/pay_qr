// Flutter imports:
import 'package:flutter/material.dart';
// Project imports:
import 'package:pay_qr/utils/toast_dialogs.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UrlFunction {
  static void launchURL(String url) async => await canLaunchUrlString(url)
      ? launchURL(url)
      : showSnackBar(
          msg: 'Could not launch $url',
          backColor: Colors.black54,
          textColor: Colors.white);
}
