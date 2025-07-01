import 'package:flutter/material.dart';
import 'package:shared_pref/pages/home.dart';

extension ColorThemeExtension on ColorTheme {
  String get label {
    switch (this) {
      case ColorTheme.blue:
        return 'Azul';
      case ColorTheme.green:
        return 'Verde';
      case ColorTheme.purple:
        return 'Morado';
      case ColorTheme.orange:
        return 'Naranja';
    }
  }

  Color get color {
    switch (this) {
      case ColorTheme.blue:
        return Colors.blueAccent;
      case ColorTheme.green:
        return Colors.green;
      case ColorTheme.purple:
        return Colors.purple;
      case ColorTheme.orange:
        return Colors.orange;
    }
  }
}