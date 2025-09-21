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
  @HiveField(7)
  bool isComplete=false;

  TaskModel({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.color = 0,
  });

  void copyModel({
    String? title,
    String? description,
    String? date,
    String? startTime,
    String? endTime,
    int? color,bool? isComplete,
  
  }) {
    this.title = title ?? this.title;
    this.description = description ?? this.description;
    this.date = date ?? this.date;
    this.startTime = startTime ?? this.startTime;
    this.endTime = endTime ?? this.endTime;
    this.color = color ?? this.color;
    this.isComplete =isComplete ?? this.isComplete;
    
  }
}
