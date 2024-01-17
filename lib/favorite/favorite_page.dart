import 'dart:io';

import 'package:flutter/material.dart';
import 'package:new_travel_app/db/favorites_db.dart';
import 'package:new_travel_app/models/favorites.dart';
import 'package:new_travel_app/others/contants.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

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
        duration: Duration(seconds: 3),
      ),
    );

    fetchFavorites();
  }

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.greenColor,
        centerTitle: true,
        title: const Text('Favorites'),
      ),
      body: items.isEmpty
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
                    'Favotite List is empty',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            )
          : ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                final FavoritesModels favorites = items[index];
                return Card(
                  elevation: 5,
                  child: ListTile(
                    // subtitle: Text(favorites.place),
                    trailing: IconButton(
                        onPressed: () {
                          removeFavoritesAndShowSnackbar(favorites.id);  
                          //  removeFavoritesAndShowSnackbar(plannedTrip.id);
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //         content: Text('An item has been deleted')));
                          // setState(() {
                          //     isFavorite = !isFavorite;
                          //   }); 
                        },
                        icon: const Icon(
                            Icons.favorite,
                            color:  Colors.red 
                          ),),
                    leading: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: favorites.image.isNotEmpty &&
                                    File(favorites.image).existsSync()
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(
                                      File(favorites.image),
                                      fit: BoxFit.fill,
                                    ),
                                  )
                                : const Center(
                                    child: Icon(
                                      Icons.image,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ))),
                    title: Text(favorites.place),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 2,
                  color: Colors.grey,
                );
              },
              itemCount: items.length),
    );
  }
}
