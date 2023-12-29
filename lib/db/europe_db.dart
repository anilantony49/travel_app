import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_travel_app/models/europe.dart';

const _dbName = 'europeBox';

abstract class EuropeDbFunctions {
  Future<List<EuropeDestinationModels>> getCountries();
  Future<void> insertCountry(EuropeDestinationModels value);
  Future<void> deleteCountry(String id);
  Future<void> editCountry(EuropeDestinationModels value, String id);

  Future<bool?> countryExists(String name);
}

class EuropeDb implements EuropeDbFunctions {
  ValueNotifier<List<EuropeDestinationModels>> notifier = ValueNotifier([]);

  EuropeDb._internal();
  static final EuropeDb singleton = EuropeDb._internal();

  factory EuropeDb() {
    return singleton;
  }

  Future<void> refresh() async {
    final allCountry = await getCountries();
    notifier.value.clear();
    await Future.forEach(allCountry,
        (EuropeDestinationModels country) => notifier.value.add(country));
    notifier.notifyListeners();
  }

  @override
  Future<bool> countryExists(String name) async {
    final db = await Hive.openBox<EuropeDestinationModels>(_dbName);
    final List<EuropeDestinationModels> allCountry = db.values.toList();
    return allCountry.any((country) => country.countryName == name);
  }

  @override
  Future<void> deleteCountry(String id) async {
    final db = await Hive.openBox<EuropeDestinationModels>(_dbName);
    await db.delete(id);
  }

  @override
  Future<List<EuropeDestinationModels>> getCountries() async {
    final db = await Hive.openBox<EuropeDestinationModels>(_dbName);
    return db.values.toList();
  }

  @override
  Future<void> insertCountry(EuropeDestinationModels value) async {
    final db = await Hive.openBox<EuropeDestinationModels>(_dbName);
    await db.put(value.id, value);

    print('data saved');
    refresh();
  }

  @override
  Future<void> editCountry(EuropeDestinationModels value, String id) async {
    final db = await Hive.openBox<EuropeDestinationModels>(_dbName);
    await db.put(id, value);
    refresh();
  }
}
