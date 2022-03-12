// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';

// Project imports:
import '../../model/product_model.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  const ProductItem({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: OctoImage(
          image: CachedNetworkImageProvider(product.imageUrl!),
          // placeholderBuilder:
          //     OctoPlaceholder.blurHash('LEHV6nWB2yk8pyo0adR*.7kCMdnj'),
          progressIndicatorBuilder:
              OctoProgressIndicator.circularProgressIndicator(),
          errorBuilder: OctoError.icon(color: Colors.red),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        // header: Text(product.title),
        footer: GridTileBar(
          backgroundColor: const Color.fromARGB(221, 46, 46, 46),
          // leading: IconButton(
          //   icon: const Icon(Icons.favorite),
          //   onPressed: () {},
          //   color: Theme.of(context).colorScheme.secondary,
          // ),
          title: Text(
            product.price.toString() + ' Rs',
            style: Get.textTheme.headline6?.copyWith(
              // color: kPrimaryColor,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          leading: Text(
            product.title,
            style: Get.textTheme.headline5?.copyWith(
              // color: kPrimaryColor,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
