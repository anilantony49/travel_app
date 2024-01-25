import 'package:flutter/material.dart';
import 'package:new_travel_app/refracted%20widgets/app_colors.dart';

class Widgets {
  static Widget headingText(String text) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColors.blackColor),
      ),
    );
  }

  static Widget section(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
            color:AppColors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
