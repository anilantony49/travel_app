import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';

Widget imageBox(
  BuildContext context,
  Function(BuildContext, ImageSource) pickImage,
  String selectedImagePath,
) {
  return GestureDetector(
    onTap: () {
      pickImage(context, ImageSource.gallery);
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderColor,
            width: 4.0,
          ),
          color: AppColors.borderColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: selectedImagePath.isEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/image/image.jpg',
                  fit: BoxFit.fill,
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(
                  File(selectedImagePath),
                  fit: BoxFit.fill,
                ),
              ),
      ),
    ),
  );
}
