import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_travel_app/models/destination_details.dart';

const _dbName = 'destinationDetailsBox';

abstract class DestinationDetailsDbFunctions {
  Future<List<DestinationModels>> getDestination();
  Future<void> insertDestination(DestinationModels value);
  Future<void> deleteDestination(String id);
  Future<void> editDestination(DestinationModels value, String id);

  Future<bool?> destinationExists(String name);
}

class DestinationDb implements DestinationDetailsDbFunctions {
  ValueNotifier<List<DestinationModels>> notifier = ValueNotifier([]);

  DestinationDb._internal();
  static final DestinationDb singleton = DestinationDb._internal();

  factory DestinationDb() {
    return singleton;
  }
  Future<void> refresh() async {
    final alldestinations = await getDestination();
    notifier.value = List.from(alldestinations);
  }

  @override
  Future<bool> destinationExists(String name) async {
    final db = await Hive.openBox<DestinationModels>(_dbName);
    final List<DestinationModels> alldestinations = db.values.toList();
    return alldestinations
        .any((destination) => destination.countryName == name);
  }

  @override
  Future<void> deleteDestination(String id) async {
    final db = await Hive.openBox<DestinationModels>(_dbName);
    await db.delete(id);
  }

  @override
  Future<List<DestinationModels>> getDestination() async {
    final db = await Hive.openBox<DestinationModels>(_dbName);
    return db.values.toList();
  }

  @override
  Future<void> insertDestination(DestinationModels value) async {
    final db = await Hive.openBox<DestinationModels>(_dbName);
    await db.put(value.id, value);

    refresh();
  }

  @override
  Future<void> editDestination(DestinationModels value, String id) async {
    final db = await Hive.openBox<DestinationModels>(_dbName);
    await db.put(id, value);
    refresh();
  }
}
