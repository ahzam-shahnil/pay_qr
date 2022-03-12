// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:logger/logger.dart';

Logger logger = Logger();
const kChatBotUrl = 'http://10.0.2.2:8080/';
const kError = "Something went wrong";
const kScanDescText =
    'Scan products you want to buy at your favorite store and pay by your phone & enjoy happy, friendly Shopping!';

const kPrimaryColor = Color(0xff978ae0);
const kPrimaryDarkColor = Color(0xFF52439A);

const kPlaceHolderImg = "assets/images/placeholder.png";
const kDefaultImgUrl =
    'https://firebasestorage.googleapis.com/v0/b/pay-qr-b5905.appspot.com/o/placeholder.png?alt=media&token=6b5c9aab-83a8-48b9-8149-db666bfed60d';

const kActiveBtnColor = Color(0xFFFE725D);
const kBtnColor = Color(0xFF30475E);
const kScanBackColor = Color(0xfffff7f6);
const kAppBarPrefSize = Size(double.infinity, 56.0);
// const kScaffoldBgColor = Color(0xff121212);

enum kUsers { merchant, user }

//? User Data Names
// const kAdminData = 'adminData';
const kMerchantDb = 'retailerData';
// const kProductDb = 'productData';
const kUserDb = 'userData';
const kProfileCollection = 'profile';
const kProductCollection = 'products';
const kUserIdDoc = 'uid';

const kUserCredSharedPrefKey = 'userCredential';
const kUserTypeSharedPrefKey = 'userType';