
import 'package:flutter/cupertino.dart';

class HexColor extends Color {

  HexColor(String color): super(_getColorFromHex(color));

  static int _getColorFromHex(String color) {
    color = color.toUpperCase().replaceAll('#', '');
    if(color.length == 6) {
      color = 'FF' + color;
    }
    return int.parse(color, radix: 16);
  }
}