import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_travel_app/models/authentication.dart';


const _dbName = 'authenticationBox';

abstract class AuthenticationDbFunctions {
  Future<List<AuthenticationModels>> getUsers();
  Future<void> insertUsers(AuthenticationModels value);
  Future<void> deleteUsers(String userId);
  // Future<void> editUsers(AuthenticationModels value, String studentId);
  Future<bool?> usernameExists(String username);
}

class AuthenticationDb implements AuthenticationDbFunctions {
  ValueNotifier<List<AuthenticationModels>> userNotifier = ValueNotifier([]);

  AuthenticationDb._internal();
  static final AuthenticationDb singleton = AuthenticationDb._internal();

  factory AuthenticationDb() {
    return singleton;  
  }
  // Future<void> refresh() async {
  //   final allUsers = await getUsers();
  //   userNotifier.value.clear();
  //   await Future.forEach(allUsers,
  //       (AuthenticationModels users) => userNotifier.value.add(users));
  //   userNotifier.notifyListeners();
  // }
  Future<void> refresh() async {
    final allCountry = await getUsers();
    userNotifier.value = List.from(allCountry);
  }
  @override
  Future<void> deleteUsers(String userId) async {
    final db = await Hive.openBox<AuthenticationModels>(_dbName);
    await db.delete(userId);
  }

  // @override
  // Future<void> editUsers(AuthenticationModels value, String studentId) {
  //   throw UnimplementedError();
  // }

  @override
  Future<List<AuthenticationModels>> getUsers() async {
    final db = await Hive.openBox<AuthenticationModels>(_dbName);
    return db.values.toList();
  }

  @override
  Future<void> insertUsers(AuthenticationModels value) async {
    final db = await Hive.openBox<AuthenticationModels>(_dbName);
    await db.put(value.id, value);
    print('data saved');
    refresh();
  }

  @override
  Future<bool> usernameExists(String username) async {
    final db = await Hive.openBox<AuthenticationModels>(_dbName);
    final List<AuthenticationModels> allUsers = db.values.toList();

    // Check if any user has the provided username
    return allUsers.any((user) => user.username == username);
  }
}
