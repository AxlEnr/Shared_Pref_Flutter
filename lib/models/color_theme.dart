import 'package:flutter/material.dart';

enum ColorTheme {
  azul,
  verde,
  purpura,
  naranja,
}

extension ColorThemeExtension on ColorTheme {
  String get label {
    switch (this) {
      case ColorTheme.azul:
        return 'Azul';
      case ColorTheme.verde:
        return 'Verde';
      case ColorTheme.purpura:
        return 'Morado';
      case ColorTheme.naranja:
        return 'Naranja';
    }
  }

  Color get color {
    switch (this) {
      case ColorTheme.azul:
        return Colors.blue;
      case ColorTheme.verde:
        return Colors.green;
      case ColorTheme.purpura:
        return Colors.purple;
      case ColorTheme.naranja:
        return Colors.orange;
    }
  }
}