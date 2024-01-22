import 'package:flutter/material.dart';
import 'package:new_travel_app/refractedClass/app_textfields_borders.dart';

class AppWidgetsForStack extends StatelessWidget {
  final Widget mainwidget;
  const AppWidgetsForStack({super.key, required this.mainwidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTextFieldBorders.border4,
      child: mainwidget,
    );
  }
}
