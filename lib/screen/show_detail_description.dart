import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:new_travel_app/models/africa.dart';
import 'package:new_travel_app/models/europe.dart';
import 'package:new_travel_app/models/popular_destination.dart';
import 'package:new_travel_app/others/contants.dart';
// ignore: depend_on_referenced_packages
import 'package:photo_view/photo_view.dart';
// ignore: depend_on_referenced_packages
import 'package:photo_view/photo_view_gallery.dart';

class ShowDetailsPage extends StatefulWidget {
  const ShowDetailsPage({
    required this.selectedItem,
    required this.selectedEuropeItem,
    super.key,
    required this.category,
    required this.selectedAfricaItem,
  });
  final PopularDestinationModels? selectedItem;
  final EuropeDestinationModels? selectedEuropeItem;
  final AfricaDestinationModels? selectedAfricaItem;

  final String category;

  @override
  State<ShowDetailsPage> createState() => _ShowDetailsPageState();
}

class _ShowDetailsPageState extends State<ShowDetailsPage> {
  bool isFavorite = false;
  double containerHeight = 100.0;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Container(
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: const Text(''),
                ),
              ),
              pinned: true,
              backgroundColor: Colors.grey,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                title: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                  ),
                  child: Text(
                    widget.category == 'Popular Destination'
                        ? widget.selectedItem!.countryName
                        : widget.category == 'Africa'
                            ? widget.selectedAfricaItem!.countryName
                            : widget.selectedEuropeItem!.countryName,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(
                      File(widget.category == 'Popular Destination'
                          ? widget.selectedItem!.countryImage
                          : widget.category == 'Africa'
                              ? widget.selectedAfricaItem!.countryImage
                              : widget.selectedEuropeItem!.countryImage),
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 30,
                      // bottom: 40,
                      right: 14,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.transparent.withOpacity(.1)),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                          },
                          child: Icon(
                            Icons.favorite,
                            color: isFavorite ? Colors.red : Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 80,
                      right: 140,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.transparent.withOpacity(.01)),
                        ),
                        onPressed: () {
                          // Handle button press
                        },
                        child: const Text(
                          'Plan Trip',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: DefaultTabController(
          length: 4,
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                const TabBar(
                  // isScrollable: true,
                  tabs: [
                    Column(
                      children: [
                        Icon(Icons.info),
                        Tab(text: 'Key info'),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.payments),
                        Tab(text: 'Money'),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.cloud),
                        Tab(text: 'Weather'),
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.emergency),
                        Tab(text: 'Emergency'),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      // Content for Tab 1
                      SingleChildScrollView(
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
                                      widget.category == 'Popular Destination'
                                          ? widget.selectedItem!.description
                                          : widget.category == 'Africa'
                                              ? widget.selectedAfricaItem!
                                                  .description
                                              : widget.selectedEuropeItem!
                                                  .description,
                                      style: const TextStyle(
                                          color: Constants.blackColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            headingText('Capital'),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15, bottom: 10),
                              child: Container(
                                width: 150,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color.fromARGB(
                                        255, 231, 228, 228)),
                                child: Center(
                                    child: Text(
                                  widget.category == 'Popular Destination'
                                      ? widget.selectedItem!.capital
                                      : widget.category == 'Africa'
                                          ? widget.selectedAfricaItem!.capital
                                          : widget.selectedEuropeItem!.capital,
                                  style: const TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                              ),
                            ),
                            headingText('Known For'),
                            Container(
                              height: 125,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListView.builder(
                                itemExtent: 50,
                                itemCount: ((widget.category ==
                                                    'Popular Destination'
                                                ? widget.selectedItem!.knownFor
                                                : widget.category == 'Africa'
                                                    ? widget.selectedAfricaItem!
                                                        .knownFor
                                                    : widget.selectedEuropeItem!
                                                        .knownFor)
                                            .length /
                                        3)
                                    .ceil(),
                                itemBuilder:
                                    (BuildContext context, int rowIndex) {
                                  List<Color> colors = const [
                                    Color.fromARGB(255, 223, 138, 163),
                                    Color.fromARGB(255, 140, 182, 216),
                                    Color.fromARGB(255, 129, 188, 161),
                                    Color.fromARGB(255, 192, 175, 127),

                                    // Add more colors as needed
                                  ];

                                  return Row(
                                    children: List.generate(3, (int index) {
                                      final knownForIndex =
                                          rowIndex * 3 + index;
                                      if (knownForIndex <
                                          (widget.category ==
                                                      'Popular Destination'
                                                  ? widget
                                                      .selectedItem!.knownFor
                                                  : widget.category == 'Africa'
                                                      ? widget
                                                          .selectedAfricaItem!
                                                          .knownFor
                                                      : widget
                                                          .selectedEuropeItem!
                                                          .knownFor)
                                              .length) {
                                        Color selectedColor =
                                            colors[index % colors.length];
                                        String text = (widget.category ==
                                                'Popular Destination'
                                            ? widget.selectedItem!.knownFor
                                            : widget.category == 'Africa'
                                                ? widget.selectedAfricaItem!
                                                    .knownFor
                                                : widget.selectedEuropeItem!
                                                    .knownFor)[knownForIndex];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: selectedColor,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                        return Container(); // Empty container if there are fewer than 3 cities in the row
                                      }
                                    }),
                                  );
                                },
                              ),
                            ),
                            headingText('Major Cities'),
                            Container(
                              height: 125,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListView.builder(
                                // scrollDirection: Axis
                                //     .vertical, // Use vertical scroll direction
                                itemExtent:
                                    50, // Set the height of each item, adjust as needed
                                itemCount: ((widget.category ==
                                                    'Popular Destination'
                                                ? widget
                                                    .selectedItem!.majorCities
                                                : widget.category == 'Africa'
                                                    ? widget.selectedAfricaItem!
                                                        .majorCities
                                                    : widget.selectedEuropeItem!
                                                        .majorCities)
                                            .length /
                                        3)
                                    .ceil(),
                                itemBuilder:
                                    (BuildContext context, int rowIndex) {
                                  return Row(
                                    children: List.generate(3, (int index) {
                                      final cityIndex = rowIndex * 3 + index;
                                      if (cityIndex <
                                          (widget.category ==
                                                      'Popular Destination'
                                                  ? widget
                                                      .selectedItem!.majorCities
                                                  : widget.category == 'Africa'
                                                      ? widget
                                                          .selectedAfricaItem!
                                                          .majorCities
                                                      : widget
                                                          .selectedEuropeItem!
                                                          .majorCities)
                                              .length) {
                                        String text = (widget.category ==
                                                'Popular Destination'
                                            ? widget.selectedItem!.majorCities
                                            : widget.category == 'Africa'
                                                ? widget.selectedAfricaItem!
                                                    .majorCities
                                                : widget.selectedEuropeItem!
                                                    .majorCities)[cityIndex];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 231, 228, 228),
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                        return Container(); // Empty container if there are fewer than 3 cities in the row
                                      }
                                    }),
                                  );
                                },
                              ),
                            ),
                            headingText('Images'),
                            Container(
                              height: 200,
                              child: ListView.builder(
                                itemCount:
                                    widget.category == 'Popular Destination'
                                        ? widget.selectedItem!.images.length
                                        : widget.category == 'Africa'
                                            ? widget.selectedAfricaItem!.images
                                                .length
                                            : widget.selectedEuropeItem!.images
                                                .length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FullScreenImagePageView(
                                              images: widget.category ==
                                                      'Popular Destination'
                                                  ? widget.selectedItem!.images
                                                  : widget.category == 'Africa'
                                                      ? widget
                                                          .selectedAfricaItem!
                                                          .images
                                                      : widget
                                                          .selectedEuropeItem!
                                                          .images,
                                              initialIndex: index,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Hero(
                                        tag:
                                            'imageHero$index', // Unique tag for each image ,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            color: Colors.grey,
                                          ),
                                          width: 200,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.file(
                                              File(widget.category ==
                                                      'Popular Destination'
                                                  ? widget.selectedItem!
                                                      .images[index]
                                                  : widget.category == 'Africa'
                                                      ? widget
                                                          .selectedAfricaItem!
                                                          .images[index]
                                                      : widget
                                                          .selectedEuropeItem!
                                                          .images[index]),
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
                            headingText('Official Language'),
                            section(
                              widget.category == 'Popular Destination'
                                  ? widget.selectedItem!.language
                                  : widget.category == 'Africa'
                                      ? widget.selectedAfricaItem!.language
                                      : widget.selectedEuropeItem!.language,
                            ),
                            headingText('Currency'),
                            section(
                              widget.category == 'Popular Destination'
                                  ? widget.selectedItem!.currency
                                  : widget.category == 'Africa'
                                      ? widget.selectedAfricaItem!.currency
                                      : widget.selectedEuropeItem!.currency,
                            ),
                            headingText('Dial Code'),
                            section(
                              widget.category == 'Popular Destination'
                                  ? widget.selectedItem!.digitialCode
                                  : widget.category == 'Africa'
                                      ? widget.selectedAfricaItem!.digitialCode
                                      : widget.selectedEuropeItem!.digitialCode,
                            ),
                            headingText('Mobile Phone Operators'),
                            section('French')
                          ],
                        ),
                      ),

                      // Content for Tab 2
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 15, bottom: 10, top: 10),
                            child: Text(
                              'Currency',
                              style: TextStyle(
                                  color: Constants.blackColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                          ),
                          section(
                            widget.category == 'Popular Destination'
                                ? widget.selectedItem!.currency
                                : widget.category == 'Africa'
                                    ? widget.selectedAfricaItem!.currency
                                    : widget.selectedEuropeItem!.currency,
                          ),
                          headingText('Convert'),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: Container(
                                height: 80,
                                width: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:
                                      const Color.fromARGB(255, 231, 228, 228),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'INR',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.purple),
                                          ),
                                          Text('Indian Rupee',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Constants.blackColor)),
                                        ],
                                      ),
                                      Spacer(),
                                      Text('0',
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Constants.blackColor,
                                              fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: Container(
                                height: 80,
                                width: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color:
                                      const Color.fromARGB(255, 231, 228, 228),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'EUR',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.purple),
                                          ),
                                          Text('Euro',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Constants.blackColor)),
                                        ],
                                      ),
                                      Spacer(),
                                      Text('0',
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Constants.blackColor,
                                              fontWeight: FontWeight.w500))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                      // Content for Tab 3
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Color.fromARGB(255, 231, 228, 228),
                                  ),
                                  child: Text(widget.category ==
                                          'Popular Destination'
                                      ? widget.selectedItem!.weather
                                      : widget.category == 'Africa'
                                          ? widget.selectedAfricaItem!.weather
                                          : widget
                                              .selectedEuropeItem!.weather)),
                            ),
                            // const Text('When to visit'),
                            // Container(
                            //   height: containerHeight,
                            //   width: 300,
                            //   decoration: const BoxDecoration(
                            //     color: Color.fromARGB(255, 231, 228, 228),
                            //   ),
                            //   child: Row(
                            //     children: [
                            //       const Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: [
                            //           Text('Sightseeing'),
                            //           Text('Spring (March to May)'),
                            //           Text('Dscription')
                            //         ],
                            //       ),
                            //       const Spacer(),
                            //       IconButton(
                            //           onPressed: () {
                            //             setState(() {
                            //               if (isExpanded) {
                            //                 containerHeight =
                            //                     100.0; // Restore to the original height
                            //               } else {
                            //                 containerHeight +=
                            //                     50.0; // Increase the container height
                            //               }
                            //               isExpanded =
                            //                   !isExpanded; // Toggle the flag
                            //             });
                            //           },
                            //           icon: const Icon(Icons.add))
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, bottom: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Emergency Servises',
                              style: TextStyle(
                                  color: Constants.blackColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            emergencyServices(
                                'Police',
                                widget.category == 'Popular Destination'
                                    ? widget.selectedItem!.police.toString()
                                    : widget.category == 'Africa'
                                        ? widget.selectedAfricaItem!.police
                                            .toString()
                                        : widget.selectedEuropeItem!.police
                                            .toString(),
                                Icons.local_police),
                            emergencyServices(
                              'Ambulance',
                              widget.category == 'Popular Destination'
                                  ? widget.selectedItem!.ambulance.toString()
                                  : widget.category == 'Africa'
                                      ? widget.selectedAfricaItem!.ambulance
                                          .toString()
                                      : widget.selectedEuropeItem!.ambulance
                                          .toString(),
                              Mdi.ambulance,
                            ),
                            emergencyServices(
                              'Fire',
                              widget.category == 'Popular Destination'
                                  ? widget.selectedItem!.fire.toString()
                                  : widget.category == 'Africa'
                                      ? widget.selectedAfricaItem!.fire
                                          .toString()
                                      : widget.selectedEuropeItem!.fire
                                          .toString(),
                              Mdi.fire,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
            color: Constants.blackColor),
      ),
    );
  }

  Widget section(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

Widget emergencyServices(String text, String number, IconData icon) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
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
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Constants.blackColor),
            ),
            const Spacer(),
            Text(number,
                style: const TextStyle(
                    fontSize: 30,
                    color: Constants.blackColor,
                    fontWeight: FontWeight.w500))
          ],
        ),
      ),
    ),
  );
}

class FullScreenImagePageView extends StatelessWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenImagePageView({
    Key? key,
    required this.images,
    required this.initialIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
        itemCount: images.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: FileImage(File(images[index])),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
            heroAttributes: PhotoViewHeroAttributes(tag: 'imageHero$index'),
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        pageController: PageController(initialPage: initialIndex),
        backgroundDecoration: const BoxDecoration(
          color: Colors.black,
        ),
      ),
    );
  }
}
