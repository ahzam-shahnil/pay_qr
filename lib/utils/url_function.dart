// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:url_launcher/url_launcher.dart';

// Project imports:
import 'package:pay_qr/utils/toast_dialogs.dart';

class UrlFunction {
  static void launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : showToast(
          msg: 'Could not launch $_url',
          backColor: Colors.black54,
          textColor: Colors.white);
}
