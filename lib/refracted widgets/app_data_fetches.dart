import 'package:new_travel_app/db/authentication_db.dart';
import 'package:new_travel_app/db/favorites_db.dart';
import 'package:new_travel_app/models/authentication.dart';
import 'package:new_travel_app/models/destination_details.dart';
import 'package:new_travel_app/models/favorites.dart';

class DataFetcher {
  static List<AuthenticationModels> authenticationItems = [];
  static List<FavoritesModels> favoritesItems = [];
  static List<DestinationModels> destinationItems = [];

  static Future<void> fetchUsers() async {
    authenticationItems = await AuthenticationDb.singleton.getUsers();
  }

  static Future<void> fetchFavorites() async {
    favoritesItems = await FavoritesDb.singleton.getFavorites();
  }
}
