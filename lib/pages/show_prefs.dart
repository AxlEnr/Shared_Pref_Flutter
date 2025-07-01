import 'package:flutter/material.dart';
import 'package:shared_pref/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_pref/utils/colors.dart';
import 'package:shared_pref/utils/custom_font_style.dart';

class ShowPrefs extends StatefulWidget {
  const ShowPrefs({super.key, required this.title});
  final String title;

  @override
  State<ShowPrefs> createState() => _ShowPrefsState();
}

class _ShowPrefsState extends State<ShowPrefs> {
  Map<String, String> prefsMap = {};
  ColorTheme selectedColor = ColorTheme.blue;
  CustomFontStyle selectedFont = CustomFontStyle.normal;
  Background selectedBackground = Background.light;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      String? colorTheme = prefs.getString('theme');
      String? fontStyle = prefs.getString('font');
      String? background = prefs.getString('background');

      selectedColor = _getColorThemeFromString(colorTheme ?? 'blue');
      selectedFont = _getFontStyleFromString(fontStyle ?? 'normal');
      selectedBackground = _getBackgroundFromString(background ?? 'light');

      prefsMap = {
        'Nombre': prefs.getString('name') ?? '',
        'Primer apellido': prefs.getString('fn') ?? '',
        'Segundo apellido': prefs.getString('sn') ?? '',
        'Fondo': prefs.getString('background') ?? '',
        'Tema': prefs.getString('theme') ?? '',
        'Fuente': prefs.getString('font') ?? '',
        'Género': prefs.getString('gender') ?? '',
      };
    });
  }

  Future<void> _deleteShared() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    setState(() {
      prefsMap.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Preferencias eliminadas',
          style: TextStyle(
            fontStyle: selectedFont.style,
            fontWeight: selectedFont.weight,
          ),
        ),
        backgroundColor: selectedColor.color,
      ),
    );
  }

  ColorTheme _getColorThemeFromString(String name) {
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

  CustomFontStyle _getFontStyleFromString(String name) {
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

  Background _getBackgroundFromString(String name) {
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

  BoxDecoration _getBackgroundDecoration() {
    switch (selectedBackground) {
      case Background.light:
        return BoxDecoration(color: Colors.grey[100]);
      case Background.dark:
        return BoxDecoration(color: Colors.grey[800]);
      case Background.image:
        return BoxDecoration(
          image: DecorationImage(
            image: AssetImage('https://picsum.photos/800/1600'),
            fit: BoxFit.cover,
          ),
        );
    }
  }

 @override
  Widget build(BuildContext context) {
    final bool isDark = selectedBackground == Background.dark;
    final bool isImage = selectedBackground == Background.image;

    return Container(
      decoration: _getBackgroundDecoration(),
      child: Scaffold(
        backgroundColor: Colors.transparent, 
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(
              fontStyle: selectedFont.style,
              fontWeight: selectedFont.weight,
              color: Colors.white,
            ),
          ),
          elevation: 4,
          backgroundColor: selectedColor.color,
        ),
        body: Column(
          children: [
            // Botones
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _loadPreferences,
                    icon: Icon(Icons.refresh, color: Colors.white),
                    label: Text(
                      'Recargar',
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: selectedFont.style,
                        fontWeight: selectedFont.weight,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedColor.color,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _deleteShared,
                    icon: Icon(Icons.delete_forever, color: Colors.white),
                    label: Text(
                      'Eliminar',
                      style: TextStyle(
                        color: Colors.white,
                        fontStyle: selectedFont.style,
                        fontWeight: selectedFont.weight,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),

            // Lista
            Expanded(
              child: prefsMap.isEmpty
                  ? Center(
                      child: Text(
                        'No hay preferencias guardadas.',
                        style: TextStyle(
                          fontStyle: selectedFont.style,
                          fontWeight: selectedFont.weight,
                          color: isDark || isImage ? Colors.white : Colors.black,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: prefsMap.length,
                      itemBuilder: (context, index) {
                        String key = prefsMap.keys.elementAt(index);
                        String value = prefsMap[key]!;
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          color: isDark ? Colors.grey[700] : Colors.white,
                          child: ListTile(
                            leading: Icon(Icons.info_outline, color: selectedColor.color),
                            title: Text(
                              key,
                              style: TextStyle(
                                fontStyle: selectedFont.style,
                                fontWeight: selectedFont.weight,
                                color: isDark || isImage ? Colors.white : Colors.black,
                              ),
                            ),
                            subtitle: Text(
                              value,
                              style: TextStyle(
                                fontStyle: selectedFont.style,
                                fontWeight: selectedFont.weight,
                                color: isDark || isImage ? Colors.white70 : Colors.black54,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}