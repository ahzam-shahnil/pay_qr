// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/view/main_views/shopping/product_detail_screen.dart';
import 'package:pay_qr/widgets/shared/custom_text.dart';
import '../../../config/controllers.dart';
import '../../../model/product_model.dart';
import '../../../widgets/shared/blur_image.dart';

class ProductTile extends StatelessWidget {
  final ProductModel product;

  const ProductTile({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          splashColor: kPrimaryColor,
          onTap: () {
            // print('Tapped!');
            Get.to(() => ProductDetailScreen(product: product));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 180,
                      width: double.infinity,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FancyShimmerImage(
                        width: double.infinity,
                        height: Get.size.height * 0.2,
                        boxFit: BoxFit.scaleDown,
                        imageUrl: product.imageUrl!,
                        errorWidget: const BlurImage(),
                      ),
                    ),
                    // Positioned(
                    //   right: 0,
                    //   child: Obx(() => CircleAvatar(
                    //         backgroundColor: Colors.white,
                    //         child: IconButton(
                    //           icon: product.isFavorite.value
                    //               ? const Icon(Icons.favorite_rounded)
                    //               : const Icon(Icons.favorite_border),
                    //           onPressed: () {
                    //             product.isFavorite.toggle();
                    //           },
                    //         ),
                    //       )),
                    // )
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  product.title,
                  maxLines: 2,
                  style: Get.textTheme.headline5?.copyWith(color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // if (product. != null)
                //   Container(
                //     decoration: BoxDecoration(
                //       color: Colors.green,
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                //     child: Row(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         Text(
                //           product.rating.toString(),
                //           style: const TextStyle(color: Colors.white),
                //         ),
                //         const Icon(
                //           Icons.star,
                //           size: 16,
                //           color: Colors.white,
                //         ),
                //       ],
                //     ),
                //   ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: CustomText(
                        text: "\$${product.price}",
                        size: 22,
                        weight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    IconButton(
                        color: kPrimaryColor,
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          cartController.addProductToCart(product);
                        })
                  ],
                ),
                // const SizedBox(height: 8),
                // Text(
                //   '\t\t\tRs. ${product.price}',
                //   style: Get.textTheme.headline6?.copyWith(color: Colors.black),
                //   overflow: TextOverflow.ellipsis,
                // ),
                // IconButton(
                //     color: kPrimaryColor,
                //     icon: const Icon(Icons.add_shopping_cart),
                //     onPressed: () {
                //       cartController.addProductToCart(product);
                //     })
              ],
            ),
          ),
        ),
      ),
    );
  }
}