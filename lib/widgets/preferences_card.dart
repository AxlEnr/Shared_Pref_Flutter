import 'package:flutter/material.dart';
import '../models/color_theme.dart';
import '../models/custom_font_style.dart';

class PreferenceCard extends StatelessWidget {
  final String title;
  final String value;
  final ColorTheme colorTheme;
  final CustomFontStyle fontStyle;
  final bool isDark;

  const PreferenceCard({
    super.key,
    required this.title,
    required this.value,
    required this.colorTheme,
    required this.fontStyle,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: isDark ? Colors.grey[700] : Colors.white,
      child: ListTile(
        leading: Icon(Icons.info_outline, color: colorTheme.color),
        title: Text(
          title,
          style: TextStyle(
            fontStyle: fontStyle.style,
            fontWeight: fontStyle.weight,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          value,
          style: TextStyle(
            fontStyle: fontStyle.style,
            fontWeight: fontStyle.weight,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
        ),
      ),
    );
  }
}