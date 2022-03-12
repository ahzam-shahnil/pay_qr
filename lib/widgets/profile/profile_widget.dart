// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:octo_image/octo_image.dart';

// Project imports:
import 'package:pay_qr/config/app_constants.dart';

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
          buildProfileImage(),
          //  AspectRatio(aspectRatio: 1.33,
          // child: OctoImage(image: )),
          Positioned(
            bottom: -6,
            right: -8,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 2,
                  shape: const CircleBorder(),
                  primary: Colors.white),
              onPressed: onClicked,
              child: Icon(
                isEdit ? Icons.add_a_photo_rounded : Icons.edit,
                color: kPrimaryDarkColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileImage() {
    return CircleAvatar(
        radius: 50,
        child: imageUrl == null
            ? const Icon(
                Icons.person_outline_rounded,
              )
            : null,
        foregroundImage: imageFile == null && imageUrl != null
            ? OctoImage(
                image: CachedNetworkImageProvider(imageUrl!),
                // placeholderBuilder:
                //     OctoPlaceholder.blurHash('LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
                progressIndicatorBuilder:
                    OctoProgressIndicator.circularProgressIndicator(),
                errorBuilder: OctoError.icon(color: Colors.red),
                fit: BoxFit.fill,
                width: double.infinity,
                height: double.infinity,
              ).image
            : imageFile != null
                ? Image.file(
                    imageFile!,
                    // scale: 10,
                    fit: BoxFit.fill,
                  ).image
                : null,
        backgroundColor: kPrimaryDarkColor);

    // return ClipOval(
    //   child: Material(
    //     color: Colors.transparent,
    //     child: Ink.image(
    //       image: image,
    //       fit: BoxFit.cover,
    //       width: 128,
    //       height: 128,
    //       child: InkWell(onTap: widget.onClicked),
    //     ),
    //   ),
    // );
  }

  // Widget buildEditIcon(Color color) => buildCircle(
  //       color: Colors.white,
  //       all: 3,
  //       child: buildCircle(
  //         color: color,
  //         all: 8,
  //         child: const Icon(
  //           Icons.edit,
  //           color: Colors.white,
  //           size: 20,
  //         ),
  //       ),
  //     );

  // Widget buildCircle({
  //   required Widget child,
  //   required double all,
  //   required Color color,
  // }) =>
  //     ClipOval(
  //       child: Container(
  //         padding: EdgeInsets.all(all),
  //         color: color,
  //         child: child,
  //       ),
  //     );
}
