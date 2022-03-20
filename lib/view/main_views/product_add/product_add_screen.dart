// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_flutter/qr_flutter.dart';

// Project imports:
import 'package:pay_qr/components/rounded_input_field.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/product_model.dart';
import 'package:pay_qr/utils/image_saver.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';
import 'package:pay_qr/utils/upload_image.dart';

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () => pickImage(),
              icon: const Icon(Icons.add_a_photo_rounded),
              label: Text(
                imageFile == null ? 'Add Image' : 'Change Image',
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
              height: size.height * 0.055,
            ),
            Column(
              children: [
                Obx(() => RepaintBoundary(
                      key: _globalKey,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            QrImage(
                              backgroundColor: Colors.white,
                              data: productsAddController.data.value,
                              version: QrVersions.auto,
                              size: 200.0,
                              errorStateBuilder: (cxt, err) {
                                return const Center(
                                  child: Text(
                                    "Uh oh! Something went wrong...",
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              },
                            ),
                            CircleAvatar(
                              radius: 60,
                              child: imageFile == null
                                  ? Text(
                                      "Product\nPicture\nHere",
                                      style: Get.textTheme.headline6
                                          ?.copyWith(color: Colors.white),
                                    )
                                  : null,
                              foregroundImage: imageFile == null
                                  ? null
                                  : Image.file(
                                      imageFile!,
                                      // scale: 10,
                                      fit: BoxFit.fill,
                                    ).image,
                              backgroundColor: Colors.deepPurple.shade200,
                            ),
                          ],
                        ),
                      ),
                    )),
                RoundedInputField(
                  hintText: "Enter Item Name",
                  textCapitalization: TextCapitalization.words,
                  textController: profileController.nameController,
                  textInputType: TextInputType.name,
                  maxLines: null,
                ),
                RoundedInputField(
                  hintText: "Enter Item Description",
                  textCapitalization: TextCapitalization.sentences,
                  icon: Icons.description_rounded,
                  textController: profileController.descController,
                  maxLines: 5,
                  textInputType: TextInputType.multiline,
                ),
                RoundedInputField(
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
                        style: ElevatedButton.styleFrom(
                            primary: Colors.yellow.shade900,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
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
                                });
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
                        child: const Text("Add Product"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green,
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
                        child: const Text("Save As Image"),
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
