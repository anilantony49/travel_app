import 'dart:async';

import 'package:flutter/material.dart';
import 'package:new_travel_app/db/africa_db.dart';
import 'package:new_travel_app/db/asia_db.dart';
import 'package:new_travel_app/db/europe_db.dart';
import 'package:new_travel_app/db/north_america_db.dart';
import 'package:new_travel_app/db/popular_destination_db.dart';
import 'package:new_travel_app/db/south_america_db.dart';
import 'package:new_travel_app/models/africa.dart';
import 'package:new_travel_app/models/asia.dart';
import 'package:new_travel_app/models/europe.dart';
import 'package:new_travel_app/models/north_america.dart';
import 'package:new_travel_app/models/popular_destination.dart';
import 'package:new_travel_app/models/south_america.dart';
import 'package:new_travel_app/others/contants.dart';
import 'package:new_travel_app/screen/screen_home/pageview_image.dart';
import 'package:new_travel_app/screen/screen_home/title_text.dart';
import 'package:new_travel_app/screen/screen_home/image_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PopularDestinationModels> items = [];
  List<EuropeDestinationModels> europeItems = [];
  List<AfricaDestinationModels> africaItems = [];
  List<SouthAmericaDestinationModels> southAmericaItems = [];
  List<NorthAmericaDestinationModels> northAmericaItems = [];
  List<AsiaDestinationModels> asiaItems = [];

  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    fetchCategory('Popular Destination');
    fetchCategory('Europe');
    fetchCategory('Africa');
    fetchCategory('South America');
    fetchCategory('North America');
    fetchCategory('Asia');

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

  void fetchCategory(String category) async {
    List<dynamic> fetchedItems;

    if (category == 'Popular Destination') {
      fetchedItems = await PopularDestinationDb.singleton.getCountries();
      setState(() {
        items = fetchedItems.cast<PopularDestinationModels>();
      });
    } else if (category == 'Europe') {
      fetchedItems = await EuropeDb.singleton.getCountries();
      setState(() {
        europeItems = fetchedItems.cast<EuropeDestinationModels>();
      });
    } else if (category == 'Africa') {
      fetchedItems = await AfricaDb.singleton.getCountries();
      setState(() {
        africaItems = fetchedItems.cast<AfricaDestinationModels>();
      });
    } else if (category == 'South America') {
      fetchedItems = await SouthAmericaDb.singleton.getCountries();
      setState(() {
        southAmericaItems = fetchedItems.cast<SouthAmericaDestinationModels>();
      });
    } else if (category == 'North America') {
      fetchedItems = await NorthAmericaDb.singleton.getCountries();
      setState(() {
        northAmericaItems = fetchedItems.cast<NorthAmericaDestinationModels>();
      });
    } else {
      fetchedItems = await AsiaDb.singleton.getCountries();
      setState(() {
        asiaItems = fetchedItems.cast<AsiaDestinationModels>();
      });
    }
  }

  @override
  void dispose() {
    _timer
        ?.cancel(); // Cancel the timer to prevent calling setState after dispose
    _pageController.dispose();
    super.dispose();
  }

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
    return Scaffold(
        // backgroundColor: Constants.scaffoldColor,
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
                          'Welcome $usesrName',
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
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
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.sort_sharp,
                          weight: 50,
                        ))),
              ],
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
          titleText('Popular Destination'),
          buildCategorySliverList('Popular Destination', items),
          titleText('Europe'),
          buildCategorySliverList('Europe', europeItems),
          titleText('Africa'),
          buildCategorySliverList('Africa', africaItems),
          titleText('South America'),
          buildCategorySliverList('South America', southAmericaItems),
          titleText('North America'),
          buildCategorySliverList('North America', northAmericaItems),
          titleText('Asia'),
          buildCategorySliverList('Asia', asiaItems),
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
