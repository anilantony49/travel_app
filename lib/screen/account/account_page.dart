import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_travel_app/db/authentication_db.dart';
import 'package:new_travel_app/models/authentication.dart';
import 'package:new_travel_app/refracted_class/app_background.dart';
import 'package:new_travel_app/refracted_class/app_toolbarsearch.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';
import 'package:new_travel_app/refracted_widgets/app_string.dart';
import 'package:new_travel_app/screen/account/about.dart';
import 'package:new_travel_app/screen/account/edit_profile.dart';
import 'package:new_travel_app/screen/account/privacy_policy.dart';
import 'package:new_travel_app/screen/account/terms_and_conditions.dart';
import 'package:new_travel_app/screen/account/text_widget.dart';
import 'package:new_travel_app/screen/authentication/login_screen.dart';
import 'package:new_travel_app/screen/favorite/favorite_page.dart';
import 'package:new_travel_app/screen/trips/planned_trips.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({
    super.key,
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  AuthenticationModels? currentUser;
  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
  }

  void fetchCurrentUser() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final String? userId = sharedPrefs.getString('current_user_id');

    if (userId != null) {
      currentUser = await AuthenticationDb.singleton.getCurrentUser(userId);
    }

    setState(() {}); // Update UI after fetching user data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: AppBarwidget(title: 'Account', textStyle: GoogleFonts.alata()),
        body: BackgroundColor(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, top: 50),
            child: ListView(
              children: [
                textwidget(AppStrings.editProfile, () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                    builder: (context) => EditProfile(currentUser: currentUser),
                  ))
                      .then((result) {
                    if (result == true) {
                      // Update UI or perform any necessary actions
                      fetchCurrentUser(); // Update the current user information
                    }
                  });
                }),
                textwidget(AppStrings.favorite, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const FavoritePage()));
                }),
                textwidget(AppStrings.myTrips, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PlannedTrip()));
                }),
                textwidget(AppStrings.about, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AboutPage()));
                }),
                textwidget(AppStrings.privacyPolicy, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PrivacyPolicy()));
                }),
                textwidget(AppStrings.termsAndCondition, () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TermsAndConditons()));
                }),
                textwidget(AppStrings.logOut, () {
                  _alertBox(context);
                }),
              ],
            ),
          ),
        ));
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
      content: Text(AppStrings.logOutMessage),
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
            title: Text(
              AppStrings.logOut,
              style: GoogleFonts.alata(),
            ),
            content: Text(
              AppStrings.logoutConfirmation,
              style: GoogleFonts.alata(),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    _logoutAndExit(context);
                  },
                  child: Text(
                    'Yes',
                    style: GoogleFonts.alata(),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'No',
                    style: GoogleFonts.alata(),
                  ))
            ],
          );
        });
  }
}
