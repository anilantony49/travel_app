import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_travel_app/db/favorites_db.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/models/favorites.dart';
import 'package:new_travel_app/refracted%20widgets/app_colors.dart';
import 'package:new_travel_app/refracted%20class/app_toolbarsearch.dart';
import 'package:new_travel_app/refracted%20class/app_widgetsforstack.dart';
import 'package:new_travel_app/refracted%20class/app_background.dart';
import 'package:new_travel_app/refracted%20class/app_rating.dart';
import 'package:new_travel_app/refracted%20widgets/app_sized_box.dart';
import 'package:new_travel_app/refracted%20widgets/app_string.dart';
import 'package:new_travel_app/refracted%20widgets/app_text_styles.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key, this.selectedItem});
  final DestinationModels? selectedItem;
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<FavoritesModels> items = [];
  @override
  void initState() {
    super.initState();
    fetchFavorites();
  }

  void fetchFavorites() async {
    List<FavoritesModels> fetchedItems =
        await FavoritesDb.singleton.getFavorites();
    setState(() {
      items = fetchedItems;
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

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarwidget(
          title: AppStrings.favorite,
        ),
       
        body: BackgroundColor(
          child: items.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        color: Color.fromARGB(255, 238, 234, 234),
                        size: 100,
                      ),
                      Text(
                       AppStrings.emptyList,
                        style: TextStyle(color: AppColors.grey),
                      )
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 177,
                        crossAxisSpacing: 25.0,
                        mainAxisSpacing: 25.0,
                      ),
                      itemBuilder: (context, index) {
                        final FavoritesModels favorites = items[index];
          
                        return GridTile(
                          child: Column(
                            children: [
                              AppWidgetsForStack(
                                  mainwidget: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: [
                                        Container(
                                            height: 90,
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                            ),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: favorites
                                                            .image.isNotEmpty &&
                                                        File(favorites.image)
                                                            .existsSync()
                                                    ? ClipRRect(
                                                        // borderRadius:
                                                        // BorderRadius.circular(20),
                                                        child: Image.file(
                                                          File(favorites.image),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      )
                                                    : const Center(
                                                        child: Icon(
                                                          Icons.image,
                                                          size: 40,
                                                          color:AppColors.white,
                                                        ),
                                                      ))),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppSizedBoxes.box6,
                                              Row(
                                                children: [
                                                  Text(
                                                    favorites.place,
                                                    style: Apptext.text2,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const Spacer(),
                                                  IconButton(
                                                    onPressed: () {
                                                      removeFavoritesAndShowSnackbar(
                                                          favorites.id);
                                                    },
                                                    icon: const Icon(
                                                        Icons.favorite,
                                                        color:AppColors.red),
                                                  ),
                                                ],
                                              ),
                                              // AppSizedBoxes.box6,
                                              Rating(
                                                itemSize: 14,
                                                initialRating: widget
                                                        .selectedItem?.rating ??
                                                    3,
                                              ),
                                            ],
                                          ),
                                        )
                                      ])))
                            ],
                          ),
                        );
                      },
                      itemCount: items.length),
                ),
        ));
  }
}
