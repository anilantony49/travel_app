import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_travel_app/models/authentication.dart';
import 'package:new_travel_app/screen/splash_screen.dart';
import 'package:new_travel_app/screen/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
const saveKey = 'isLoggedIn';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AuthenticationModelsAdapter());

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool welcomeScreenShown = prefs.getBool('welcomeScreenShown') ?? false;
  runApp(MyApp(welcomeScreenShown: welcomeScreenShown));
}

class MyApp extends StatelessWidget {
  final bool welcomeScreenShown;
  const MyApp({super.key, required this.welcomeScreenShown});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel app',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: welcomeScreenShown ? const SplashScreen() : const WelcomePage(),
    );
  }
}
