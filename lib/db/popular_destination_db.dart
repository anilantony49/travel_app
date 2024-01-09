import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_travel_app/models/popular_destination.dart';

const _dbName = 'popularDestinationBox';

abstract class PopularDestinationDbFunctions {
  Future<List<PopularDestinationModels>> getCountries();
  Future<void> insertCountry(PopularDestinationModels value);
  Future<void> deleteCountry(String id);
  Future<void> editCountry(PopularDestinationModels value, String id);

  Future<bool?> countryExists(String name);
}

class PopularDestinationDb implements PopularDestinationDbFunctions {
  ValueNotifier<List<PopularDestinationModels>> notifier = ValueNotifier([]);

  PopularDestinationDb._internal();
  static final PopularDestinationDb singleton =
      PopularDestinationDb._internal();

  factory PopularDestinationDb() {
    return singleton;
  }

  // Future<void> refresh() async {
  //   final allCountry = await getCountries();
  //   notifier.value.clear();
  //   await Future.forEach(allCountry,
  //       (PopularDestinationModels country) => notifier.value.add(country));
  //   notifier.notifyListeners();
  // }
  Future<void> refresh() async {
    final allCountry = await getCountries();
    notifier.value = List.from(allCountry);
  }

  @override
  Future<bool> countryExists(String name) async {
    final db = await Hive.openBox<PopularDestinationModels>(_dbName);
    final List<PopularDestinationModels> allCountry = db.values.toList();
    return allCountry.any((country) => country.countryName == name);
  }

  @override
  Future<void> deleteCountry(String id) async {
    final db = await Hive.openBox<PopularDestinationModels>(_dbName);
    await db.delete(id);
  }

  @override
  Future<List<PopularDestinationModels>> getCountries() async {
    final db = await Hive.openBox<PopularDestinationModels>(_dbName);
    return db.values.toList();
  }

  @override
  Future<void> insertCountry(PopularDestinationModels value) async {
    final db = await Hive.openBox<PopularDestinationModels>(_dbName);
    await db.put(value.id, value);

    print('data saved');
    refresh();
  }

  @override
  Future<void> editCountry(PopularDestinationModels value, String id) async {
    final db = await Hive.openBox<PopularDestinationModels>(_dbName);
    await db.put(id, value);
    refresh();
  }
}
