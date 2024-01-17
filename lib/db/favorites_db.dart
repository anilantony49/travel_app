import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:new_travel_app/models/favorites.dart';

const _dbName = 'favoritesBox';

abstract class FavoritesDbFunctions {
  Future<List<FavoritesModels>> getFavorites();
  Future<void> insertFavorites(FavoritesModels value);
  Future<void> deleteFavorites(String id);
  Future<void> editFavorites(FavoritesModels value, String id);

  Future<bool?> favoritesExists(String name);
}

class FavoritesDb implements FavoritesDbFunctions {
  ValueNotifier<List<FavoritesModels>> notifier = ValueNotifier([]);

  FavoritesDb._internal();
  static final FavoritesDb singleton = FavoritesDb._internal();

  factory FavoritesDb() {
    return singleton;
  }

  Future<void> refresh() async {
    final allfavorites = await getFavorites();
    notifier.value = List.from(allfavorites);
  }

  @override
  Future<bool> favoritesExists(String name) async {
    final db = await Hive.openBox<FavoritesModels>(_dbName);
    final List<FavoritesModels> allfavorites = db.values.toList();
    return allfavorites.any((favorite) => favorite.place == name);
  }

  @override
  Future<void> deleteFavorites(String id) async {
    final db = await Hive.openBox<FavoritesModels>(_dbName);
    await db.delete(id);
  }

  @override
  Future<List<FavoritesModels>> getFavorites() async {
    final db = await Hive.openBox<FavoritesModels>(_dbName);
    return db.values.toList();
  }

  @override
  Future<void> insertFavorites(FavoritesModels value) async {
    final db = await Hive.openBox<FavoritesModels>(_dbName);
    await db.put(value.id, value);

    refresh();
  }

  @override
  Future<void> editFavorites(FavoritesModels value, String id) async {
    final db = await Hive.openBox<FavoritesModels>(_dbName);
    await db.put(id, value);
    refresh();
  }
}
