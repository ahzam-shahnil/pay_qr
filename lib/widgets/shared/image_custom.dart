// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:octo_image/octo_image.dart';

class ImageCustom extends StatelessWidget {
  const ImageCustom({
    Key? key,
    this.imageUrl,
  }) : super(key: key);
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return OctoImage(
      image: CachedNetworkImageProvider(imageUrl!),
      // placeholderBuilder:
      //     OctoPlaceholder.blurHash('LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
      progressIndicatorBuilder:
          OctoProgressIndicator.circularProgressIndicator(),
      errorBuilder: OctoError.icon(color: Colors.red),
      fit: BoxFit.fill,
      width: double.infinity,
      height: double.infinity,
    );
  }
}
