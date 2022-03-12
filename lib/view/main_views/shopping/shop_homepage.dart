// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/qr_model.dart';
import 'package:pay_qr/view/main_views/shopping/widgets/shop_app_bar.dart';
import 'package:pay_qr/widgets/Shared/clipr_container.dart';
import 'product_tile.dart';

class ShopHomePage extends StatefulWidget {
  const ShopHomePage({
    Key? key,
    required this.qrModel,
  }) : super(key: key);
  final QrModel qrModel;
  @override
  State<ShopHomePage> createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage> {
  // final ProductController producsController = Get.find<ProductController>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    productsController.fetchProducts(widget.qrModel.uid);
  }

  // Logger log = Logger();
  int countColumn = 2;
  // int cartItems = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryDarkColor,
      appBar: const PreferredSize(
          preferredSize: Size(
            double.infinity,
            56.0,
          ),
          child: ShopHomeAppBar()),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.qrModel.shopName ?? "Shop",
                    style: Get.textTheme.headline4,
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.view_list_rounded),
                    onPressed: () {
                      setState(() {
                        countColumn = 1;
                      });
                    }),
                IconButton(
                    icon: const Icon(
                      Icons.grid_view,
                    ),
                    onPressed: () {
                      setState(() {
                        countColumn = 2;
                      });
                    }),
              ],
            ),
          ),
          // const Divider(),
          Expanded(
            child: ClipRContainer(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: kPrimaryColor.withOpacity(0.6),
              ),
              child: Obx(() {
                if (productsController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return AlignedGridView.count(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    
                    shrinkWrap: true,
                    crossAxisCount: countColumn,
                    padding: const EdgeInsets.all(4.0),
                    mainAxisSpacing: 6.0,
                    crossAxisSpacing: 6.0,
                    // crossAxisCount: 2,
                    itemCount: productsController.products.length,
                    // crossAxisSpacing: 16,
                    // mainAxisSpacing: 16,
                    itemBuilder: (context, index) {
                      return ProductTile(
                        product: productsController.products[index],
                      );
                    },
                    // staggeredTileBuilder: (index) => StaggeredTile.fit(1),
                  );
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}
