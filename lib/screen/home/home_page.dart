import 'dart:async';
import 'package:flutter/material.dart';
import 'package:new_travel_app/db/authentication_db.dart';
import 'package:new_travel_app/db/category_db.dart';
import 'package:new_travel_app/db/destination_details_db.dart';
import 'package:new_travel_app/models/authentication.dart';
import 'package:new_travel_app/models/category.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';
import 'package:new_travel_app/refracted_class/app_background.dart';
import 'package:new_travel_app/refracted_function/app_functions.dart';
import 'package:new_travel_app/refracted_widgets/app_string.dart';
import 'package:new_travel_app/screen/home/pageview_image.dart';
import 'package:new_travel_app/screen/home/search_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthenticationModels? currentUser;

  List<DestinationModels> items = [];
  List<String> newiItems = [];

  final PageController _pageController = PageController();
  late String userName = '';
  int _currentPage = 0;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    loadUserName();
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
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  String _greetingMessage() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning';
    } else if (hour < 18) {
      return 'Good afternoon';
    } else {
      return 'Good evening';
    }
  }

  Future<void> loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? name = prefs.getString('current_user_name');
    String? updatedName = prefs.getString('edited_user_name');

    if (updatedName != null) {
      currentUser =
          await AuthenticationDb.singleton.getCurrentUser(updatedName);
      setState(() {
        userName = updatedName;
      });
    } else {
      String? name = prefs.getString('current_user_name');
      if (name != null) {
        currentUser = await AuthenticationDb.singleton.getCurrentUser(name);
        setState(() {
          userName = name;
        });
      }
    }
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
    AppStrings.suggestions1,
    AppStrings.suggestions2,
    AppStrings.suggestions3,
    AppStrings.suggestions4
    // Add more suggestions as needed
  ];
  int _currentSuggestionIndex = 0;
  void startHintTextTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
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
    final dropdownItems = [
      ...initialCategories, // Include initial categories
      ...newiItems, // Include newly created categories
    ];
    return Scaffold(
        body: BackgroundColor(
      child: Stack(children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
                backgroundColor: AppColors.greenColor,
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
                            pageviewImage(
                              AppStrings.pageviewAssetImage1,
                              AppStrings.pageviewImage1,
                              AppStrings.pageviewImageCountryDescription1,
                            ),
                            pageviewImage(
                              AppStrings.pageviewAssetImage2,
                              AppStrings.pageviewImage2,
                              AppStrings.pageviewImageCountryDescription2,
                            ),
                            pageviewImage(
                              AppStrings.pageviewAssetImage3,
                              AppStrings.pageviewImage3,
                              AppStrings.pageviewImageCountryDescription3,
                            )
                          ]),
                      Positioned(
                        top: 90,
                        left: 10,
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: AppColors.blackColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxHeight: double.infinity,
                                  maxWidth: double.infinity),
                              child: Text(
                                'Hi, ${_greetingMessage()}, $userName!',
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Row(
                            children: List.generate(
                                3,
                                (index) =>
                                    animatedGreenBar(index, _currentPage))),
                      )
                    ])),
                title: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.borderColor,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 2),
                        ),
                      ], // Set border radius if needed
                    ),
                    child: TextFormField(
                      textInputAction: TextInputAction.search,
                      onTap: () {
                        // Navigate to the search screen when the text field is tapped
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                SearchScreen(destination: items),
                          ),
                        );
                      },
                      style: const TextStyle(
                        color: AppColors.blackColor,
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
                            color: AppColors.greenColor,
                          ),
                        ),
                        hintText: suggestions[_currentSuggestionIndex],
                        hintStyle: TextStyle(
                          color: AppColors.black.withOpacity(0.9),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 15),
                      ),
                    ),
                  ),
                )),
            ...generateCategoryWidgets(dropdownItems, items),
          ],
        ),
      ]),
    ));
  }
}
