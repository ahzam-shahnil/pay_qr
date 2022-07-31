// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pay_qr/components/rounded_rectangular_input_field.dart';
// Project imports:

import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/gen/assets.gen.dart';
import 'package:pay_qr/model/product_model.dart';
import 'package:pay_qr/utils/image_saver.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';
import 'package:pay_qr/utils/upload_image.dart';
import 'package:pay_qr/widgets/shared/clipr_container.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({Key? key}) : super(key: key);

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  File? imageFile;
  final picker = ImagePicker();

  String? imgUrl;

  final GlobalKey _globalKey = GlobalKey();

  void clearData() {
    // Clear the text fields
    productsAddController.nameController.clear();
    productsAddController.priceController.clear();
    productsAddController.descController.clear();
    productsAddController.data.value = '';
    productsAddController.isVisible.value = false;
    setState(() {
      imageFile = null;
    });
  }

  Future pickImage() async {
    logger.i('add Image');
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        imageQuality: 50,
      );

      setState(() {
        imageFile = File(pickedImage!.path);
      });
      logger.d(imageFile?.path);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScanBackColor,
      appBar: AppBar(
        title: Text(
          "Add Product",
          style: Get.textTheme.headline6,
        ),
        backgroundColor: kAddProductColor,
        actions: [
          if (mounted)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: kTextFieldColor),
                onPressed: () => pickImage(),
                icon:
                    const Icon(Icons.add_a_photo_rounded, color: Colors.white),
                label: Text(
                  imageFile == null ? 'Add Image' : 'Change Image',
                  style: Get.textTheme.headline6,
                ),
              ),
            )
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          children: [
            SizedBox(
              height: kHeight * 0.045,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kWidth * 0.1),
                  child: Obx(
                    () => Visibility(
                        visible: productsAddController.isVisible.value,
                        replacement: ClipRContainer(
                          height: Get.size.shortestSide * 0.5,
                          width: Get.size.shortestSide,
                          child: imageFile == null
                              ? Card(
                                  color: kAddProductColor,
                                  child: Image.asset(
                                    Assets.images.shop.path,
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : Image.file(
                                  imageFile!,
                                  // scale: 10,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        child: Obx(() => RepaintBoundary(
                              key: _globalKey,
                              child: Container(
                                height: kHeight * 0.45,
                                width: kWidth * 0.9,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: kHeight * 0.3,
                                      child: SfBarcodeGenerator(
                                        value: productsAddController.data.value,
                                        symbology: QRCode(),
                                        barColor: kAddProductColor,
                                        showValue: false,
                                      ),
                                    ),
                                    Container(
                                      height: kHeight * 0.12,
                                      // width: kWidth * 0.2,
                                      padding: const EdgeInsets.all(8),
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          // color: imageFile == null
                                          //     ? null
                                          //     : Colors.transparent,
                                          image: DecorationImage(
                                            image: imageFile == null
                                                ? Assets.images.placeholder
                                                : Image.file(
                                                    imageFile!,
                                                    // scale: 10,
                                                    fit: BoxFit.fill,
                                                  ).image,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ))),
                  ),
                ),
                RoundedRectangleInputField(
                  color: kAddProductColor,
                  hintText: "Enter Item Name",
                  textCapitalization: TextCapitalization.words,
                  textController: productsAddController.nameController,
                  textInputType: TextInputType.name,
                  maxLines: null,
                ),
                RoundedRectangleInputField(
                  color: kAddProductColor,
                  hintText: "Enter Item Description",
                  textCapitalization: TextCapitalization.sentences,
                  icon: Icons.description_rounded,
                  textController: productsAddController.descController,
                  maxLines: 5,
                  textInputType: TextInputType.multiline,
                ),
                RoundedRectangleInputField(
                  color: kAddProductColor,
                  hintText: "Enter Item Price",
                  textInputType: TextInputType.number,
                  icon: Icons.monetization_on_rounded,
                  textController: productsAddController.priceController,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: kWidth * 0.2, vertical: kHeight * 0.05),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      primary: kTealColor,
                      minimumSize: const Size.fromHeight(50),
                    ),
                    onPressed: () async {
                      ProductModel product;
                      final String name =
                          productsAddController.nameController.text;
                      final String price =
                          productsAddController.priceController.text;
                      final String description =
                          productsAddController.descController.text;

                      if (productsAddController.nameController.text.trim().isNotEmpty &&
                          productsAddController.nameController.text
                              .trim()
                              .isNotEmpty &&
                          productsAddController.nameController.text
                              .trim()
                              .isNotEmpty &&
                          imageFile != null) {
                        //? saving the product to database and savinf Db ref to Qr
                        var progressDialog = getProgressDialog(
                            title: 'Product ',
                            msg: 'Compressing Image...',
                            context: context);
                        progressDialog.show();
                        //showLoading('Adding ...');

                        try {
                          imgUrl = await uploadImage(
                              imageFile: imageFile!,
                              metaData: {
                                'name':
                                    productsAddController.nameController.text,
                                'description':
                                    productsAddController.descController.text
                              },
                              userName:
                                  userController.userModel.value.fullName ??
                                      '');
                          progressDialog
                              .setMessage(const Text('Image Uploaded...'));

                          //? Add Product Details Here
                          product = ProductModel(
                            description: description,
                            price: double.parse(price),
                            title: name,
                            imageUrl: imgUrl ?? kDefaultImgUrl,
                            id: '',
                          );
                          progressDialog
                              .setMessage(const Text('Saving Product...'));
                          await productsAddController.saveProduct(product);
                          // hideLoading();
                          progressDialog.dismiss();
                          showToast(
                            msg: "Product Added",
                            backColor: Colors.green,
                            textColor: Colors.white,
                          );
                          //* to show the qr code , we set visible to true
                          productsAddController.isVisible(true);

                          try {
                            await captureAndShare(
                                globalKey: _globalKey,
                                name: productsAddController.nameController.text
                                        .trim()
                                        .isEmpty
                                    ? ""
                                    : productsAddController.nameController.text
                                        .trim());

                            //Clearing the fields and image file
                            clearData();
                          } catch (e) {
                            progressDialog.dismiss();
                            logger.e(e);
                            showSnackBar(
                                msg: e.toString(), backColor: kPrimaryColor);
                          }
                        } catch (e) {
                          progressDialog.dismiss();
                          logger.e(e);
                          showSnackBar(
                              msg: e.toString(), backColor: kPrimaryColor);
                        }
                      } else {
                        if (imageFile == null) {
                          showSnackBar(
                            msg: "Please Select Image of Product",
                            backColor: Colors.red,
                            textColor: Colors.white,
                          );
                        } else {
                          showSnackBar(
                            msg: "Enter item Details ",
                            backColor: Colors.red,
                            textColor: Colors.white,
                          );
                        }
                      }
                    },
                    child: Text("Save Product", style: Get.textTheme.headline6),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
