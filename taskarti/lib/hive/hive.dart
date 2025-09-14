import 'package:hive/hive.dart';
import 'package:taskarti/hive/modelTask.dart';

class KHive {
  static String nameKey = "name";
  static String imageKey = "image";
  static String boolKey = "IsDone";
  static late Box userBox;
  static late Box<TaskModel> taskModel;

  static Future<void> createHiveBox() async {
    Hive.registerAdapter<TaskModel>(TaskModelAdapter());
    userBox = await Hive.openBox("UserBox");
    taskModel = await Hive.openBox("taskModel");
  }

  static pushUserBox(String key, dynamic value) {
    userBox.put(key, value);
  }

  static popUserBox(dynamic key) {
    return userBox.get(key);
  }

  static pushTaskModel(String key, TaskModel value) {
    taskModel.put(key, value);
  }

  static popTaskModel(dynamic key) {
    return taskModel.get(key);
  }
}
