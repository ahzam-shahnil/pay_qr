import 'package:flutter/material.dart';
import 'package:pay_qr/widgets/shimmer_author_date.dart';
import 'package:pay_qr/widgets/text_shimmer.dart';
import 'package:shimmer/shimmer.dart';

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
          const ShimmerAuthorDate()
        ]),
      ),
    );
  }
}
