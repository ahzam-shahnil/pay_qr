import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pay_qr/config/app_constants.dart';

import 'cashbook.dart';
import 'digi_khata_view.dart';

class DigiNavHome extends StatefulWidget {
  const DigiNavHome({Key? key}) : super(key: key);

  @override
  State<DigiNavHome> createState() => _DigiNavHomeState();
}

class _DigiNavHomeState extends State<DigiNavHome> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[DigiKhataView(), CashBook()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey.shade400,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Khata',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                LineIcons.cashRegister,
              ),
              label: 'CashBook',
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: kPrimaryColor,
          iconSize: 25,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
