import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/widgets/shared/custom_card.dart';

import '../../../config/controllers.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTealColor,
      appBar: AppBar(
        title: const Text('Current Balance'),
        backgroundColor: kTealColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: kHeight * 0.11,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: kScanBackColor,
              ),
              child: ListTile(
                title: Text(
                  'Current Balance',
                  style: Get.textTheme.headline6?.copyWith(color: kTealColor),
                  maxLines: 3,
                ),
                subtitle: Obx(
                  () => Text(
                    '${userController.userModel.value.balance}',
                    style: Get.textTheme.headline6?.copyWith(color: kTealColor),
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    // logger.d('Imp')
                    //TODO: implement Qr show Dialog here
                  },
                  style: ElevatedButton.styleFrom(
                      primary: kTealColor.withOpacity(0.6)),
                  child: Text(
                    'Show My Qr',
                    style: Get.textTheme.bodyLarge
                        ?.copyWith(color: kScanBackColor),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomCard(
                  color: kPrimaryColor,
                  onTap: () {
                    // Get.to(() => const DigiNavHome());
                  },
                  width: kWidth * 0.4,
                  height: kHeight * 0.2,
                  text: 'Send Money',
                  colors: const [Color(0xFFFF5F6D), Color(0xffFFC371)],
                ),
                CustomCard(
                  color: kTealColor,
                  onTap: () {
                    // Get.to(() => const DigiNavHome());
                  },
                  width: kWidth * 0.4,
                  height: kHeight * 0.2,
                  text: 'Load Money',
                  colors: const [
                    Color(0xFF20bf55),
                    Color.fromARGB(255, 5, 235, 82)
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
