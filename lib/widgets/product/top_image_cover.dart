// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

// Project imports:
import '../Shared/clipr_container.dart';
import '../shared/blur_image.dart';

class TopImageCover extends StatelessWidget {
  const TopImageCover({
    Key? key,
    required this.urlToImg,
    required this.height,
    required this.width,
  }) : super(key: key);

  final String urlToImg;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return ClipRContainer(
      height: height,
      width: width,
      child: FancyShimmerImage(
        width: double.infinity,
        boxFit: BoxFit.cover,
        imageUrl: urlToImg,
        errorWidget: const BlurImage(),
      ),
      // child: ProgressiveImage(
      //   fit: BoxFit.fill,
      //   image: urlToImg,
      //   height: double.maxFinite,
      //   width: double.maxFinite,
      //   imageError: 'assets/images/place_holder.jpg',
      // ),
    );
  }
}
