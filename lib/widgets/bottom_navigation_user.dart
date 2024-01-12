import 'package:flutter/material.dart';
import 'package:new_travel_app/others/contants.dart';
import 'package:new_travel_app/screen/account_page.dart';
import 'package:new_travel_app/screen/favorite_page.dart';
import 'package:new_travel_app/screen/trips/planned_trips.dart';
import 'package:new_travel_app/screen/screen_home/home_page.dart';

final List<Widget> _pages = [
  const HomePage(),
  const PlannedTrip(),
  const FavoritePage(),
  const AccountPage(),
];

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
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
            icon: Icon(Icons.calendar_month),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_sharp),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_sharp),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
