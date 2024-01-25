import 'package:flutter/material.dart';
import 'package:new_travel_app/refracted%20widgets/app_colors.dart';
import 'package:new_travel_app/screen/authentication/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        backgroundColor: AppColors.greenColor,
        centerTitle: true,
        title: const Text('Profile'),
        actions: [
          IconButton(
              onPressed: () {
                _alertBox(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Container(
         width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 41, 199, 201),
              Color(0xFFE4EfE9),
            ], // Adjust colors to your liking
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Account page'),
            ],
          ),
        ),
      ),
    );
  }

  void _logoutAndExit(BuildContext context) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.clear();
    // Navigate back to the login page
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginPage()),
        (route) => false);
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Logout succesfully'),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(10),
    ));
  }

  void _alertBox(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            title: const Text("Logout"),
            content: const Text('Are you sure want to logout?'),
            actions: [
              TextButton(
                  onPressed: () {
                    _logoutAndExit(context);
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }
}
