import 'package:flutter/material.dart';
import 'package:new_travel_app/main.dart';
import 'package:new_travel_app/screen/login_screen.dart';
import 'package:new_travel_app/widgets/bottom_navigation_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUserLogin();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage(
          'assets/image/splashscreen.jpg',
        ),
        fit: BoxFit.fill,
      )),
    ));
  }

  Future<void> _checkUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   final value=prefs.getBool(saveKey);
   if(value==null||value==false){
 gotoLogin();
   }else{
     // ignore: use_build_context_synchronously
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>
    const BottomNavigation()
  ));
   }
    
  }

  Future<void> gotoLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return const LoginPage();
    }));
  }
}
