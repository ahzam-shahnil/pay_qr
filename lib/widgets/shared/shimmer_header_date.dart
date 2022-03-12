// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/widgets/shared/text_shimmer.dart';

class ShimmerHeaderDate extends StatelessWidget {
  const ShimmerHeaderDate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              // Shimmer.fromColors(
              //   baseColor: Colors.grey.shade300,
              //   highlightColor: Colors.grey.shade100,
              //   child: CircleAvatar(
              //     radius: Get.size.shortestSide * 0.033,
              //     child: const Icon(
              //       Icons.person,
              //     ),
              //   ),
              // ),
              const SizedBox(
                width: 8,
              ),
              TextShimmer(
                height: 35,
                width: Get.size.shortestSide * 0.3,
              )
            ],
          ),
          TextShimmer(
            height: 35,
            width: Get.size.shortestSide * 0.2,
          ),
        ],
      ),
    );
  }
}