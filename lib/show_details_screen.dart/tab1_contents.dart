import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_travel_app/models/africa.dart';
import 'package:new_travel_app/models/europe.dart';
import 'package:new_travel_app/models/popular_destination.dart';
import 'package:new_travel_app/others/contants.dart';
import 'package:new_travel_app/others/widgets.dart';
import 'package:new_travel_app/show_details_screen.dart/show_detail_description.dart';

class TabOneContent extends StatelessWidget {
  final String category;
  final PopularDestinationModels? selectedItem;
  final EuropeDestinationModels? selectedEuropeItem;
  final AfricaDestinationModels? selectedAfricaItem;
  const TabOneContent(
      {super.key,
      required this.category,
      required this.selectedItem,
      required this.selectedEuropeItem,
      required this.selectedAfricaItem});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Container(
                width: 350,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    category == 'Popular Destination'
                        ? selectedItem?.description ?? 'No Data available'
                        : category == 'Africa'
                            ? selectedAfricaItem?.description ??
                                'No Data available'
                            : selectedEuropeItem?.description ??
                                'No Data available',
                    style: const TextStyle(
                        color: Constants.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
          Widgets.headingText('Capital'),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10),
            child: Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color.fromARGB(255, 231, 228, 228)),
              child: Center(
                  child: Text(
                category == 'Popular Destination'
                    ? selectedItem?.capital ?? 'No Data available'
                    : category == 'Africa'
                        ? selectedAfricaItem?.capital ?? 'No Data available'
                        : selectedEuropeItem?.capital ?? 'No Data available',
                style: const TextStyle(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
            ),
          ),
          Widgets.headingText('Known For'),
          Container(
            height: 115,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              itemExtent: 50,
              itemCount: ((category == 'Popular Destination'
                          ? selectedItem?.knownFor
                          : category == 'Africa'
                              ? selectedAfricaItem?.knownFor
                              : selectedEuropeItem?.knownFor) ??
                      [])
                  .length
                  .ceil(),
              itemBuilder: (BuildContext context, int rowIndex) {
                List<Color> colors = const [
                  Color.fromARGB(255, 223, 138, 163),
                  Color.fromARGB(255, 140, 182, 216),
                  Color.fromARGB(255, 129, 188, 161),
                  Color.fromARGB(255, 192, 175, 127),
                ];
                return Row(
                  children: List.generate(3, (int index) {
                    final knownForIndex = rowIndex * 3 + index;
                    if (knownForIndex <
                        (category == 'Popular Destination'
                                ? selectedItem?.knownFor
                                : category == 'Africa'
                                    ? selectedAfricaItem?.knownFor
                                    : selectedEuropeItem?.knownFor)!
                            .length) {
                      Color selectedColor = colors[index % colors.length];
                      String text = (category == 'Popular Destination'
                          ? selectedItem?.knownFor
                          : category == 'Africa'
                              ? selectedAfricaItem?.knownFor
                              : selectedEuropeItem?.knownFor)![knownForIndex];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedColor,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              text,
                              style: const TextStyle(
                                color: Constants.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                );
              },
            ),
          ),
          Widgets.headingText('Major Cities'),
          Container(
            height: 125,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListView.builder(
              itemExtent: 50,
              itemCount: ((category == 'Popular Destination'
                              ? selectedItem?.majorCities
                              : category == 'Africa'
                                  ? selectedAfricaItem?.majorCities
                                  : selectedEuropeItem?.majorCities)!
                          .length /
                      3)
                  .ceil(),
              itemBuilder: (BuildContext context, int rowIndex) {
                return Row(
                  children: List.generate(3, (int index) {
                    final cityIndex = rowIndex * 3 + index;
                    if (cityIndex <
                        (category == 'Popular Destination'
                                ? selectedItem?.majorCities
                                : category == 'Africa'
                                    ? selectedAfricaItem?.majorCities
                                    : selectedEuropeItem?.majorCities)!
                            .length) {
                      String text = (category == 'Popular Destination'
                          ? selectedItem?.majorCities
                          : category == 'Africa'
                              ? selectedAfricaItem?.majorCities
                              : selectedEuropeItem?.majorCities)![cityIndex];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 231, 228, 228),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              text,
                              style: const TextStyle(
                                color: Constants.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                );
              },
            ),
          ),
          Widgets.headingText('Images'),
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: category == 'Popular Destination'
                  ? selectedItem?.images.length
                  : category == 'Africa'
                      ? selectedAfricaItem?.images.length
                      : selectedEuropeItem?.images.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FullScreenImagePageView(
                            images: category == 'Popular Destination'
                                ? selectedItem?.images ?? []
                                : category == 'Africa'
                                    ? selectedAfricaItem?.images ?? []
                                    : selectedEuropeItem?.images ?? [],
                            initialIndex: index,
                          ),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'imageHero$index', // Unique tag for each image ,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.grey,
                        ),
                        width: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            File(category == 'Popular Destination'
                                ? selectedItem?.images[index] ?? ''
                                : category == 'Africa'
                                    ? selectedAfricaItem?.images[index] ?? ''
                                    : selectedEuropeItem?.images[index] ?? ''),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Widgets.headingText('Official Language'),
          Widgets.section(
            category == 'Popular Destination'
                ? selectedItem?.language ?? 'No Data available'
                : category == 'Africa'
                    ? selectedAfricaItem?.language ?? 'No Data available'
                    : selectedEuropeItem?.language ?? 'No Data available',
          ),
          Widgets.headingText('Currency'),
          Widgets.section(
            category == 'Popular Destination'
                ? selectedItem?.currency ?? 'No Data available'
                : category == 'Africa'
                    ? selectedAfricaItem?.currency ?? 'No Data available'
                    : selectedEuropeItem?.currency ?? 'No Data available',
          ),
          Widgets.headingText('Dial Code'),
          Widgets.section(
            category == 'Popular Destination'
                ? selectedItem?.digitialCode ?? 'No Data available'
                : category == 'Africa'
                    ? selectedAfricaItem?.digitialCode ?? 'No Data available'
                    : selectedEuropeItem?.digitialCode ?? 'No Data available',
          ),
          // headingText('Mobile Phone Operators'),
          // section('French')
        ],
      ),
    );
  }
}
