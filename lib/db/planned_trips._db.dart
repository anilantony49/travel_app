import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_travel_app/models/planned_trip.dart';

const _dbName = 'plannedTripBox';

abstract class PlannedTripDbFunctions {
  Future<List<PlannedTripModels>> getAllTrip();
  Future<void> insertTrip(PlannedTripModels value);
  Future<void> deleteTrip(String id);
  Future<void> editTrip(PlannedTripModels value, String id);

  Future<bool?> tripExists(String name);
}

class PlannedTripDb implements PlannedTripDbFunctions {
  ValueNotifier<List<PlannedTripModels>> notifier = ValueNotifier([]);

  PlannedTripDb._internal();
  static final PlannedTripDb singleton = PlannedTripDb._internal();

  factory PlannedTripDb() {
    return singleton;
  }

  Future<void> refresh() async {
    final allTrip = await getAllTrip();
    notifier.value = List.from(allTrip);
  }

  @override
  Future<bool> tripExists(String name) async {
    final db = await Hive.openBox<PlannedTripModels>(_dbName);
    final List<PlannedTripModels> allTrip = db.values.toList();
    return allTrip.any((trip) => trip.place == name);
  }

  @override
  Future<void> deleteTrip(String id) async {
    final db = await Hive.openBox<PlannedTripModels>(_dbName);
    await db.delete(id);
  }

  @override
  Future<List<PlannedTripModels>> getAllTrip() async {
    final db = await Hive.openBox<PlannedTripModels>(_dbName);
    return db.values.toList();
  }

  @override
  Future<void> insertTrip(PlannedTripModels value) async {
    final db = await Hive.openBox<PlannedTripModels>(_dbName);
    await db.put(value.id, value);
    refresh();
  }

  @override
  Future<void> editTrip(PlannedTripModels value, String id) async {
    final db = await Hive.openBox<PlannedTripModels>(_dbName);
    await db.put(id, value);
    refresh();
  }
}
