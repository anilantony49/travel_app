// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:new_travel_app/admin/destinations_screen.dart';
import 'package:new_travel_app/db/authentication_db.dart';
import 'package:new_travel_app/main.dart';
import 'package:new_travel_app/models/authentication.dart';
import 'package:new_travel_app/others/admin_credentials.dart';
import 'package:new_travel_app/refracted%20widgets/app_string.dart';
import 'package:new_travel_app/widgets/bottom_navigation_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final GlobalKey<FormState> formKey = GlobalKey<FormState>();

Future<void> loginFunction(BuildContext context, TextEditingController username,
    TextEditingController password, GlobalKey<FormState> formKey) async {
  if (username.text == AdminCredentials.username &&
      password.text == AdminCredentials.password) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const DestintationScreen(),
      ), // Replace YourNextScreen with the actual screen widget you want to navigate to
      (route) => false,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(AppStrings.welcomeAdmin),
        duration: Duration(seconds: 2),
      ),
    );
  } else if (formKey.currentState?.validate() ?? false) {
    // Access the users list from the userNotifier value
    List<AuthenticationModels> users =
        AuthenticationDb.singleton.userNotifier.value;

    // Replace 'enteredUsername' and 'enteredPassword' with the actual values entered by the user

    String enteredUsername = username.text;
    String enteredPassword = password.text;

    // Check if entered username and password match any user details
    bool isUserAuthenticated = users.any((user) =>
        user.username == enteredUsername && user.password == enteredPassword);

    // Clear the text fields
    username.clear();
    password.clear();
    // Unfocus the text fields to hide the keyboard
    FocusScope.of(context).unfocus();

    if (isUserAuthenticated) {
      final sharedpref = await SharedPreferences.getInstance();
      sharedpref.setBool(saveKey, true);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavigation(),
          settings: RouteSettings(arguments: enteredUsername),
        ),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.loginSuccess),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.invalidError),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
