import '../models/color_theme.dart';
import '../models/custom_font_style.dart';
import '../models/background.dart';

ColorTheme getColorThemeFromString(String name) {
  switch (name.toLowerCase()) {
    case 'green':
      return ColorTheme.green;
    case 'purple':
      return ColorTheme.purple;
    case 'orange':
      return ColorTheme.orange;
    case 'blue':
    default:
      return ColorTheme.blue;
  }
}

CustomFontStyle getFontStyleFromString(String name) {
  switch (name.toLowerCase()) {
    case 'bold':
      return CustomFontStyle.bold;
    case 'italic':
      return CustomFontStyle.italic;
    case 'bolditalic':
      return CustomFontStyle.boldItalic;
    case 'normal':
    default:
      return CustomFontStyle.normal;
  }
}

Background getBackgroundFromString(String name) {
  switch (name.toLowerCase()) {
    case 'dark':
      return Background.dark;
    case 'image':
      return Background.image;
    case 'light':
    default:
      return Background.light;
  }
}