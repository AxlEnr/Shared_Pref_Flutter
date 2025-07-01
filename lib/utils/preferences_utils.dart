import '../models/color_theme.dart';
import '../models/custom_font_style.dart';
import '../models/background.dart';

ColorTheme getColorThemeFromString(String name) {
  switch (name.toLowerCase()) {
    case 'verde':
      return ColorTheme.verde;
    case 'purpura':
      return ColorTheme.purpura;
    case 'naranja':
      return ColorTheme.naranja;
    case 'azul':
    default:
      return ColorTheme.azul;
  }
}


CustomFontStyle getFontStyleFromString(String name) {
  switch (name.toLowerCase()) {
    case 'negrita':
      return CustomFontStyle.negrita;
    case 'cursiva':
      return CustomFontStyle.cursiva;
    case 'negritaCursiva':
      return CustomFontStyle.negritaCursiva;
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