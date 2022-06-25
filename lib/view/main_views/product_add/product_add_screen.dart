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
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({Key? key}) : super(key: key);

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  // Logger log = Logger();

  File? imageFile;
  final picker = ImagePicker();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    profileController.getProfile();
  }

  String? imgUrl;

  final GlobalKey _globalKey = GlobalKey();

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
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kScanBackColor,
      appBar: AppBar(
        title: Text(
          "Add Product",
          style: Get.textTheme.headline6,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(primary: kTextFieldColor),
              onPressed: () => pickImage(),
              icon: const Icon(Icons.add_a_photo_rounded, color: Colors.white),
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
                Obx(() => RepaintBoundary(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: kHeight * 0.3,
                              child: SfBarcodeGenerator(
                                value: productsAddController.data.value,
                                symbology: QRCode(),
                                barColor: kPrimaryColor,
                                showValue: false,
                              ),
                            ),
                            Container(
                              height: kHeight * 0.12,
                              width: kHeight * 0.12,
                              padding: const EdgeInsets.all(8),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(15),
                                  color: imageFile == null
                                      ? Colors.deepOrange.shade200
                                      : Colors.transparent,
                                  image: DecorationImage(
                                    image: imageFile == null
                                        ? Assets.images.placeholder
                                        : Image.file(
                                            imageFile!,
                                            // scale: 10,
                                            fit: BoxFit.fill,
                                          ).image,
                                  )),
                              child: imageFile == null
                                  ? Text(
                                      "Product\nPicture\nHere",
                                      style: Get.textTheme.headline6
                                          ?.copyWith(color: Colors.white),
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    )),
                RoundedRectangleInputField(
                  hintText: "Enter Item Name",
                  textCapitalization: TextCapitalization.words,
                  textController: profileController.nameController,
                  textInputType: TextInputType.name,
                  maxLines: null,
                ),
                RoundedRectangleInputField(
                  hintText: "Enter Item Description",
                  textCapitalization: TextCapitalization.sentences,
                  icon: Icons.description_rounded,
                  textController: profileController.descController,
                  maxLines: 5,
                  textInputType: TextInputType.multiline,
                ),
                RoundedRectangleInputField(
                  hintText: "Enter Item Price",
                  textInputType: TextInputType.number,
                  icon: Icons.monetization_on_rounded,
                  textController: profileController.priceController,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          ProductModel product;
                          final String name =
                              profileController.nameController.text;
                          final String price =
                              profileController.priceController.text;
                          final String description =
                              profileController.descController.text;

                          if (profileController.nameController.text.trim().isNotEmpty &&
                              profileController.nameController.text
                                  .trim()
                                  .isNotEmpty &&
                              profileController.nameController.text
                                  .trim()
                                  .isNotEmpty &&
                              imageFile != null) {
                            //? saving the product to database and savinf Db ref to Qr
                            var progressDialog = getProgressDialog(
                                title: 'Product ',
                                msg: 'Uploading Image...',
                                context: context);
                            progressDialog.show();
                            //showLoading('Adding ...');

                            imgUrl = await uploadImage(
                                imageFile: imageFile!,
                                metaData: {
                                  'name': profileController.nameController.text,
                                  'description':
                                      profileController.descController.text
                                },
                                userName:
                                    userController.userModel.value.fullName ??
                                        '');
                            progressDialog
                                .setMessage(const Text('Saving Product...'));
                            //? Add Product Details Here
                            product = ProductModel(
                              description: description,
                              price: double.parse(price),
                              title: name,
                              imageUrl: imgUrl ?? kDefaultImgUrl,
                              id: '',
                            );
                            await productsAddController.saveProduct(product);
                            // hideLoading();
                            progressDialog.dismiss();
                            logger.i("Product Added");
                            showToast(
                                msg: "Product Added",
                                backColor: Colors.green,
                                textColor: Colors.white);
                          } else {
                            if (imageFile == null) {
                              showToast(
                                msg: "Please Select Image of Product",
                                backColor: Colors.red,
                                textColor: Colors.white,
                              );
                            } else {
                              showToast(
                                msg: "Enter item Details ",
                                backColor: Colors.red,
                                textColor: Colors.white,
                              );
                            }
                          }
                        },
                        child:
                            Text("Add Product", style: Get.textTheme.headline6),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: kTealColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () async {
                          if (productsAddController.data.value
                              .trim()
                              .isNotEmpty) {
                            var progress = getProgressDialog(
                                title: 'QR Code Image',
                                msg: 'Saving....',
                                context: context);
                            progress.show();
                            await captureAndSavePng(
                                globalKey: _globalKey,
                                name: profileController.nameController.text
                                        .trim()
                                        .isEmpty
                                    ? "image"
                                    : profileController.nameController.text
                                        .trim());
                            logger.i("Qr Saved");
                            progress.dismiss();
                            showToast(
                                msg: "Qr Code Image Saved",
                                backColor: Colors.green,
                                textColor: Colors.white);
                            // Clear the text fields
                            profileController.nameController.text = '';
                            profileController.priceController.text = '';
                            profileController.descController.clear();
                            setState(() {
                              imageFile = null;
                            });
                            // resetting the qr Image Details
                            productsAddController.data.value = '';
                          } else {
                            showToast(
                                msg: "Add Product First, then save",
                                backColor: Colors.red,
                                textColor: Colors.white);
                          }
                        },
                        child: Text("Save As Image",
                            style: Get.textTheme.headline6),
                      ),
                    ],
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
