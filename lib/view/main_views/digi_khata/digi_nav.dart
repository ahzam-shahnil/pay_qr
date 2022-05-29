import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:permission_handler/permission_handler.dart';

import 'add_customer/contact_view.dart';
import 'cashbook.dart';
import 'digi_khata_view.dart';

class DigiNavHome extends StatefulWidget {
  const DigiNavHome({Key? key}) : super(key: key);

  @override
  State<DigiNavHome> createState() => _DigiNavHomeState();
}

class _DigiNavHomeState extends State<DigiNavHome> {
  _getPermission() async {
    if (await Permission.contacts.request().isGranted) {
      Get.to(
        () => const ContactView(),
      );
    }
  }

  int selectedIndex = 0;

  final padding = const EdgeInsets.symmetric(horizontal: 40, vertical: 12);
  double gap = 20;

  PageController controller = PageController();

  List<Widget> pages = [const DigiKhataView(), const CashBook()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size(
          double.infinity,
          56.0,
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AppBar(
              title: Text(
                'Digi Khata',
                style: Get.textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: const [],
            ),
          ),
        ),
      ),
      body: PageView.builder(
        onPageChanged: (page) {
          setState(() {
            selectedIndex = page;
          });
        },
        controller: controller,
        itemBuilder: (context, position) {
          return pages[position];
        },
        itemCount: 2,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          _getPermission();
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        label: const Text(
          'Add customer',
          // style: Get.textTheme.headline6,
        ),
        icon: const Icon(Icons.add),
        backgroundColor: kPrimaryColor,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            boxShadow: [
              BoxShadow(
                spreadRadius: -10,
                blurRadius: 60,
                color: Colors.black.withOpacity(.4),
                offset: const Offset(0, 25),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 3),
            child: GNav(
              tabs: [
                GButton(
                  gap: gap,
                  iconActiveColor: Colors.purple,
                  iconColor: Colors.black,
                  textColor: Colors.purple,
                  backgroundColor: Colors.purple.withOpacity(.2),
                  iconSize: 24,
                  padding: padding,
                  icon: LineIcons.home,
                  text: 'Khata',
                ),
                GButton(
                  gap: gap,
                  iconActiveColor: Colors.teal,
                  iconColor: Colors.black,
                  textColor: Colors.teal,
                  backgroundColor: Colors.teal.withOpacity(.2),
                  iconSize: 24,
                  padding: padding,
                  icon: LineIcons.cashRegister,
                  text: 'CashBook',
                )
              ],
              selectedIndex: selectedIndex,
              onTabChange: (index) {
                setState(() {
                  selectedIndex = index;
                });
                controller.jumpToPage(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
