import 'package:flutter/material.dart';

enum CustomFontStyle {
  normal,
  bold,
  italic,
  boldItalic,
}

extension CustomFontStyleExtension on CustomFontStyle {
  String get label {
    switch (this) {
      case CustomFontStyle.normal:
        return 'Normal';
      case CustomFontStyle.bold:
        return 'Negrita';
      case CustomFontStyle.italic:
        return 'Cursiva';
      case CustomFontStyle.boldItalic:
        return 'Negrita y cursiva';
    }
  }

  FontStyle get style {
    switch (this) {
      case CustomFontStyle.normal:
        return FontStyle.normal;
      case CustomFontStyle.bold:
        return FontStyle.normal;
      case CustomFontStyle.italic:
        return FontStyle.italic;
      case CustomFontStyle.boldItalic:
        return FontStyle.italic;
    }
  }

  FontWeight get weight {
    switch (this) {
      case CustomFontStyle.normal:
      case CustomFontStyle.italic:
        return FontWeight.normal;
      case CustomFontStyle.bold:
      case CustomFontStyle.boldItalic:
        return FontWeight.bold;
    }
  }

  String get name {
    switch (this) {
      case CustomFontStyle.normal:
        return 'normal';
      case CustomFontStyle.bold:
        return 'bold';
      case CustomFontStyle.italic:
        return 'italic';
      case CustomFontStyle.boldItalic:
        return 'bolditalic';
    }
  }

}




