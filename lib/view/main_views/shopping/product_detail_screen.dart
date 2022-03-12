// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/model/product_model.dart';
import 'package:pay_qr/view/main_views/shopping/widgets/shop_app_bar.dart';
import 'package:pay_qr/widgets/Shared/clipr_container.dart';
import 'package:pay_qr/widgets/product/top_image_blur.dart';
import 'package:pay_qr/widgets/product/top_image_cover.dart';
import 'package:pay_qr/widgets/shared/header_text.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductModel product;

  // final ProductController productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: const PreferredSize(
        preferredSize: Size(
          double.infinity,
          56.0,
        ),
        child: ShopHomeAppBar(),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 1,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          itemBuilder: (context, index) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: product.imageUrl == null
                    ? TopImageBlur(
                        height: Get.size.shortestSide * 0.5,
                        width: Get.size.shortestSide,
                      )
                    : TopImageCover(
                        height: Get.size.shortestSide * 0.5,
                        width: Get.size.shortestSide,
                        urlToImg: product.imageUrl!,
                      ),
              ),
              const SizedBox(
                height: 15,
              ),
              //? title of article
              Text(
                product.title,
                style: Get.textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w900,
                  // color: kPrimaryDarkColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'By ',
                    style: Get.textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: Get.size.shortestSide * 0.033,
                    ),
                  ),
                  if (product.qr?.shopName != null)
                    TextHeader(
                      sourceName: product.qr?.shopName,
                    ),
                ],
              ),

              //? small marker
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: ClipRContainer(
                  width: 35,
                  height: 8,
                  child: Container(
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                product.description,
                style: Get.textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: Get.size.shortestSide * 0.045,
                ),
              ),
              Text(
                'Rs. ${product.price}',
                style: Get.textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: Get.size.shortestSide * 0.045,
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint("Read More Pressed");
                  },
                  child: const Text('Read More'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
