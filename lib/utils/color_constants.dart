import 'dart:ui';
import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class ColorConstants {
  static Color gradientFirstColor = hexToColor('#EE9D00');
  static Color gradientSecondColor = hexToColor('#FF0000');
  static Color solidColor = hexToColor('#F65600');
  static Color disabledColor = Colors.black.withOpacity(0.38);
  static Color regularColor = Colors.black;
}
