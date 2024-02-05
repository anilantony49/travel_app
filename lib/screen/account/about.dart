import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_travel_app/refracted_class/app_background.dart';
import 'package:new_travel_app/refracted_class/app_toolbarsearch.dart';
import 'package:new_travel_app/refracted_widgets/app_sized_box.dart';
import 'package:new_travel_app/refracted_widgets/app_string.dart';
import 'package:new_travel_app/refracted_widgets/app_text_styles.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarwidget(title: AppStrings.about,textStyle:GoogleFonts.alata()),
      body: const BackgroundColor(
          child: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSizedBoxes.box3,
            Text(
              AppStrings.aboutUsIntroduce,
              style: Apptext.text8,
            ),
            AppSizedBoxes.box6,
            Text(
              AppStrings.aboutUsIntroduceNote,
              style: Apptext.text2,
            ),
            AppSizedBoxes.box3,
            Text(
              AppStrings.aboutUsDiscoverExplore,
              style: Apptext.text8,
            ),
            AppSizedBoxes.box6,
            Text(
              AppStrings.aboutUsDiscoverExploreNotes,
              style: Apptext.text2,
            ),
            AppSizedBoxes.box3,
            Text(
              AppStrings.aboutUsPlan,
              style: Apptext.text8,
            ),
            AppSizedBoxes.box6,
            Text(
              AppStrings.aboutUsPlanNote,
              style: Apptext.text2,
            ),
            AppSizedBoxes.box3,
            Text(
              AppStrings.aboutUsSearch,
              style: Apptext.text8,
            ),
            AppSizedBoxes.box6,
            Text(
              AppStrings.aboutUsSearchNote,
              style: Apptext.text2,
            ),
            AppSizedBoxes.box3,
            Text(
              AppStrings.aboutUsManageTrip,
              style: Apptext.text8,
            ),
            AppSizedBoxes.box6,
            Text(
              AppStrings.aboutUsManageTripNote,
              style: Apptext.text2,
            ),
            AppSizedBoxes.box3,
            Text(
              AppStrings.aboutUsProfile,
              style: Apptext.text8,
            ),
            AppSizedBoxes.box6,
            Text(
              AppStrings.aboutUsProfileNote,
              style: Apptext.text2,
            ),
            AppSizedBoxes.box3,
            Text(
              AppStrings.aboutUsLastNote,
              style: Apptext.text2,
            ),
          ],
        )),
      )),
    );
  }
}
