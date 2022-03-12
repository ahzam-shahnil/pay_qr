// Flutter imports:
import 'package:flutter/material.dart';

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
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey.shade300,
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
