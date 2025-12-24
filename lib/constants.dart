import 'package:flutter/material.dart';

final sudokuColors = {
  "PRIMARY": const Color.fromARGB(255, 187, 224, 255),
  "ALTERNATIVE": const Color.fromARGB(255, 176, 220, 255),
  "CENTER": const Color.fromARGB(255, 155, 210, 255),
};

final TextStyle sudokuNumFont = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w700,
);

// add string extension to capitalize first letter
extension StringExtension on String {
  String capitalize() {
    return this[0].toUpperCase() + substring(1);
  }
}
