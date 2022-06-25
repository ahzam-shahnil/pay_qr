/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// ignore_for_file: directives_ordering,unnecessary_import

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/add_user.png
  AssetGenImage get addUser =>
      const AssetGenImage('assets/images/add_user.png');

  /// File path: assets/images/arrow.png
  AssetGenImage get arrow => const AssetGenImage('assets/images/arrow.png');

  /// File path: assets/images/logo.png
  AssetGenImage get logo => const AssetGenImage('assets/images/logo.png');

  /// File path: assets/images/logo_gif.gif
  AssetGenImage get logoGif =>
      const AssetGenImage('assets/images/logo_gif.gif');

  /// File path: assets/images/logo_wn.png
  AssetGenImage get logoWn => const AssetGenImage('assets/images/logo_wn.png');

  /// File path: assets/images/name_logo.png
  AssetGenImage get nameLogo =>
      const AssetGenImage('assets/images/name_logo.png');

  $AssetsImagesOnboard1stGen get onboard1st =>
      const $AssetsImagesOnboard1stGen();
  $AssetsImagesOnboard2ndGen get onboard2nd =>
      const $AssetsImagesOnboard2ndGen();

  /// File path: assets/images/placeholder.png
  AssetGenImage get placeholder =>
      const AssetGenImage('assets/images/placeholder.png');

  /// File path: assets/images/scan_intro.png
  AssetGenImage get scanIntro =>
      const AssetGenImage('assets/images/scan_intro.png');

  /// File path: assets/images/shop.png
  AssetGenImage get shop => const AssetGenImage('assets/images/shop.png');

  /// File path: assets/images/user.png
  AssetGenImage get user => const AssetGenImage('assets/images/user.png');

  /// File path: assets/images/user_2.png
  AssetGenImage get user2 => const AssetGenImage('assets/images/user_2.png');

  /// File path: assets/images/user_profile.png
  AssetGenImage get userProfile =>
      const AssetGenImage('assets/images/user_profile.png');
}

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/logo.svg
  SvgGenImage get logo => const SvgGenImage('assets/svgs/logo.svg');
}

class $AssetsTfliteGen {
  const $AssetsTfliteGen();

  /// File path: assets/tflite/labels.txt
  String get labels => 'assets/tflite/labels.txt';

  /// File path: assets/tflite/model.tflite
  String get model => 'assets/tflite/model.tflite';
}

class $AssetsImagesOnboard1stGen {
  const $AssetsImagesOnboard1stGen();

  /// File path: assets/images/onboard_1st/lives_matter.png
  AssetGenImage get livesMatter =>
      const AssetGenImage('assets/images/onboard_1st/lives_matter.png');

  /// File path: assets/images/onboard_1st/onboard_image_1.png
  AssetGenImage get onboardImage1 =>
      const AssetGenImage('assets/images/onboard_1st/onboard_image_1.png');
}

class $AssetsImagesOnboard2ndGen {
  const $AssetsImagesOnboard2ndGen();

  /// File path: assets/images/onboard_2nd/partying.png
  AssetGenImage get partying =>
      const AssetGenImage('assets/images/onboard_2nd/partying.png');
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
  static const $AssetsTfliteGen tflite = $AssetsTfliteGen();
}

class AssetGenImage extends AssetImage {
  const AssetGenImage(String assetName) : super(assetName);

  Image image({
    Key? key,
    ImageFrameBuilder? frameBuilder,
    ImageLoadingBuilder? loadingBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? width,
    double? height,
    Color? color,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image(
      key: key,
      image: this,
      frameBuilder: frameBuilder,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      width: width,
      height: height,
      color: color,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      filterQuality: filterQuality,
    );
  }

  String get path => assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
      theme: theme,
    );
  }

  String get path => _assetName;
}
