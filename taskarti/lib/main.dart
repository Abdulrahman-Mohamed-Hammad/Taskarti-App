import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:taskarti/feature/AddTask.dart';
import 'package:taskarti/feature/Home.dart';
import 'package:taskarti/feature/changeImageAndName.dart';
import 'package:taskarti/feature/pickerImage.dart';
import 'package:taskarti/feature/splashScreen.dart';
import 'package:taskarti/hive/hive.dart';

import 'package:taskarti/utils/ConstantsColors.dart';

void main() async {
  await Hive.initFlutter("Db");
  await KHive.createHiveBox();
  
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: KHive.userBox.listenable(),
      builder: (context, value, child) {
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "A": (context) => Pickerimage(),
          "B": (context) => Home(),
          "C": (context) => AddTask(),
          "D": (context) => ChangeIMageAndNameScreen(),
        },
        theme: ThemeData(
            colorScheme: ColorScheme.dark(primary: Kcolors.black,onSurface: Kcolors.black),
          scaffoldBackgroundColor: Kcolors.white,
          appBarTheme: AppBarTheme(backgroundColor: Kcolors.white),
        
        ),
        
        darkTheme: ThemeData(
          colorScheme: ColorScheme.dark(primary: Kcolors.white),
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.black,
      )),
      themeMode: KHive.popUserBox(KHive.themeModeKey) ==null ? ThemeMode.light:ThemeMode.dark,
      
        home: Scaffold(body: Splashscreen()),
      );
      },
  
    );
  }
}
