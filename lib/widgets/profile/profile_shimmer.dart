// Flutter imports:
import 'package:flutter/material.dart';
import 'package:pay_qr/config/app_constants.dart';

// Package imports:
import 'package:shimmer/shimmer.dart';

// Project imports:
import 'package:pay_qr/widgets/shared/shimmer_header_date.dart';
import 'package:pay_qr/widgets/shared/text_shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(children: [
          Container(
            width: kWidth * 0.6,
            height: kHeight * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 20),
          const TextShimmer(
            width: double.infinity,
            height: 50,
          ),
          const SizedBox(height: 20),
          const TextShimmer(
            width: double.infinity,
            height: 50,
          ),
          const SizedBox(height: 20),
          const TextShimmer(
            width: double.infinity,
            height: 50,
          ),
          const SizedBox(height: 20),
          const ShimmerHeaderDate()
        ]),
      ),
    );
  }
}
