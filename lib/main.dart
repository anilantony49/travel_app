import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_travel_app/models/africa.dart';
import 'package:new_travel_app/models/asia.dart';
import 'package:new_travel_app/models/authentication.dart';
import 'package:new_travel_app/models/europe.dart';
import 'package:new_travel_app/models/north_america.dart';
import 'package:new_travel_app/models/planned_trip.dart';
import 'package:new_travel_app/models/popular_destination.dart';
import 'package:new_travel_app/models/south_america.dart';
import 'package:new_travel_app/screen/first_screen/splash_screen.dart';
import 'package:new_travel_app/screen/first_screen/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

const saveKey = 'isLoggedIn';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AuthenticationModelsAdapter());
  Hive.registerAdapter(PopularDestinationModelsAdapter());
  Hive.registerAdapter(EuropeDestinationModelsAdapter());
  Hive.registerAdapter(AfricaDestinationModelsAdapter());
  Hive.registerAdapter(NorthAmericaDestinationModelsAdapter());
  Hive.registerAdapter(SouthAmericaDestinationModelsAdapter());
  Hive.registerAdapter(AsiaDestinationModelsAdapter());
  Hive.registerAdapter(PlannedTripModelsAdapter());

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
