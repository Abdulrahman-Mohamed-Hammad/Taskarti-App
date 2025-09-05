import 'package:flutter/material.dart';
import 'package:taskarti/utils/ConstantsColors.dart';

class Kfonts {
  static const String family = "Poppins";

  static TextStyle? textStyle({
    Color color = Kcolors.black,
    double fontSize = 14,
    fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      color: color,
      fontFamily: family,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}
