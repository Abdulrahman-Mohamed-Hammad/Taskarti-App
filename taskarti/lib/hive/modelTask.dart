import 'package:hive/hive.dart';
part 'modelTask.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  String date;
  @HiveField(4)
  String startTime;
  @HiveField(5)
  String endTime;
  @HiveField(6)
  int color;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.color = 0,
  });
}
