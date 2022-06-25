// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:octo_image/octo_image.dart';

// Project imports:
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/gen/assets.gen.dart';

class ProfileWidget extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onClicked;
  final String? imageUrl;
  final bool isEdit;

  const ProfileWidget({
    Key? key,
    this.imageFile,
    required this.onClicked,
    this.imageUrl,
    required this.isEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          const SizedBox(
            height: 15,
          ),
          buildProfileImage(),
          Positioned(
            bottom: 10,
            right: 6,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 2,
                  shape: const CircleBorder(),
                  primary: Colors.white),
              onPressed: onClicked,
              child: Icon(
                isEdit ? Icons.add_photo_alternate_rounded : Icons.edit,
                color: kTealColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileImage() {
    return Container(
      width: kWidth * 0.6,
      height: kHeight * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(60),
        color: kPrimaryColor.withOpacity(0.85),
      ),
      child: imageFile == null && imageUrl != null
          ? OctoImage(
              image: CachedNetworkImageProvider(
                imageUrl!,
              ),
              progressIndicatorBuilder:
                  OctoProgressIndicator.circularProgressIndicator(),
              errorBuilder: OctoError.icon(color: Colors.red),
              fit: BoxFit.cover,
            )
          : imageFile != null
              ? Image.file(
                  imageFile!,
                  // scale: 10,
                  fit: BoxFit.cover,
                  width: kWidth * 0.6,
                  height: kHeight * 0.3,
                )
              : Image.asset(
                  Assets.images.user.path,
                  fit: BoxFit.cover,
                  width: kWidth * 0.6,
                  height: kHeight * 0.3,
                ),
    );
  }
}
