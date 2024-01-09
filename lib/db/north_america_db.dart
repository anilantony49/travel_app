import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_travel_app/models/north_america.dart';

const _dbName = 'northAmericaBox';

abstract class NorthAmericaDbFunctions {
  Future<List<NorthAmericaDestinationModels>> getCountries();
  Future<void> insertCountry(NorthAmericaDestinationModels value);
  Future<void> deleteCountry(String id);
  Future<void> editCountry(NorthAmericaDestinationModels value, String id);

  Future<bool?> countryExists(String name);
}

class NorthAmericaDb implements NorthAmericaDbFunctions {
  ValueNotifier<List<NorthAmericaDestinationModels>> notifier =
      ValueNotifier([]);

  NorthAmericaDb._internal();
  static final NorthAmericaDb singleton = NorthAmericaDb._internal();

  factory NorthAmericaDb() {
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
    final db = await Hive.openBox<NorthAmericaDestinationModels>(_dbName);
    final List<NorthAmericaDestinationModels> allCountry = db.values.toList();
    return allCountry.any((country) => country.countryName == name);
  }

  @override
  Future<void> deleteCountry(String id) async {
    final db = await Hive.openBox<NorthAmericaDestinationModels>(_dbName);
    await db.delete(id);
  }

  @override
  Future<List<NorthAmericaDestinationModels>> getCountries() async {
    final db = await Hive.openBox<NorthAmericaDestinationModels>(_dbName);
    return db.values.toList();
  }

  @override
  Future<void> insertCountry(NorthAmericaDestinationModels value) async {
    final db = await Hive.openBox<NorthAmericaDestinationModels>(_dbName);
    await db.put(value.id, value);

    print('data saved');
    refresh();
  }

  @override
  Future<void> editCountry(
      NorthAmericaDestinationModels value, String id) async {
    final db = await Hive.openBox<NorthAmericaDestinationModels>(_dbName);
    await db.put(id, value);
    refresh();
  }
}
