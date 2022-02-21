// Flutter imports:

import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/view/chatbot_screen.dart';
import 'package:pay_qr/view/product_add_screen.dart';

class DemoScreen extends StatelessWidget {
  const DemoScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text("User type is ${userType == '0' ? "merchant" : "User"}"),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () => Get.to(() => const ChatBotScreen()),
            child: const Text("ChatBot"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            onPressed: () => Get.to(() => const QrGenerateScreen()),
            child: const Text("QR Generation"),
          ),
        ],
      ),
    );
  }
}
