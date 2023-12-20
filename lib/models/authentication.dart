import 'package:hive_flutter/adapters.dart';
part 'authentication.g.dart';

@HiveType(typeId: 1)
class AuthenticationModels {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String password;
  AuthenticationModels(
      {required this.id,
      required this.name,
      required this.password,
      required this.username});
}
