import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_travel_app/show_details_screen.dart/show_detail_description.dart';

Widget buildCategorySliverList(String category, List<dynamic> items) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 160.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowDetailsPage(
                          category: category,
                          selectedItem: category == 'Popular Destination'
                              ? items[index]
                              : null,
                          selectedEuropeItem:
                              category == 'Europe' ? items[index] : null,
                          selectedAfricaItem:
                              category == 'Africa' ? items[index] : null,
                          selectedSouthAmericaItem:
                              category == 'South America' ? items[index] : null,
                          selectedNorthAmericaItem:
                              category == 'North America' ? items[index] : null,
                          selectedAsiaItem:
                              category == 'Asia' ? items[index] : null,
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
                                  File(items[index].countryImage),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            items[index].countryName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
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
