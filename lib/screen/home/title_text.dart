  import 'package:flutter/material.dart';
import 'package:new_travel_app/refracted%20widgets/app_colors.dart';

Widget titleText(String text) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.blackColor,
                fontSize: 25,
                fontWeight: FontWeight.w900,
                decoration: TextDecoration.none,
                // letterSpacing: 1.5,
              ),
            ),
          );
        },
        childCount: 1,
      ),
    );
  }
