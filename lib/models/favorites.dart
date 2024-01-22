import 'package:hive_flutter/adapters.dart';
part 'favorites.g.dart';

@HiveType(typeId: 9)
class FavoritesModels {
  @HiveField(0)
  final String id;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final String place;

  FavoritesModels({
    required this.id,
    required this.image,
    required this.place,
  });
}
