// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

class TextHeader extends StatelessWidget {
  const TextHeader({
    Key? key,
    required this.sourceName,
  }) : super(key: key);

  final String? sourceName;

  @override
  Widget build(BuildContext context) {
    return Text(
      sourceName ?? '',
      style: Get.textTheme.headline4!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: Get.size.shortestSide * 0.033,
      ),
      maxLines: 1,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
    );
  }
}
