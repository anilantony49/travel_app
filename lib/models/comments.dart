import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:new_travel_app/refracted_widgets/app_string.dart';
part 'comments.g.dart';

@HiveType(typeId: 12)
class CommentModels {
  @HiveField(0)
  final int userid;
  @HiveField(1)
  final String commentindex;
  @HiveField(2)
  final String comment;
  @HiveField(3)
  final DateTime date;

  CommentModels({
    required this.commentindex,
    required this.userid,
    required this.comment,
    required this.date,
  });
  String get formattedDate => DateFormat(AppStrings.dateformate).format(date);
  String get formattedTime => DateFormat(AppStrings.timeformate).format(date);
}
