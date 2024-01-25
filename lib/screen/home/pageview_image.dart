  import 'package:flutter/material.dart';
import 'package:new_travel_app/refracted%20widgets/app_colors.dart';

Widget pageviewImage(
    String image,
    String name,
    String text,
  ) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.maxFinite,
        ),
        Positioned(
          left: 0,
          bottom: 40,
          child: Container(
            color: AppColors.black.withOpacity(0.0),
            padding: const EdgeInsets.all(16.0),
            child: Text(
              name,
              style: const TextStyle(
                color:AppColors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
          left: 0,
          bottom: 5,
          child: Container(
            color:AppColors.black .withOpacity(0.0),
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
              // textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
