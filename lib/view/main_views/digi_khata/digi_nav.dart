import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/view/main_views/digi_khata/cashbook_screen.dart';
import 'package:pay_qr/widgets/digi_khata/reuseable_button.dart';

import 'add_customer/add_customers_record.dart';
import 'digi_khata_view.dart';

class DigiNavHome extends StatefulWidget {
  final int? selectedScreen;
  const DigiNavHome({Key? key, this.selectedScreen}) : super(key: key);

  @override
  State<DigiNavHome> createState() => _DigiNavHomeState();
}

class _DigiNavHomeState extends State<DigiNavHome> {
  late int selectedIndex;
  late PageController controller;
  @override
  void initState() {
    selectedIndex = widget.selectedScreen ?? 0;
    controller = PageController(initialPage: selectedIndex);
    super.initState();
  }

  final padding = const EdgeInsets.symmetric(horizontal: 40, vertical: 12);
  double gap = 20;

  List<Widget> pages = [const DigiKhataView(), const CashBookScreen()];

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
                selectedIndex == 0 ? 'Digi Khata' : 'CashBook',
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
      floatingActionButton: selectedIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () async {
                digiController.getPermissionAndGotoContactView();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              label: const Text(
                'Add customer',
                // style: Get.textTheme.headline6,
              ),
              icon: const Icon(Icons.add),
              backgroundColor: kPrimaryColor,
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ReusableButton(
                      color: Colors.green,
                      text: "Cash In",
                      onpress: () {
                        Get.to(() => const AddCustomerRecord(
                              isFromCashBook: true,
                              isMainDiye: false,
                            ));
                      },
                    ),
                  ),
                  SizedBox(
                    width: kWidth * 0.02,
                  ),
                  Expanded(
                    child: ReusableButton(
                      color: Colors.red,
                      text: "Cash Out",
                      onpress: () {
                        Get.to(() => const AddCustomerRecord(
                              isFromCashBook: true,
                              isMainDiye: true,
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
