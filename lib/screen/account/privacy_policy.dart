import 'package:flutter/material.dart';
import 'package:new_travel_app/refracted%20class/app_background.dart';
import 'package:new_travel_app/refracted%20class/app_toolbarsearch.dart';
import 'package:new_travel_app/refracted%20widgets/app_string.dart';
import 'package:new_travel_app/refracted%20widgets/app_text_styles.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarwidget(title: AppStrings.privacyPolicy),
      body: const BackgroundColor(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Text(
          AppStrings.privacypolicy,
          style: Apptext.text5,
        )),
      )),
    );
  }
}
