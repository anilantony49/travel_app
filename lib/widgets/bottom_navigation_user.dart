import 'package:flutter/material.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/refracted%20widgets/app_colors.dart';
import 'package:new_travel_app/screen/account/account_page.dart';
import 'package:new_travel_app/screen/favorite/favorite_page.dart';
import 'package:new_travel_app/screen/home/home_page.dart';
import 'package:new_travel_app/screen/trips/planned_trips.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key, this.selectedItem});
  final DestinationModels? selectedItem;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    _pages = [
      const HomePage(),
      const PlannedTrip(),
      FavoritePage(selectedItem: widget.selectedItem),
      const AccountPage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 10,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.greenColor,
        unselectedItemColor: AppColors.blackColor,
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
