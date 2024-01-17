import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_travel_app/db/category_db.dart';
import 'package:new_travel_app/db/destination_details_db.dart';
import 'package:new_travel_app/models/category.dart';

import 'package:new_travel_app/models/destination_details.dart';

import 'package:new_travel_app/others/contants.dart';
import 'package:new_travel_app/refracted_widgets/app_string.dart';
import 'package:new_travel_app/screen/screen_home/pageview_image.dart';
import 'package:new_travel_app/screen/screen_home/title_text.dart';
import 'package:new_travel_app/screen/screen_home/image_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DestinationModels> items = [];
  // List<CategoryModels> newiItems = [];
  List<String> newiItems = [];

  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    fetchCategory();
    fetchnewCategory();
    startHintTextTimer();
    // Auto slide every 3 seconds
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void fetchCategory() async {
    List<dynamic> fetchedItems;
    fetchedItems = await DestinationDb.singleton.getDestination();
    setState(() {
      items = fetchedItems.cast<DestinationModels>();
    });
  }

 void fetchnewCategory() async {
  List<CategoryModels> fetchedItems;
  fetchedItems = await CategoryDb.singleton.getCategory();
  setState(() {
     newiItems = fetchedItems.map((category) => category.category).toList();
  });
}

  List<Widget> generateCategoryWidgets(List<String> categories) {
    List<Widget> categoryWidgets = [];

    for (var category in categories) {
      categoryWidgets.add(titleText(category));
      categoryWidgets.add(buildCategorySliverList(items, category));
    }

    return categoryWidgets;
  }

  @override
  void dispose() {
    _timer
        ?.cancel(); // Cancel the timer to prevent calling setState after dispose
    _pageController.dispose();
    super.dispose();
  }
final List<String> initialCategories = [
  AppStrings.popularDestination,
  AppStrings.europe,
  AppStrings.africa,
  AppStrings.southAmerica,
  AppStrings.northAmerica,
  AppStrings.asia,
];
  List<String> suggestions = [
    'Explore a "country"',
    'Explore "mountains"',
    'Explore "beaches"',
    'Explore "desearts"',
    // Add more suggestions as needed
  ];
  int _currentSuggestionIndex = 0;
  void startHintTextTimer() {
    _timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (mounted) {
        setState(() {
          if (_currentSuggestionIndex < suggestions.length - 1) {
            _currentSuggestionIndex++;
          } else {
            _currentSuggestionIndex = 0;
          }
        });
      } else {
        timer.cancel(); // Cancel the timer if the widget is no longer mounted
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final usesrName = ModalRoute.of(context)?.settings.arguments as String?;
   final dropdownItems = [
    ...initialCategories, // Include initial categories
    ...newiItems, // Include newly created categories
  ];
    return Scaffold(
        body: Stack(children: [
      CustomScrollView(
        slivers: [
          SliverAppBar(
              stretch: true,
              automaticallyImplyLeading: false,
              expandedHeight: 300.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Stack(children: [
                    PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        children: [
                          pageviewImage('assets/image/india.jpg', 'India',
                              "Explore India's timeless allure, where every corner narrates \na captivating tale of heritage and wonder."),
                          pageviewImage('assets/image/italy.jpg', 'Italy',
                              '''Italy, in southern Europe, is renowned for its history, art, and\n delectable cuisine.Iconic landmarks like the Colosseum'''),
                          pageviewImage('assets/image/uk.jpg', 'United Kingdom',
                              'The United Kingdom, often called the UK, is a country located off\n the northwestern coast of mainland Europe')
                        ]),
                    Positioned(
                      top: 70,
                      left: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Hi $usesrName',
                          style: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                          children: List.generate(
                              3, (index) => animatedGreenBar(index))),
                    )
                  ])),
              title: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: SizedBox(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ], // Set border radius if needed
                    ),
                    child: TextFormField(
                      // controller: _usernameController,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        icon: const Padding(
                          padding: EdgeInsets.only(
                            left: 40,
                            top: 3,
                          ),
                          child: Icon(
                            Icons.search,
                            color: Constants.greenColor,
                          ),
                        ),
                        hintText: suggestions[_currentSuggestionIndex],
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 15),
                      ),
                    ),
                  ),
                ),
              )),
          // titleText('Popular Destination'),
          // buildCategorySliverList(items, AppStrings.popularDestination),
          // titleText('Europe'),
          // buildCategorySliverList(items, AppStrings.europe),
          // titleText('Africa'),
          // buildCategorySliverList(items, AppStrings.africa),
          // titleText('South America'),
          // buildCategorySliverList(items, AppStrings.southAmerica),
          // titleText('North America'),
          // buildCategorySliverList(items, AppStrings.northAmerica),
          // titleText('Asia'),
          // buildCategorySliverList(items, AppStrings.asia),
          ...generateCategoryWidgets(dropdownItems),
        ],
      ),
    ]));
  }

  Widget animatedGreenBar(int index) {
    return AnimatedContainer(
      duration: const Duration(seconds: 3),
      // curve: Curves.linear,
      margin: const EdgeInsets.all(5),
      width: 25,
      height: 3,
      decoration: BoxDecoration(
        color: _currentPage == index ? const Color(0xFF00CEC9) : Colors.grey,
      ),
    );
  }
}
