import 'package:flutter/material.dart';
import 'package:new_travel_app/refracted%20widgets/app_colors.dart';


class AppTextFieldBorders {
  static final border1 = OutlineInputBorder(
    borderRadius: BorderRadius.circular(100),
    borderSide: const BorderSide(color:AppColors.black, width: 0.1, style: BorderStyle.solid),
  );
  static const border2 = RoundedRectangleBorder(
    side: BorderSide(color: AppColors.black, style: BorderStyle.solid, width: 0.1),
    borderRadius: BorderRadius.all(Radius.circular(50.0)),
  );

  static const border3 = BoxDecoration(
    boxShadow: [
      BoxShadow(
          color: AppColors.black,
          blurRadius: 1,
          blurStyle: BlurStyle.solid,
          offset: Offset(0, 0),
          spreadRadius: 1)
    ],

    borderRadius: BorderRadius.all(Radius.circular(20)),
    color: AppColors.background,
  );
    static final border4 = BoxDecoration(
    border: Border.all(style: BorderStyle.solid, color: AppColors.background, width: 2),
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    color: Colors.black12,
  );
  
}
