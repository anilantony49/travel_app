import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_travel_app/refracted_class/app_background.dart';
import 'package:new_travel_app/refracted_class/app_toolbarsearch.dart';
import 'package:new_travel_app/refracted_widgets/app_string.dart';
import 'package:new_travel_app/refracted_widgets/app_text_styles.dart';

class TermsAndConditons extends StatelessWidget {
  const TermsAndConditons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarwidget(title: AppStrings.termsAndCondition,textStyle:GoogleFonts.alata()),
      body: const BackgroundColor(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Text(
          AppStrings.termsAndConditions,
          style: Apptext.text5,
        )),
      )),
    );
  }
}
