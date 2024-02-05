import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';

class Widgets {
  static Widget headingText(String text, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        text,
        style: GoogleFonts.alatsi(
          textStyle: TextStyle(
            color: AppColors.blackColor,
            fontWeight: FontWeight.w500,
            fontSize: screenWidth * .04,
          ),
        ),
      ),
    );
  }

  static Widget section(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
            color: AppColors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
