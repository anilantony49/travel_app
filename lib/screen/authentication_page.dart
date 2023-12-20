import 'dart:async';

import 'package:flutter/material.dart';
import 'package:new_travel_app/others/contants.dart';
import 'package:new_travel_app/screen/login_screen.dart';
import 'package:new_travel_app/screen/sign_up_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
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

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    Widget height = SizedBox(
      height: screenHeight * 0.02,
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.5 - statusBarHeight,
                width: screenWidth,
                child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    children: [
                      Image.asset(
                        'assets/image/authentication_image_1.png',
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/image/authentication_image_2.png',
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        'assets/image/authentication_image_3.png',
                        fit: BoxFit.cover,
                      ),
                    ]),
              ),
              height,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => buildDot(index),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              textWidget(
                'Plan your Trip',
                25,
                Constants.blackColor,
                FontWeight.w900,
              ),
              height,
              textWidget(
                'Custom and fast planning',
                13,
                Constants.blackColor,
                null,
              ),
              textWidget('With a low price', 13, Constants.blackColor, null),
              SizedBox(
                height: screenHeight * 0.09,
              ),
              SizedBox(
                  width: screenWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      backgroundColor:
                          const Color(0xFF00CEC9), // Set the background color
                    ),
                    child: textWidget(
                        'Log in', null, Colors.white, FontWeight.w700),
                  )),
              height,
              SizedBox(
                  width: screenWidth * 0.8,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      backgroundColor: Colors.white,
                    ),
                    child: textWidget(
                        'Create Account', null, Colors.black, FontWeight.w700),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? const Color(0xFF00CEC9) : Colors.grey,
      ),
    );
  }

  Widget textWidget(
      String text, double? fontSize, Color color, FontWeight? fontWeight) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
       
      ),
    );
  }

 
}