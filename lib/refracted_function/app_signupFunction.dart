// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:new_travel_app/db/authentication_db.dart';
import 'package:new_travel_app/main.dart';
import 'package:new_travel_app/models/authentication.dart';
import 'package:new_travel_app/refracted_widgets/app_string.dart';
import 'package:new_travel_app/widgets/bottom_navigation_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> signUpFunction(
    BuildContext context,
    TextEditingController username,
    TextEditingController email,
    TextEditingController password,
    GlobalKey<FormState> formKey1) async {
  if (formKey1.currentState?.validate() ?? false) {
    bool usernameExists =
        await AuthenticationDb.singleton.usernameExists(username.text);
    if (usernameExists) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.alreadyExists),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Username doesn't exist, proceed with sign-up
      final users = AuthenticationModels(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          email: email.text,
          password: password.text,
          username: username.text,
          image: null);
      // Store the current user's ID in shared preferences
      final sharedpref = await SharedPreferences.getInstance();
      sharedpref.setString('current_user_id', users.id);
      sharedpref.setString('current_user_name', users.username);
      await AuthenticationDb.singleton.insertUsers(users);
      // Clear text fields
      username.clear();
      email.clear();
      password.clear();

      // Unfocus the text fields to hide the keyboard
      // ignore: use_build_context_synchronously
      FocusScope.of(context).unfocus();

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.accountCreated),
          duration: Duration(seconds: 2),
        ),
      );
      sharedpref.setBool(saveKey, true);

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomNavigation(),
        ),
      );
    }
  }
}
