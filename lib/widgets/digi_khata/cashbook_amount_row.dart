import 'package:flutter/material.dart';
import 'package:pay_qr/widgets/digi_khata/reusable_card.dart';

import '../../config/app_constants.dart';

class CashBookAmountRow extends StatelessWidget {
  final double total;
  const CashBookAmountRow({
    Key? key,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
              child: ReuseableCard(
            textColor: total < 0 ? Colors.red : Colors.green,
            backColor: kScanBackColor,
            text: "Cash in hand",
            title: total.toStringAsFixed(0)
            // .replaceAll('-', '')
            ,
            isMaineLene: true,
            useIcon: false,
          )),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: ReuseableCard(
              backColor: kScanBackColor,
              textColor: total < 0 ? Colors.red : Colors.green,
              text: "Aaj ka balance",
              title: total.toStringAsFixed(0)
              // .replaceAll('-', '')
              ,
              isMaineLene: false,
              useIcon: false,
            ),
          ),
        ],
      ),
    );
  }
}
