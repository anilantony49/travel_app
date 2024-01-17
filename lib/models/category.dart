import 'package:hive/hive.dart';
part 'category.g.dart';

@HiveType(typeId: 13)
class CategoryModels {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String category;

  CategoryModels({required this.id, required this.category});
}
