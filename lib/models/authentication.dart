import 'package:hive_flutter/adapters.dart';
part 'authentication.g.dart';

@HiveType(typeId: 1)
class AuthenticationModels {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String? image;
  @HiveField(2)
  final String username;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String password;
  AuthenticationModels(
      {required this.id,
      this.image,
      required this.username,
      required this.email,
      required this.password});
}
