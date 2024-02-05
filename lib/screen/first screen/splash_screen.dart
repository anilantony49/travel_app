import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_travel_app/main.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';
import 'package:new_travel_app/screen/authentication/login_screen.dart';
import 'package:new_travel_app/widgets/bottom_navigation_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _checkUserLogin();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Adjust the duration as needed
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            'assets/image/splashscreen.jpg',
          ),
          fit: BoxFit.fill,
        )),
      ),
      AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Center(
              child: Opacity(
                opacity: _animation.value,
                child: Text(
                  'Triplings',
                  style: GoogleFonts.adamina(
                      fontSize: 50, color: AppColors.blackColor,fontWeight: FontWeight.bold),
                ),
              ),
            );
          })
    ]));
  }

  Future<void> _checkUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(saveKey);
    if (value == null || value == false) {
      gotoLogin();
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const BottomNavigation()));
    }
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 4));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return const LoginPage();
    }));
  }
}
