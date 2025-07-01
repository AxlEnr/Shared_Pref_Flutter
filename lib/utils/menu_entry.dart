// Gender Enum
import 'package:flutter/material.dart';

enum MenuEntry {
  genre1,
  genre2,
  genreOther,
}

extension MenuEntryExtension on MenuEntry {
  String get label {
    switch (this) {
      case MenuEntry.genre1:
        return 'Masculino';
      case MenuEntry.genre2:
        return 'Femenino';
      case MenuEntry.genreOther:
        return 'Otro';
    }
  }

  IconData get icon {
    switch (this) {
      case MenuEntry.genre1:
        return Icons.male;
      case MenuEntry.genre2:
        return Icons.female;
      case MenuEntry.genreOther:
        return Icons.transgender;
    }
  }
}

// Color Theme Enum
enum ColorTheme {
  blue,
  green,
  purple,
  orange,
}

// Font Style Enum
enum CustomFontStyle {
  normal,
  bold,
  italic,
  boldItalic,
}