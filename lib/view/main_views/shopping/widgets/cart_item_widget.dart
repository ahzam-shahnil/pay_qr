// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:pay_qr/config/app_constants.dart';

// Project imports:
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/widgets/shared/custom_text.dart';
import '../../../../model/cart_item.dart';
import '../../../../widgets/shared/blur_image.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel cartItem;

  const CartItemWidget({Key? key, required this.cartItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FancyShimmerImage(
            width: kWidth * 0.2,
            height: kWidth * 0.2,
            // height: ,
            boxFit: BoxFit.scaleDown,
            imageUrl: cartItem.image ?? '',
            errorWidget: const BlurImage(),
          ),
        ),
        Expanded(
            child: Wrap(
          direction: Axis.vertical,
          children: [
            Container(
                padding: const EdgeInsets.only(left: 14),
                child: CustomText(
                  text: cartItem.name,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () {
                      cartController.decreaseQuantity(cartItem);
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(
                    text: cartItem.quantity.toString(),
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () {
                      cartController.increaseQuantity(cartItem);
                    }),
              ],
            )
          ],
        )),
        Padding(
          padding: const EdgeInsets.all(14),
          child: CustomText(
            text: "Rs ${cartItem.cost}",
            size: 22,
            weight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
