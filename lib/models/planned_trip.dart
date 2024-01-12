import 'package:hive_flutter/adapters.dart';
part 'planned_trip.g.dart';

@HiveType(typeId: 8)
class PlannedTripModels {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String date;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final String place;
  // @HiveField(4)
  // final String capital;
  // @HiveField(5)
  // final List<String> knownFor;
  // @HiveField(6)
  // final List<String> images;
  // @HiveField(7)
  // final List<String> majorCities;
  // @HiveField(8)
  // final String language;
  // @HiveField(9)
  // final String currency;
  // @HiveField(10)
  // final String digitialCode;
  // @HiveField(14)
  // final String weather;
  // @HiveField(15)
  // final int police;
  // @HiveField(16)
  // final int ambulance;
  // @HiveField(17)
  // final int fire;

  PlannedTripModels({
    required this.id,
    required this.date,
    required this.image,
    required this.place,
    // required this.capital,
    // required this.knownFor,
    // required this.images,
    // required this.majorCities,
    // required this.language,
    // required this.currency,
    // required this.digitialCode,
    // required this.weather,
    // required this.police,
    // required this.ambulance,
    // required this.fire,
  });
}
