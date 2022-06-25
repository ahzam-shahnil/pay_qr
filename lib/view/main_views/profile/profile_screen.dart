// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pay_qr/components/rectangular_password_field.dart';
import 'package:pay_qr/components/rounded_rectangular_input_field.dart';

// Project imports:

import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/utils/auth_helper_firebase.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';
import 'package:pay_qr/utils/upload_image.dart';

import '../../../controller/base_controller.dart';
import '../../../widgets/profile/profile_shimmer.dart';
import '../../../widgets/profile/profile_widget.dart';
import '../auth/login_screen.dart';
import 'chatbot_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with BaseController {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _shopNameController = TextEditingController();
  //TODO: Add money to profile model
  bool isEdit = false;
  @override
  void initState() {
    super.initState();
    refresh();
  }

  File? imageFile;

  final picker = ImagePicker();

  Future pickImage() async {
    logger.i('add Image');
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
      logger.d(imageFile?.path);
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  saveWork() {
    setState(() {
      isEdit = false;
      imageFile = null;
    });
  }

  refresh() {
    profileController.getProfile().then((value) {
      if (mounted) {
        setState(() {
          _passController.text = profileController.currentUser.value.password!;
          _nameController.text = profileController.currentUser.value.fullName!;
          if (profileController.currentUser.value.isMerchant!) {
            _shopNameController.text =
                profileController.currentUser.value.shopName!;
          }
        });
      }
    });
  }

  Future<void> saveProfile() async {
    var fullName = _nameController.text.trim();
    var shopName = _shopNameController.text.trim();

    var password = _passController.text.trim();

    if (fullName.isEmpty || password.isEmpty) {
      // show error toast

      showToast(
        msg: 'Please fill all fields',
      );
      return;
    }
    if (profileController.currentUser.value.isMerchant! && shopName.isEmpty) {
      showToast(
        msg: 'Please Shop Name',
      );
      return;
    }

    if (password.length < 6) {
      showToast(msg: 'Weak Password, at least 6 characters are required');

      return;
    }
    var progressDialog = getProgressDialog(
        context: context, msg: 'Updating', title: 'Profile Update');
    progressDialog.show();

    String? imgUrl;
    if (imageFile != null) {
      progressDialog.setMessage(const Text('Uploading Image'));
      imgUrl = await uploadImage(
          imageFile: imageFile!,
          userName: userController.userModel.value.uid.toString());
      // logger.i('Profile Image $imgUrl');
    }

    logger.d(imgUrl);
    var profile = profileController.currentUser.value.copyWith(
      fullName: _nameController.text,
      shopName: _shopNameController.text,
      password: _passController.text,
      imageUrl: imgUrl,
    );

    if (profile == profileController.currentUser.value) {
      progressDialog.dismiss();
      showToast(msg: 'Nothing to Save', backColor: Colors.grey);
      saveWork();
      return;
    }
    // logger.d(profile);
    progressDialog.setMessage(const Text('Updating Profile'));
    try {
      await profileController.updateProfile(profile, context);
    } catch (e) {
      logger.e(e);
    }
    progressDialog.dismiss();
    saveWork();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            Obx(() => profileController.isLoading.value
                ? const ProfileShimmer()
                : GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      children: [
                        Obx(() => ProfileWidget(
                              onClicked: () async {
                                logger.i('Edit Profile');

                                if (mounted) {
                                  if (!isEdit) {
                                    setState(() {
                                      isEdit = true;
                                    });
                                  } else {
                                    await pickImage();
                                  }
                                }
                              },
                              imageUrl:
                                  userController.firebaseUser.value?.photoURL,
                              imageFile: imageFile,
                              isEdit: isEdit,
                            )),
                        const SizedBox(height: 12),
                        Obx(() => RoundedRectangleInputField(
                              textCapitalization: TextCapitalization.words,
                              hintText:
                                  profileController.currentUser.value.fullName!,
                              textController: _nameController,
                              isEnabled: isEdit,
                            )),
                        const SizedBox(height: 12),
                        Obx(() => RoundedRectangleInputField(
                              hintText:
                                  profileController.currentUser.value.email!,

                              // textController: _emailController,
                              autofillHints: const [AutofillHints.email],
                              textInputType: TextInputType.emailAddress,
                              //? to make sure that email is not changed
                              isEnabled: false,
                            )),
                        const SizedBox(height: 12),
                        RectangularPasswordField(
                            isReadOnly: !isEdit,
                            textController: _passController),
                        const SizedBox(height: 12),
                        Obx(
                          () => profileController.currentUser.value.isMerchant!
                              ? Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    RoundedRectangleInputField(
                                      textCapitalization:
                                          TextCapitalization.words,
                                      isEnabled: isEdit,
                                      hintText: profileController
                                          .currentUser.value.shopName!,
                                      icon: Icons.shopping_basket_outlined,
                                      textController: _shopNameController,
                                      textInputType: TextInputType.name,
                                      autofillHints: const [
                                        AutofillHints.organizationName
                                      ],
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                        ),
                        if (isEdit) ...[
                          const SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: kWidth * 0.3,
                            ),
                            child: ElevatedButton(
                              onPressed: () => saveProfile(),
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Save',
                                style: Get.textTheme.headline6,
                              ),
                            ),
                          )
                        ],

                        if (!isEdit)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              OutlinedButton.icon(
                                // style: ElevatedButton.styleFrom(
                                //   primary: kTealColor,
                                // ),
                                onPressed: () async {
                                  await AuthHelperFirebase
                                      .signOutAndCacheClear();
                                  Get.offAll(() => const LoginScreen());
                                },
                                icon: const Icon(Icons.logout_rounded),
                                label: const Text('Logout'),
                              ),
                              OutlinedButton(
                                onPressed: () =>
                                    Get.to(() => const ChatBotScreen()),
                                child: const Text("Chat with Us"),
                              ),
                            ],
                          ),
                        //  const Text('Terms of Service'),
                        // const Text('Privacy Policy'),
                      ],
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
