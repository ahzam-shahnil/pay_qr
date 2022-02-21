// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import 'package:pay_qr/controller/profile_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';

// Project imports:
import 'package:pay_qr/components/rounded_input_field.dart';
import 'package:pay_qr/config/constants.dart';
import 'package:pay_qr/controller/base_controller.dart';
import 'package:pay_qr/controller/product_controller.dart';
import 'package:pay_qr/model/product.dart';
import 'package:pay_qr/services/show_toast.dart';

import '../services/image_saver.dart';
import '../services/upload_image.dart';

class QrGenerateScreen extends StatefulWidget {
  const QrGenerateScreen({Key? key}) : super(key: key);

  @override
  State<QrGenerateScreen> createState() => _QrGenerateScreenState();
}

class _QrGenerateScreenState extends State<QrGenerateScreen>
    with BaseController {
  Logger log = Logger();

  File? imageFile;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    profileController.getProfile();
  }

  FirebaseStorage storage = FirebaseStorage.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  String? imgUrl;
  // late String qrImgUrl;
  //Create an instance of ScreenshotController
  final GlobalKey _globalKey = GlobalKey();

  //* Controllers
  final qrController = Get.find<ProductController>();
  final profileController = Get.find<ProfileController>();

  Future pickImage() async {
    log.i('add Image');
    // final picker = ImagePicker();
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        imageQuality: 50,
      );

      // final String fileName = path.basename(pickedImage!.path);
      setState(() {
        imageFile = File(pickedImage!.path);
      });
      log.d(imageFile?.path);
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
                              data: qrController.data.value,
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
                    textController: _nameController),
                RoundedInputField(
                  hintText: "Enter Item Description",
                  maxLines: 4,
                  icon: Icons.description_rounded,
                  textController: _descController,
                ),
                RoundedInputField(
                  hintText: "Enter Item Price",
                  textInputType: TextInputType.number,
                  icon: Icons.monetization_on_rounded,
                  textController: _priceController,
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
                          Product product;
                          final String name = _nameController.text;
                          final String price = _priceController.text;
                          final String description = _descController.text;

                          if (_nameController.text.trim().isNotEmpty &&
                              _nameController.text.trim().isNotEmpty &&
                              _nameController.text.trim().isNotEmpty &&
                              imageFile != null) {
                            //? saving the product to database and savinf Db ref to Qr
                            var progressDialog = getProgressDialog(
                                title: 'Product ',
                                msg: 'Uploading Image...',
                                context: context);
                            progressDialog.show();
                            //showLoading('Adding ...');
                            await uploadImage(imageFile: imageFile!, metaData: {
                              'name': _nameController.text,
                              'description': _descController.text
                            });
                            progressDialog
                                .setMessage(const Text('Saving Product...'));
                            //? Add Product Details Here
                            product = Product(
                              description: description,
                              price: double.parse(price),
                              title: name,
                              imageUrl: imgUrl ?? kDefaultImgUrl,
                            );
                            await qrController.saveProduct(product);
                            // hideLoading();
                            progressDialog.dismiss();
                            log.i("Product Added");
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
                          if (qrController.data.value.trim().isNotEmpty) {
                            var progress = getProgressDialog(
                                title: 'QR Code Image',
                                msg: 'Saving....',
                                context: context);
                            progress.show();
                            await captureAndSavePng(
                                globalKey: _globalKey,
                                name: _nameController.text.trim().isEmpty
                                    ? "image"
                                    : _nameController.text.trim());
                            log.i("Qr Saved");
                            progress.dismiss();
                            showToast(
                                msg: "Qr Code Image Saved",
                                backColor: Colors.green,
                                textColor: Colors.white);
                            // Clear the text fields
                            _nameController.text = '';
                            _priceController.text = '';
                            _descController.clear();
                            setState(() {
                              imageFile = null;
                            });
                            // resetting the qr Image Details
                            qrController.data.value = '';
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
