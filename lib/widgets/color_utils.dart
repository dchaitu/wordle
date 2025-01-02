import 'package:flutter/material.dart';

int getColorIntegerFromHex(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll('#', '');
  if (hexColor.length == 6) {
    hexColor = 'FF$hexColor';
  }

  return int.parse(hexColor, radix: 16);
}

class HexColor extends Color {
  HexColor(final String hexColor)
      : super(
    getColorIntegerFromHex(hexColor),
  );
}
