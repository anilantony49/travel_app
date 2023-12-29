import 'package:hive_flutter/adapters.dart';
part 'europe.g.dart';

@HiveType(typeId: 3)
class EuropeDestinationModels {
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
  // @HiveField(4)
  // final List <String> knownFor;
  @HiveField(5)
  final List<String> images;
  // @HiveField(6)
  // final String majorCities;
  @HiveField(7)
  final String language;
  @HiveField(8)
  final String currency;
  @HiveField(9)
  final String digitialCode;
  // @HiveField(10)
  // final String mobilePhoneOperators;
  // @HiveField(11)
  // final String plugType;
  // @HiveField(12)
  // final String mainAirPorts;
  // @HiveField(13)
  // final String drivingSide;
  @HiveField(14)
  final String weather;
  @HiveField(15)
  final int police;
  @HiveField(16)
  final int ambulance;
  @HiveField(17)
  final int fire;

  EuropeDestinationModels(
      {required this.id,
      required this.countryName,
      required this.countryImage,
      required this.description,
       required this.capital,
      // required this.knownFor,
      required this.images,
      // required this.majorCities,
      required this.language,
      required this.currency,
      required this.digitialCode,
      // required this.mobilePhoneOperators,
      // required this.plugType,
      // required this.mainAirPorts,
      // required this.drivingSide,
      required this.weather,
      required this.police,
      required this.ambulance,
      required this.fire,
      });
}
