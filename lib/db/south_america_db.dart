import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_travel_app/models/south_america.dart';

const _dbName = 'southAmericaBox';

abstract class SouthAmericaDbFunctions {
  Future<List<SouthAmericaDestinationModels>> getCountries();
  Future<void> insertCountry(SouthAmericaDestinationModels value);
  Future<void> deleteCountry(String id);
  Future<void> editCountry(SouthAmericaDestinationModels value, String id);

  Future<bool?> countryExists(String name);
}

class SouthAmericaDb implements SouthAmericaDbFunctions {
  ValueNotifier<List<SouthAmericaDestinationModels>> notifier =
      ValueNotifier([]);

  SouthAmericaDb._internal();
  static final SouthAmericaDb singleton = SouthAmericaDb._internal();

  factory SouthAmericaDb() {
    return singleton;
  }

  // Future<void> refresh() async {
  //   final allCountry = await getCountries();
  //   notifier.value.clear();
  //   await Future.forEach(allCountry,
  //       (AfricaDestinationModels country) => notifier.value.add(country));
  //   notifier.notifyListeners();
  // }
  Future<void> refresh() async {
    final allCountry = await getCountries();
    notifier.value = List.from(allCountry);
  }

  @override
  Future<bool> countryExists(String name) async {
    final db = await Hive.openBox<SouthAmericaDestinationModels>(_dbName);
    final List<SouthAmericaDestinationModels> allCountry = db.values.toList();
    return allCountry.any((country) => country.countryName == name);
  }

  @override
  Future<void> deleteCountry(String id) async {
    final db = await Hive.openBox<SouthAmericaDestinationModels>(_dbName);
    await db.delete(id);
  }

  @override
  Future<List<SouthAmericaDestinationModels>> getCountries() async {
    final db = await Hive.openBox<SouthAmericaDestinationModels>(_dbName);
    return db.values.toList();
  }

  @override
  Future<void> insertCountry(SouthAmericaDestinationModels value) async {
    final db = await Hive.openBox<SouthAmericaDestinationModels>(_dbName);
    await db.put(value.id, value);

    print('data saved');
    refresh();
  }

  @override
  Future<void> editCountry(
      SouthAmericaDestinationModels value, String id) async {
    final db = await Hive.openBox<SouthAmericaDestinationModels>(_dbName);
    await db.put(id, value);
    refresh();
  }
}
