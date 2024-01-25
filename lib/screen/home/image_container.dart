import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/detailscreen/show_detail_description.dart';
import 'package:new_travel_app/refracted%20widgets/app_colors.dart';

Widget buildCategorySliverList(List<DestinationModels> items,String category) {
  // Filter the items to include only those belonging to the "Popular Destination" category
   List<DestinationModels> categoryItems = items
      .where((destination) => destination.categories == category)
      .toList();

  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 160.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryItems.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowDetailsPage(
                          selectedItem:categoryItems[index],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 135,
                      decoration: BoxDecoration(
                        color: Colors.transparent.withOpacity(.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                                child: Image.file(
                                  File(categoryItems[index].countryImage),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            categoryItems[index].countryName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color:AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
      childCount: 1,
    ),
  );
}
