import 'package:flutter/material.dart';
import 'package:new_travel_app/admin/category_page.dart';
import 'package:new_travel_app/others/contants.dart';

final List<Widget> _pages = [
  const CategoriesPage(),
  const CategoriesPage(),
];

class BottomNavigationAdmin extends StatefulWidget {
  const BottomNavigationAdmin({super.key});

  @override
  State<BottomNavigationAdmin> createState() => _BottomNavigationAdminState();
}

class _BottomNavigationAdminState extends State<BottomNavigationAdmin> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.scaffoldColor,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 10,
        showUnselectedLabels: true,
        selectedItemColor: Constants.greenColor,
        unselectedItemColor: Constants.blackColor,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: 'Details',
          ),
        ],
      ),
    );
  }
}
