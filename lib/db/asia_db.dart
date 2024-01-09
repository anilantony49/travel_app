import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_travel_app/models/asia.dart';

const _dbName = 'asiaBox';

abstract class AsiaDbFunctions {
  Future<List<AsiaDestinationModels>> getCountries();
  Future<void> insertCountry(AsiaDestinationModels value);
  Future<void> deleteCountry(String id);
  Future<void> editCountry(AsiaDestinationModels value, String id);

  Future<bool?> countryExists(String name);
}

class AsiaDb implements AsiaDbFunctions {
  ValueNotifier<List<AsiaDestinationModels>> notifier = ValueNotifier([]);

  AsiaDb._internal();
  static final AsiaDb singleton = AsiaDb._internal();

  factory AsiaDb() {
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
    final db = await Hive.openBox<AsiaDestinationModels>(_dbName);
    final List<AsiaDestinationModels> allCountry = db.values.toList();
    return allCountry.any((country) => country.countryName == name);
  }

  @override
  Future<void> deleteCountry(String id) async {
    final db = await Hive.openBox<AsiaDestinationModels>(_dbName);
    await db.delete(id);
  }

  @override
  Future<List<AsiaDestinationModels>> getCountries() async {
    final db = await Hive.openBox<AsiaDestinationModels>(_dbName);
    return db.values.toList();
  }

  @override
  Future<void> insertCountry(AsiaDestinationModels value) async {
    final db = await Hive.openBox<AsiaDestinationModels>(_dbName);
    await db.put(value.id, value);

    print('data saved');
    refresh();
  }

  @override
  Future<void> editCountry(AsiaDestinationModels value, String id) async {
    final db = await Hive.openBox<AsiaDestinationModels>(_dbName);
    await db.put(id, value);
    refresh();
  }
}
