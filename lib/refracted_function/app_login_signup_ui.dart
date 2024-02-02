import 'package:flutter/material.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';
import 'package:new_travel_app/screen/authentication/authentication_page.dart';

Widget textWidget(
  BuildContext context,
  String image,
  String text,
) {
  return Stack(
    children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              image,
            ),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              AppColors.black.withOpacity(0.7),
              BlendMode.dstATop,
            ),
          ),
        ),
      ),
      Positioned(
        left: 20,
        top: 60,
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => const AuthenticationPage()),
              (Route<dynamic> route) => false,
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      Positioned(
        left: 35,
        top: 130,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 25,
            fontWeight: FontWeight.w900,
            decoration: TextDecoration.none,
            // letterSpacing: 1.5,
          ),
        ),
      ),
    ],
  );
}
