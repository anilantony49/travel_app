import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_travel_app/models/category.dart';

const _dbName = 'categoryBox';

abstract class CategoryDbFunctions {
  Future<List<CategoryModels>> getCategory();
  Future<void> insertCategory(CategoryModels value);
  Future<void> deleteCategory(String id);
  Future<void> editCategory(CategoryModels value, String id);
  Future<bool?> categoryExists(String name);
}

class CategoryDb implements CategoryDbFunctions {
  ValueNotifier<List<CategoryModels>> userNotifier = ValueNotifier([]);

  CategoryDb._internal();
  static final CategoryDb singleton = CategoryDb._internal();

  factory CategoryDb() {
    return singleton;
  }

  Future<void> refresh() async {
    final allCategory = await getCategory();
    userNotifier.value = List.from(allCategory);
  }

  @override
  Future<void> deleteCategory(String id) async {
    final db = await Hive.openBox<CategoryModels>(_dbName);
    await db.delete(id);
  }

  @override
  Future<List<CategoryModels>> getCategory() async {
    final db = await Hive.openBox<CategoryModels>(_dbName);
    return db.values.toList();
  }

  @override
  Future<void> insertCategory(CategoryModels value) async {
    final db = await Hive.openBox<CategoryModels>(_dbName);
    await db.put(value.category, value);

    refresh();
  }

  @override
  Future<bool> categoryExists(String name) async {
    final db = await Hive.openBox<CategoryModels>(_dbName);
    final List<CategoryModels> allCategory = db.values.toList();

    return allCategory.any((category) => category.category == name);
  }

  @override
  Future<void> editCategory(CategoryModels value, String id) async {
    final db = await Hive.openBox<CategoryModels>(_dbName);
    await db.put(id, value);
    refresh();
  }
}
