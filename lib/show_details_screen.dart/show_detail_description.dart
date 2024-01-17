import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_travel_app/db/favorites_db.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/models/favorites.dart';
import 'package:new_travel_app/others/contants.dart';
import 'package:new_travel_app/screen/trips/plan_trip.dart';
import 'package:new_travel_app/show_details_screen.dart/tab1_contents.dart';
import 'package:new_travel_app/show_details_screen.dart/tab2_contents.dart';
import 'package:new_travel_app/show_details_screen.dart/tab3_contents.dart';
import 'package:new_travel_app/show_details_screen.dart/tab4_contents.dart';
// ignore: depend_on_referenced_packages
import 'package:photo_view/photo_view.dart';
// ignore: depend_on_referenced_packages
import 'package:photo_view/photo_view_gallery.dart';

class ShowDetailsPage extends StatefulWidget {
  const ShowDetailsPage({required this.selectedItem, super.key, r});
  final DestinationModels? selectedItem;

  @override
  State<ShowDetailsPage> createState() => _ShowDetailsPageState();
}

class _ShowDetailsPageState extends State<ShowDetailsPage> {
  List<FavoritesModels> items = [];
  late bool isFavorite;
  @override
  void initState() {
    super.initState();
    fetchFavorites();
    isFavorite = isCurrentlyFavorite();
  }

  bool isCurrentlyFavorite() {
    // Check if the current item is in the favorites list
    String itemId = getSelectedItemId();
    return items.any((item) => item.id == itemId);
  }

  String getSelectedItemId() {
    return widget.selectedItem!.id;

    // switch (widget.category) {
    //   case 'Popular Destination':
    //     return widget.selectedItem!.id;
    //   case 'Africa':
    //     return widget.selectedAfricaItem!.id;
    //   case 'Europe':
    //     return widget.selectedEuropeItem!.id;
    //   case 'South America':
    //     return widget.selectedSouthAmericaItem!.id;
    //   case 'North America':
    //     return widget.selectedNorthAmericaItem!.id;
    //   case 'Asia':
    //     return widget.selectedAsiaItem!.id;
    //   default:
    //     return '';
    // }
  }

  void fetchFavorites() async {
    List<FavoritesModels> fetchedItems =
        await FavoritesDb.singleton.getFavorites();
    setState(() {
      items = fetchedItems;
      isFavorite = isCurrentlyFavorite();
    });
  }

  void removeFavoritesAndShowSnackbar(String favoriteId) {
    FavoritesDb.singleton.deleteFavorites(favoriteId);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Removed from favorite'),
        duration: Duration(seconds: 3),
      ),
    );

    fetchFavorites();
  }

  // bool isFavorite = false;
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
                    widget.selectedItem!.countryName,
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(
                      File(widget.selectedItem!.countryImage),
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
                          onTap: () async {
                            final String image =
                                widget.selectedItem!.countryImage;

                            final String place =
                                widget.selectedItem!.countryName;

                            final favorite = FavoritesModels(
                                id: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                image: image,
                                place: place);
                            FavoritesDb.singleton.insertFavorites(favorite);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Added to the favorite list!'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                            FavoritesDb.singleton.deleteFavorites(favorite.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Added to the favorite list!'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                            setState(() {
                              isFavorite = !isFavorite;
                            });
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            if (!isFavorite) {
                              FavoritesDb.singleton
                                  .deleteFavorites(favorite.id);
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Removed from the favorite list!'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          },
                          child: GestureDetector(
                            onTap: () {
                              toggleFavorite();
                            },
                            child: Icon(
                              Icons.favorite,
                              color: isFavorite ? Colors.red : Colors.white,
                            ),
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
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PlanTrip(selectedItem: widget.selectedItem)));
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
                        // category: widget.category,
                        selectedItem: widget.selectedItem,
                      ),
                      TabTwoContent(
                        // category: widget.category,
                        selectedItem: widget.selectedItem,
                        // selectedEuropeItem: widget.selectedEuropeItem,
                        // selectedAfricaItem: widget.selectedAfricaItem
                      ),
                      TabThreeContent(
                        // category: widget.category,
                        selectedItem: widget.selectedItem,
                        // selectedEuropeItem: widget.selectedEuropeItem,
                        // selectedAfricaItem: widget.selectedAfricaItem
                      ),
                      TabFourContent(
                        // category: widget.category,
                        selectedItem: widget.selectedItem,
                        // selectedEuropeItem: widget.selectedEuropeItem,
                        // selectedAfricaItem: widget.selectedAfricaItem
                      )
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

  void toggleFavorite() {
    String itemId = getSelectedItemId();

    if (isFavorite) {
      // Remove from favorites
      FavoritesDb.singleton.deleteFavorites(itemId);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Removed from favorite'),
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      // Add to favorites
      FavoritesModels favorite = FavoritesModels(
        id: itemId,
        image: getSelectedItemImage(),
        place: getSelectedItemName(),
      );
      FavoritesDb.singleton.insertFavorites(favorite);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Added to the favorite list!'),
          duration: Duration(seconds: 3),
        ),
      );
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  String getSelectedItemImage() {
    return widget.selectedItem!.countryImage;
    // switch (widget.category) {
    //   case 'Popular Destination':
    //     return widget.selectedItem!.countryImage;
    //   case 'Africa':
    //     return widget.selectedAfricaItem!.countryImage;
    //   case 'Europe':
    //     return widget.selectedEuropeItem!.countryImage;
    //   case 'South America':
    //     return widget.selectedSouthAmericaItem!.countryImage;
    //   case 'North America':
    //     return widget.selectedNorthAmericaItem!.countryImage;
    //   case 'Asia':
    //     return widget.selectedAsiaItem!.countryImage;
    //   default:
    //     return '';
    // }
  }

  String getSelectedItemName() {
    return widget.selectedItem!.countryName;
    // switch (widget.category) {
    //   case 'Popular Destination':
    //     return widget.selectedItem!.countryName;
    //   case 'Africa':
    //     return widget.selectedAfricaItem!.countryName;
    //   case 'Europe':
    //     return widget.selectedEuropeItem!.countryName;
    //   case 'South America':
    //     return widget.selectedSouthAmericaItem!.countryName;
    //   case 'North America':
    //     return widget.selectedNorthAmericaItem!.countryName;
    //   case 'Asia':
    //     return widget.selectedAsiaItem!.countryName;
    //   default:
    //     return '';
    // }
  }
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
