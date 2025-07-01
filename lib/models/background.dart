import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum Background {
  light,
  dark,
  image,
}

extension BackgroundExtension on Background {
  String get label {
    switch (this) {
      case Background.light:
        return 'Claro';
      case Background.dark:
        return 'Oscuro';
      case Background.image:
        return 'Imagen';
    }
  }

  IconData get icon {
    switch (this) {
      case Background.light:
        return Icons.light_mode;
      case Background.dark:
        return Icons.dark_mode;
      case Background.image:
        return Icons.image;
    }
  }
}