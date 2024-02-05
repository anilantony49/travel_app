import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';
import 'package:new_travel_app/refracted_widgets/app_sized_box.dart';
import 'package:new_travel_app/screen/home/image_container.dart';
import 'package:new_travel_app/screen/home/title_text.dart';

Widget animatedGreenBar(int index, int currentPage) {
  return AnimatedContainer(
    duration: const Duration(seconds: 2),
    // curve: Curves.linear,
    margin: const EdgeInsets.all(5),
    width: 25,
    height: 3,
    decoration: BoxDecoration(
      color: currentPage == index ? AppColors.greenColor : AppColors.grey,
    ),
  );
}

List<Widget> generateCategoryWidgets(
    List<String> categories, List<DestinationModels> items) {
  List<Widget> categoryWidgets = [];

  for (var category in categories) {
    categoryWidgets.add(titleText(category));

    List<DestinationModels> filteredItems =
        items.where((item) => item.categories == category).toList();

    if (filteredItems.isNotEmpty) {
      categoryWidgets.add(buildCategorySliverList(filteredItems, category));
    } else {
      categoryWidgets.add(
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('No destinations for $category',
                style: GoogleFonts.alata(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.red,
                )),
          ),
        ),
      );
    }
  }

  return categoryWidgets;
}

Widget emergencyServices(
    BuildContext context, String text, String number, IconData icon) {
  double screenWidth = MediaQuery.of(context).size.width;

  return Padding(
    padding:  EdgeInsets.all(screenWidth*.05),
    child: Container(
      height: 80,
      width: 320,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromARGB(255, 231, 228, 228),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Icon(icon),
            AppSizedBoxes.box8,
            Text(
              text,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor),
            ),
            const Spacer(),
            Text(number,
                style: const TextStyle(
                    fontSize: 30,
                    color: AppColors.purple,
                    fontWeight: FontWeight.w500))
          ],
        ),
      ),
    ),
  );
}

Widget headingText(String text) {
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

Widget section(String text) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, bottom: 10),
    child: Text(
      text,
      style: const TextStyle(
          color: AppColors.black, fontSize: 20, fontWeight: FontWeight.bold),
    ),
  );
}

Future<void> showEditCategoryDialog(
    BuildContext context,
    String currentCategory,
    Function(String) editCategory,
    Function(String) deleteCategory) async {
  TextEditingController editingController =
      TextEditingController(text: currentCategory);
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit/Delete Category'),
        content: TextField(
          controller: editingController,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              editCategory(editingController.text);

              Navigator.of(context).pop();
            },
            child: const Text('Edit'),
          ),
          ElevatedButton(
            onPressed: () {
              deleteCategory(currentCategory);

              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}
