import 'package:flutter/material.dart';

enum MenuEntry {
  masculino,
  femenino,
  otro,
}

extension MenuEntryExtension on MenuEntry {
  String get label {
    switch (this) {
      case MenuEntry.masculino:
        return 'Masculino';
      case MenuEntry.femenino:
        return 'Femenino';
      case MenuEntry.otro:
        return 'Otro';
    }
  }

  IconData get icon {
    switch (this) {
      case MenuEntry.masculino:
        return Icons.male;
      case MenuEntry.femenino:
        return Icons.female;
      case MenuEntry.otro:
        return Icons.transgender;
    }
  }
}