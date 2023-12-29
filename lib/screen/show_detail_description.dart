import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';
import 'package:new_travel_app/models/europe.dart';
import 'package:new_travel_app/models/popular_destination.dart';
import 'package:new_travel_app/others/contants.dart';
// ignore: depend_on_referenced_packages
import 'package:photo_view/photo_view.dart';
// ignore: depend_on_referenced_packages
import 'package:photo_view/photo_view_gallery.dart';

class ShowDetailsPage extends StatefulWidget {
  const ShowDetailsPage(
    this.selectedItem,
    this.selectedEuropeItem, {
    super.key,
    required this.category,
  });
  final PopularDestinationModels? selectedItem;
  final EuropeDestinationModels? selectedEuropeItem;
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
                title: Text(
                  widget.category == 'Popular Destination'
                      ? widget.selectedItem!.countryName
                      : widget.selectedEuropeItem!.countryName,
                  style: const TextStyle(
                      fontSize: 35, fontWeight: FontWeight.bold),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(
                      File(widget.category == 'Popular Destination'
                          ? widget.selectedItem!.countryImage
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
                            color: Colors.grey),
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
                      bottom: 60,
                      right: 140,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle button press
                        },
                        child: const Text('Plan Trip'),
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
                                          : widget
                                              .selectedEuropeItem!.description,
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
                                      : widget.selectedEuropeItem!.capital,
                                  style: const TextStyle(
                                      color: Colors.purple,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                              ),
                            ),
                            // const Padding(
                            //   padding: EdgeInsets.only(left: 15, bottom: 10),
                            //   child: Text(
                            //     'Known for',
                            //     style: TextStyle(
                            //         fontSize: 15,
                            //         fontWeight: FontWeight.w500,
                            //         color: Constants.blackColor),
                            //   ),
                            // ),
                            // Container(
                            //   // width: 100,
                            //   height: 35,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(8),
                            //   ),
                            //   child: ListView.builder(
                            //     scrollDirection: Axis.horizontal,
                            //     itemCount: widget.selectedItem.knownFor.length,
                            //     itemBuilder: (BuildContext context, int index) {
                            //       return Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: Container(
                            //           decoration: BoxDecoration(
                            //             color: const Color.fromARGB(
                            //                 255, 231, 228, 228),
                            //             borderRadius: BorderRadius.circular(6),
                            //           ),
                            //           width: 100,
                            //           child:  Center(
                            //               child: Text(
                            //             widget.selectedItem.knownFor[index],
                            //             style: TextStyle(
                            //                 color: Constants.blackColor,
                            //                 fontWeight: FontWeight.bold,
                            //                 fontSize: 15),
                            //           )),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
                            headingText('Major Cities'),
                            Container(
                              // width: 100,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 231, 228, 228),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      width: 100,
                                      child: const Center(
                                          child: Text(
                                        'capital',
                                        style: TextStyle(
                                            color: Constants.blackColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      )),
                                    ),
                                  );
                                },
                              ),
                            ),
                            headingText('Images'),
                            Container(
                              height: 200,
                              child: ListView.builder(
                                itemCount: widget.category ==
                                        'Popular Destination'
                                    ? widget.selectedItem!.images.length
                                    : widget.selectedEuropeItem!.images.length,
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
                                                  : widget.selectedEuropeItem!
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
                                                  : widget.selectedEuropeItem!
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
                                  : widget.selectedEuropeItem!.language,
                            ),
                            headingText('Currency'),
                            section(
                              widget.category == 'Popular Destination'
                                  ? widget.selectedItem!.currency
                                  : widget.selectedEuropeItem!.currency,
                            ),
                            // headingText('Major Religions'),
                            // section('Christianity'),
                            // headingText('National Day'),
                            // section('Bastile Day Jul- 14'),
                            headingText('Dial Code'),
                            section(
                              widget.category == 'Popular Destination'
                                  ? widget.selectedItem!.digitialCode
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
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 231, 228, 228),
                                  ),
                                  child: Text(widget.category ==
                                          'Popular Destination'
                                      ? widget.selectedItem!.weather
                                      : widget.selectedEuropeItem!.weather)),
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
                                    : widget.selectedEuropeItem!.police
                                        .toString(),
                                Icons.local_police),
                            emergencyServices(
                              'Ambulance',
                              widget.category == 'Popular Destination'
                                  ? widget.selectedItem!.ambulance.toString()
                                  : widget.selectedEuropeItem!.ambulance
                                      .toString(),
                              Mdi.ambulance,
                            ),
                            emergencyServices(
                              'Fire',
                              widget.category == 'Popular Destination'
                                  ? widget.selectedItem!.fire.toString()
                                  : widget.selectedEuropeItem!.fire.toString(),
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
            color: Constants.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
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
