import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/refracted_class/app_background.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';
import 'package:new_travel_app/screen/account/account_page.dart';
import 'package:new_travel_app/screen/favorite/favorite_page.dart';
import 'package:new_travel_app/screen/home/home_page.dart';
import 'package:new_travel_app/screen/trips/planned_trips.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    super.key,
    this.selectedItem,
  });
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

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.calendar_month,
    Icons.favorite_border_sharp,
    Icons.person_outline_sharp
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.linearGradientColor2,
      body: BackgroundColor(child: _pages[_currentIndex]),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.15),
                    blurRadius: 30,
                    offset: const Offset(0, 10))
              ],
              borderRadius: BorderRadius.circular(50)),
          height: screenWidth * .155,
          child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * .024),
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      setState(() {
                        _currentIndex = index;
                        HapticFeedback.lightImpact();
                      });
                    },
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: screenWidth * .2125,
                          child: Center(
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.fastLinearToSlowEaseIn,
                              height: index == _currentIndex
                                  ? screenWidth * .12
                                  : 0,
                              width: index == _currentIndex
                                  ? screenWidth * .2125
                                  : 0,
                              decoration: BoxDecoration(
                                  color: index == _currentIndex
                                      ? AppColors.greenColor.withOpacity(.2)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth * .2125,
                          alignment: Alignment.center,
                          child: Icon(
                            listOfIcons[index],
                            size: screenWidth * .076,
                            color: index == _currentIndex
                                ? AppColors.greenColor
                                : AppColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ))),
    );
  }
}
