import 'package:hive/hive.dart';

class KHive {
  static String nameKey = "name";
  static String imageKey = "image";
  static String boolKey = "IsDone";
  static late Box userBox;
  static Future<void> createHiveBox() async {
    userBox = await Hive.openBox("UserBox");
  }

  static pushUserBox(String key, dynamic value)  {
     userBox.put(key, value);
  }

  static popUserBox(dynamic key)  {
    return  userBox.get(key);
  }
}
