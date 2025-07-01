import 'package:flutter/material.dart';

enum MenuEntry {
  male,
  female,
  other,
}

extension MenuEntryExtension on MenuEntry {
  String get label {
    switch (this) {
      case MenuEntry.male:
        return 'Masculino';
      case MenuEntry.female:
        return 'Femenino';
      case MenuEntry.other:
        return 'Otro';
    }
  }

  IconData get icon {
    switch (this) {
      case MenuEntry.male:
        return Icons.male;
      case MenuEntry.female:
        return Icons.female;
      case MenuEntry.other:
        return Icons.transgender;
    }
  }
}