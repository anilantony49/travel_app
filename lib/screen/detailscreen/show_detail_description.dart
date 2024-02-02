import 'dart:io';
import 'package:flutter/material.dart';
import 'package:new_travel_app/db/favorites_db.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/models/favorites.dart';
import 'package:new_travel_app/refracted_widgets/app_colors.dart';
import 'package:new_travel_app/refracted_class/app_background.dart';
import 'package:new_travel_app/refracted_class/app_rating.dart';
import 'package:new_travel_app/refracted_class/app_tabBar_widget.dart';
import 'package:new_travel_app/screen/trips/plan_edit_trip.dart';
import 'package:new_travel_app/screen/detailscreen/tab_one_contents.dart';
import 'package:new_travel_app/screen/detailscreen/tab_two_contents.dart';
import 'package:new_travel_app/screen/detailscreen/tab_three_contents.dart';
import 'package:new_travel_app/screen/detailscreen/tab_four_contents.dart';

class ShowDetailsPage extends StatefulWidget {
  const ShowDetailsPage({
    required this.selectedItem,
    super.key,
  });
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
        duration: Duration(seconds:2),
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
                    color: Color.fromARGB(255, 41, 199, 201),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: const Text(''),
                ),
              ),
              pinned: true,
              backgroundColor: AppColors.greenColor,
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
                                duration: Duration(seconds:2),
                              ),
                            );
                            FavoritesDb.singleton.deleteFavorites(favorite.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Added to the favorite list!'),
                                duration: Duration(seconds:2),
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
                                  duration: Duration(seconds:2),
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
                              color: isFavorite ?AppColors.red:AppColors.white,
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
                              builder: (context) => PlanEditTrip(
                                  selectedItem: widget.selectedItem)));
                        },
                        child: const Text(
                          'Plan Trip',
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 30,
                        right: 10,
                        child: Rating(
                            itemSize: 17,
                            initialRating: widget.selectedItem!.rating)),
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
              color:AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: BackgroundColor(
              child: Column(
                children: [
                  const TabBarWidget(),
                  Expanded(
                    child: TabBarView(
                      children: [
                        TabOneContent(
                          selectedItem: widget.selectedItem,
                        ),
                        TabTwoContent(
                          selectedItem: widget.selectedItem,
                        ),
                        TabThreeContent(
                          selectedItem: widget.selectedItem,
                        ),
                        TabFourContent(
                          selectedItem: widget.selectedItem,
                        )
                      ],
                    ),
                  ),
                ],
              ),
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
          duration: Duration(seconds:2),
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
          duration: Duration(seconds:2),
        ),
      );
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  String getSelectedItemImage() {
    return widget.selectedItem!.countryImage;
  }

  String getSelectedItemName() {
    return widget.selectedItem!.countryName;
  }
}
