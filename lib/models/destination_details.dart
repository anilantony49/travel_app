import 'package:hive/hive.dart';
part 'destination_details.g.dart';

@HiveType(typeId: 11)
class DestinationModels {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String countryName;
  @HiveField(2)
  final String capital;

  @HiveField(3)
  final String countryImage;
  @HiveField(4)
  final String details;
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
  @HiveField(11)
  final String weather;
  @HiveField(12)
  final String categories;
  @HiveField(13)
  final double rating;

  DestinationModels({
    required this.capital,
    required this.id,
    required this.countryName,
    required this.countryImage,
    required this.knownFor,
    required this.images,
    required this.majorCities,
    required this.language,
    required this.currency,
    required this.digitialCode,
    required this.weather,
    required this.details,
    required this.categories,
    required this.rating,
  });
}
