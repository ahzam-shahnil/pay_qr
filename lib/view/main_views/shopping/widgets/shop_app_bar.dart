// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// Project imports:
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/model/qr_model.dart';
import 'package:pay_qr/view/main_views/shopping/shopping_cart.dart';

class ShopHomeAppBar extends StatelessWidget {
  const ShopHomeAppBar({
    Key? key, required this.qrModel,
  }) : super(key: key);
  final QrModel qrModel;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: const BackButton(),
      actions: [
        // if (cartItems != 0)
        // Badge(
        //   // padding: const EdgeInsets.symmetric(vertical: 12),
        //   badgeContent: Text(
        //     cartItems.toString(),
        //   ),
        //   //TODO: Add CArt Page Here
        //   child: const Icon(Icons.shopping_cart),
        // ),
        Padding(
          padding: const EdgeInsets.only(right: 10, top: 8),
          child: AspectRatio(
            aspectRatio: 1,
            child: ElevatedButton(
              onPressed: () {
                showBarModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    color: Colors.white,
                    child:  ShoppingCartWidget(qrModel: qrModel,),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: kScanBackColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Icon(
                Icons.shopping_cart,
                color: kPrimaryColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
