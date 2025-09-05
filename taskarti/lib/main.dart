import 'package:flutter/material.dart';
import 'package:taskarti/feature/AddTask.dart';
import 'package:taskarti/feature/Home.dart';
import 'package:taskarti/feature/pickerImage.dart';
import 'package:taskarti/feature/splashScreen.dart';

import 'package:taskarti/utils/ConstantsColors.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {"A": (context) => Pickerimage(),
      "B":(context) =>Home(),"C":(context)=>AddTask()},
      theme: ThemeData(
        scaffoldBackgroundColor: Kcolors.white,
        appBarTheme: AppBarTheme(backgroundColor: Kcolors.white),
      ),
      home: Scaffold(body: Splashscreen()),
    );
  }
}
