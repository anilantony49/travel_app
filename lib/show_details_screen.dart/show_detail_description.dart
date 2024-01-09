import 'dart:io';
import 'package:flutter/material.dart';
import 'package:new_travel_app/models/africa.dart';
import 'package:new_travel_app/models/europe.dart';
import 'package:new_travel_app/models/popular_destination.dart';
import 'package:new_travel_app/others/contants.dart';
import 'package:new_travel_app/screen/calender_page.dart';
import 'package:new_travel_app/show_details_screen.dart/tab1_contents.dart';
import 'package:new_travel_app/show_details_screen.dart/tab2_contents.dart';
import 'package:new_travel_app/show_details_screen.dart/tab3_contents.dart';
import 'package:new_travel_app/show_details_screen.dart/tab4_contents.dart';
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
                    Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const CalenderPage()));
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
                      TabOneContent(
                        category: widget.category,
                        selectedItem: widget.selectedItem,
                        selectedEuropeItem: widget.selectedEuropeItem,
                        selectedAfricaItem: widget.selectedAfricaItem,
                      ),
                      TabTwoContent(
                          category: widget.category,
                          selectedItem: widget.selectedItem,
                          selectedEuropeItem: widget.selectedEuropeItem,
                          selectedAfricaItem: widget.selectedAfricaItem),
                      TabThreeContent(
                          category: widget.category,
                          selectedItem: widget.selectedItem,
                          selectedEuropeItem: widget.selectedEuropeItem,
                          selectedAfricaItem: widget.selectedAfricaItem),
                      TabFourContent(
                          category: widget.category,
                          selectedItem: widget.selectedItem,
                          selectedEuropeItem: widget.selectedEuropeItem,
                          selectedAfricaItem: widget.selectedAfricaItem)
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
                    color: Colors.purple,
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
