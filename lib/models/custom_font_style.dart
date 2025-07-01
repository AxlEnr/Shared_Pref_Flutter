import 'package:flutter/material.dart';

enum CustomFontStyle {
  normal,
  negrita,
  cursiva,
  negritaCursiva,
}

extension CustomFontStyleExtension on CustomFontStyle {
  String get label {
    switch (this) {
      case CustomFontStyle.normal:
        return 'Normal';
      case CustomFontStyle.negrita:
        return 'Negrita';
      case CustomFontStyle.cursiva:
        return 'Cursiva';
      case CustomFontStyle.negritaCursiva:
        return 'Negrita y cursiva';
    }
  }

  FontStyle get style {
    switch (this) {
      case CustomFontStyle.normal:
        return FontStyle.normal;
      case CustomFontStyle.negrita:
        return FontStyle.normal;
      case CustomFontStyle.cursiva:
        return FontStyle.italic;
      case CustomFontStyle.negritaCursiva:
        return FontStyle.italic;
    }
  }

  FontWeight get weight {
    switch (this) {
      case CustomFontStyle.normal:
      case CustomFontStyle.cursiva:
        return FontWeight.normal;
      case CustomFontStyle.negrita:
      case CustomFontStyle.negritaCursiva:
        return FontWeight.bold;
    }
  }

  String get name {
    switch (this) {
      case CustomFontStyle.normal:
        return 'normal';
      case CustomFontStyle.negrita:
        return 'bold';
      case CustomFontStyle.cursiva:
        return 'italic';
      case CustomFontStyle.negritaCursiva:
        return 'bolditalic';
    }
  }

}




