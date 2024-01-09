import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_travel_app/models/africa.dart';

const _dbName = 'africaBox';

abstract class AfricaDbFunctions {
  Future<List<AfricaDestinationModels>> getCountries();
  Future<void> insertCountry(AfricaDestinationModels value);
  Future<void> deleteCountry(String id);
  Future<void> editCountry(AfricaDestinationModels value, String id);

  Future<bool?> countryExists(String name);
}

class AfricaDb implements AfricaDbFunctions {
  ValueNotifier<List<AfricaDestinationModels>> notifier = ValueNotifier([]);

  AfricaDb._internal();
  static final AfricaDb singleton = AfricaDb._internal();

  factory AfricaDb() {
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
    final db = await Hive.openBox<AfricaDestinationModels>(_dbName);
    final List<AfricaDestinationModels> allCountry = db.values.toList();
    return allCountry.any((country) => country.countryName == name);
  }

  @override
  Future<void> deleteCountry(String id) async {
    final db = await Hive.openBox<AfricaDestinationModels>(_dbName);
    await db.delete(id);
  }

  @override
  Future<List<AfricaDestinationModels>> getCountries() async {
    final db = await Hive.openBox<AfricaDestinationModels>(_dbName);
    return db.values.toList();
  }

  @override
  Future<void> insertCountry(AfricaDestinationModels value) async {
    final db = await Hive.openBox<AfricaDestinationModels>(_dbName);
    await db.put(value.id, value);

    print('data saved');
    refresh();
  }

  @override
  Future<void> editCountry(AfricaDestinationModels value, String id) async {
    final db = await Hive.openBox<AfricaDestinationModels>(_dbName);
    await db.put(id, value);
    refresh();
  }
}
