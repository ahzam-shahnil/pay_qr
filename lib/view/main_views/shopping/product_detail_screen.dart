// Flutter imports:
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/config/firebase.dart';
import 'package:pay_qr/model/product_model.dart';
import 'package:pay_qr/view/main_views/shopping/widgets/shop_app_bar.dart';
import 'package:pay_qr/widgets/Shared/clipr_container.dart';
import 'package:pay_qr/widgets/product/top_image_blur.dart';
import 'package:pay_qr/widgets/product/top_image_cover.dart';
import 'package:pay_qr/widgets/shared/header_text.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductModel product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    logEvent(widget.product);
    super.initState();
  }

  logEvent(ProductModel product) async {
    await analytics.logBeginCheckout(
        value: 1,
        currency: 'PKR',
        items: [
          AnalyticsEventItem(
              currency: "PKR",
              itemName: product.title,
              itemId: product.id,
              price: product.price),
        ],
        coupon: '10PERCENTOFF');
  }

  // final ProductController productController = Get.find<ProductController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTealColor,
      appBar: PreferredSize(
        preferredSize: const Size(
          double.infinity,
          56.0,
        ),
        child: ShopHomeAppBar(
          qrModel: widget.product.qr!,
        ),
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
              Hero(
                tag: widget.product.id,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: widget.product.imageUrl == null
                      ? TopImageBlur(
                          height: Get.size.shortestSide * 0.5,
                          width: Get.size.shortestSide,
                        )
                      : TopImageCover(
                          height: Get.size.shortestSide * 0.5,
                          width: Get.size.shortestSide,
                          urlToImg: widget.product.imageUrl!,
                        ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              //? title of article
              Text(
                widget.product.title,
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
                  if (widget.product.qr?.shopName != null)
                    TextHeader(
                      sourceName: widget.product.qr?.shopName,
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
                widget.product.description,
                style: Get.textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: Get.size.shortestSide * 0.045,
                ),
              ),
              Text(
                'Rs. ${widget.product.price}',
                style: Get.textTheme.headline6!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: Get.size.shortestSide * 0.045,
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    cartController.addProductToCart(widget.product);
                  },
                  child: const Text('Add to Cart',
                      style: TextStyle(color: kScanBackColor)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
