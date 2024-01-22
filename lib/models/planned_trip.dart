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

  PlannedTripModels({
    required this.id,
    required this.date,
    required this.image,
    required this.place,
  });
}
