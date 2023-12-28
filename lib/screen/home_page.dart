import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_travel_app/db/popular_destination_db.dart';
import 'package:new_travel_app/models/popular_destination.dart';
import 'package:new_travel_app/others/contants.dart';
import 'package:new_travel_app/screen/show_detail_description.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PopularDestinationModels> items = [];

  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    fetchCategory();
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
    List<PopularDestinationModels> fetchedCategories =
        await PopularDestinationDb.singleton.getCountries();
    setState(() {
      items = fetchedCategories;
    });
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
  // bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();
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
        backgroundColor: Constants.scaffoldColor,
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
                              pageviewImage(
                                  'assets/image/uk.jpg',
                                  'United Kingdom',
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    child: SizedBox(
                      // width: screenWidth * 0.85,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white70, // Set the background color
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(0.2), // Shadow color
                              spreadRadius: 2, // Spread radius
                              blurRadius: 5, // Blur radius
                              offset:
                                  const Offset(0, 2), // Offset in x and y axes
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
              // imageContainer(items[_currentPage]),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 150.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShowDetailsPage(
                                        selectedItem: items[index]),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 135,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 231, 228, 228),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        // offset: const Offset(0, 1),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          136, 171, 164, 164),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: Image.file(
                                              File(items[index].countryImage),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          items[index].countryName,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
              titleText('Europe'),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 150.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShowDetailsPage(
                                        selectedItem: items[index]),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 135,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 231, 228, 228),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        // offset: const Offset(0, 1),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          136, 171, 164, 164),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: Image.file(
                                              File(items[index].countryImage),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          items[index].countryName,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
              titleText('Africa'),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 150.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ShowDetailsPage(
                                        selectedItem: items[index]),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 135,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 231, 228, 228),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        // offset: const Offset(0, 1),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          136, 171, 164, 164),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                            child: Image.file(
                                              File(items[index].countryImage),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          items[index].countryName,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
              titleText('South America'),
              titleText('North America'),
              titleText('Asia')
            ],
          ),
        ]));
  }

  Widget pageviewImage(
    String image,
    String name,
    String text,
  ) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.maxFinite,
        ),
        Positioned(
          left: 0,
          bottom: 40,
          child: Container(
            color:
                Colors.black.withOpacity(0.0), // Adjust the opacity as needed
            padding: const EdgeInsets.all(16.0), // Adjust padding as needed
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
          left: 0,
          bottom: 5,
          child: Container(
            color:
                Colors.black.withOpacity(0.0), // Adjust the opacity as needed
            padding: const EdgeInsets.all(16.0), // Adjust padding as needed
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
              // textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget titleText(String text) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 25,
                fontWeight: FontWeight.w900,
                decoration: TextDecoration.none,
                // letterSpacing: 1.5,
              ),
            ),
          );
        },
        childCount: 1,
      ),
    );
  }

  Widget imageContainer( PopularDestinationModels selectedItem, ) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 150.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ShowDetailsPage(selectedItem: items[index]),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 135,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 231, 228, 228),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 2,
                              // offset: const Offset(0, 1),
                            ),
                          ],
                          border: Border.all(
                            color: const Color.fromARGB(136, 171, 164, 164),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.file(
                                    File(items[index].countryImage),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                               items[index].countryName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
        childCount: 1,
      ),
    );
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
// import 'package:flutter/material.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }