import 'package:flutter/material.dart';
import 'package:new_travel_app/refracted%20widgets/app_colors.dart';

// ignore: must_be_immutable
class AppBarwidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  TextStyle? textStyle;
  List<Widget>? action;

  PreferredSizeWidget? bottom;
  AppBarwidget(
      {super.key,
      required this.title,
      this.action,
      this.bottom,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          title,
          style: textStyle,
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
        actions: action,
        elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
