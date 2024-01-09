import 'package:hive_flutter/adapters.dart';
part 'asia.g.dart';

@HiveType(typeId: 7)
class AsiaDestinationModels {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String countryName;
  @HiveField(2)
  final String countryImage;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String capital;
  @HiveField(5)
  final List<String> knownFor;
  @HiveField(6)
  final List<String> images;
  @HiveField(7)
  final List<String> majorCities;
  @HiveField(8)
  final String language;
  @HiveField(9)
  final String currency;
  @HiveField(10)
  final String digitialCode;
  @HiveField(14)
  final String weather;
  @HiveField(15)
  final int police;
  @HiveField(16)
  final int ambulance;
  @HiveField(17)
  final int fire;

  AsiaDestinationModels({
    required this.id,
    required this.countryName,
    required this.countryImage,
    required this.description,
    required this.capital,
    required this.knownFor,
    required this.images,
    required this.majorCities,
    required this.language,
    required this.currency,
    required this.digitialCode,
    required this.weather,
    required this.police,
    required this.ambulance,
    required this.fire,
  });
}
