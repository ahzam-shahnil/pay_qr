// Dart imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pay_qr/config/app_constants.dart';

// Project imports:
import '../../intro_views/scan_intro_screen.dart';
import '../profile/profile_screen.dart';
import 'home_screen.dart';

class NavHomeScreen extends StatefulWidget {
  const NavHomeScreen({Key? key}) : super(key: key);

  @override
  State<NavHomeScreen> createState() => _NavHomeScreenState();
}

class _NavHomeScreenState extends State<NavHomeScreen> {
  int selectedIndex = 0;

  final padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 12);
  double gap = 10;

  PageController controller = PageController();

  List<Widget> pages = [
    const HomeScreen(),
    // const PaymentHistoryScreen(),
    const ScanIntroScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: kScanBackColor,
      // appBar: PreferredSize(
      //   preferredSize: const Size(
      //     double.infinity,
      //     56.0,
      //   ),
      //   child: ClipRRect(
      //     child: BackdropFilter(
      //       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      //       child: AppBar(
      //         title: Text(
      //           kAppName,
      //           style: Get.textTheme.headline6?.copyWith(
      //             fontWeight: FontWeight.w700,
      //           ),
      //         ),
      //         actions: const [],
      //       ),
      //     ),
      //   ),
      // ),
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       Obx(() => UserAccountsDrawerHeader(
      //           decoration: const BoxDecoration(color: kPrimaryDarkColor),
      //           accountName:
      //               Text(userController.userModel.value.fullName ?? ""),
      //           accountEmail:
      //               Text(userController.userModel.value.email ?? ""))),
      //       ListTile(
      //         leading: const Icon(Icons.book),
      //         title: const CustomText(
      //           text: "Payments History",
      //         ),
      //         onTap: () async {
      //           //TODO: add payment controller here
      //           // paymentsController.getPaymentHistory();
      //         },
      //       ),
      //       ListTile(
      //         onTap: () async {
      //           await AuthHelperFirebase.signOutAndCacheClear();
      //           Get.offAll(() => const LoginScreen());
      //         },
      //         leading: const Icon(Icons.exit_to_app),
      //         title: const Text("Log out"),
      //       )
      //     ],
      //   ),
      // ),
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
        itemCount: 3,
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
                  iconActiveColor: kPrimaryColor,
                  iconColor: kPrimaryColor,
                  textColor: kPrimaryColor,
                  backgroundColor: kPrimaryColor.withOpacity(.2),
                  iconSize: 24,
                  padding: padding,
                  icon: LineIcons.home,
                  text: 'Home',
                ),

                //TODO: fix issue here for the payment screen
                // GButton(
                //   gap: gap,
                //   iconActiveColor: Colors.pink,
                //   iconColor: Colors.black,
                //   textColor: Colors.pink,
                //   backgroundColor: Colors.pink.withOpacity(.2),
                //   iconSize: 24,
                //   padding: padding,
                //   icon: LineIcons.cashRegister,
                //   text: 'Payments',
                // ),
                GButton(
                  gap: gap,
                  iconActiveColor: kPrimaryColor,
                  iconColor: kPrimaryColor,
                  textColor: kPrimaryColor,
                  backgroundColor: kPrimaryColor.withOpacity(.2),
                  iconSize: 24,
                  padding: padding,
                  icon: LineIcons.shoppingCart,
                  text: 'Shop',
                ),
                GButton(
                  gap: gap,
                  iconActiveColor: kPrimaryColor,
                  iconColor: kPrimaryColor,
                  textColor: kPrimaryColor,
                  backgroundColor: kPrimaryColor.withOpacity(.2),
                  iconSize: 24,
                  padding: padding,
                  icon: LineIcons.user,
                  // leading: const CircleAvatar(
                  //   radius: 12,
                  //   backgroundImage: NetworkImage(
                  //     'https://sooxt98.space/content/images/size/w100/2019/01/profile.png',
                  //   ),
                  // ),
                  text: 'Profile',
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
