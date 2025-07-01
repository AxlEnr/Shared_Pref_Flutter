import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_pref/models/color_theme.dart';
import 'package:shared_pref/models/custom_font_style.dart';
import 'package:shared_pref/models/background.dart';
import 'package:shared_pref/utils/decorators.dart';
import 'package:shared_pref/utils/preferences_utils.dart';
import 'package:shared_pref/widgets/preferences_card.dart';
import 'package:shared_pref/pages/home.dart';

class ShowPrefs extends StatefulWidget {
  const ShowPrefs({super.key, required this.title});
  final String title;

  @override
  State<ShowPrefs> createState() => _ShowPrefsState();
}

class _ShowPrefsState extends State<ShowPrefs> {
  Map<String, String> prefsMap = {};
  ColorTheme selectedColor = ColorTheme.azul;
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
      selectedColor = getColorThemeFromString(prefs.getString('theme') ?? 'blue');
      selectedFont = getFontStyleFromString(prefs.getString('font') ?? 'normal');
      selectedBackground = getBackgroundFromString(prefs.getString('background') ?? 'light');

      prefsMap = {
        'Nombre': prefs.getString('name') ?? '',
        'Primer apellido': prefs.getString('fn') ?? '',
        'Segundo apellido': prefs.getString('sn') ?? '',
        'Fondo': prefs.getString('backgroundLabel') ?? '',
        'Tema': prefs.getString('themeLabel') ?? '',
        'Fuente': prefs.getString('fontLabel') ?? '',
        'Género': prefs.getString('genderLabel') ?? '',
      };
    });
  }

  Future<void> _deleteShared() async {
    final prefs = await SharedPreferences.getInstance();
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

  Widget _buildActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontStyle: selectedFont.style,
          fontWeight: selectedFont.weight,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = selectedBackground == Background.dark;
    final bool isImage = selectedBackground == Background.image;
    final textColor = isDark || isImage ? Colors.white : Colors.black;

    return Container(
      decoration: getBackgroundDecoration(selectedBackground),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage(title: 'Guadar Informacion')),
                  );
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              Text(
                widget.title,
                style: TextStyle(
                  fontStyle: selectedFont.style,
                  fontWeight: selectedFont.weight,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          elevation: 4,
          backgroundColor: selectedColor.color,
        ),
        body: Column(
          children: [
            // Botones de acción
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    onPressed: _loadPreferences,
                    icon: Icons.refresh,
                    label: 'Recargar',
                    color: selectedColor.color,
                  ),
                  _buildActionButton(
                    onPressed: _deleteShared,
                    icon: Icons.delete_forever,
                    label: 'Eliminar',
                    color: Colors.redAccent,
                  ),
                ],
              ),
            ),
            const Divider(),

            // Lista de preferencias
            Expanded(
              child: prefsMap.isEmpty
                  ? Center(
                      child: Text(
                        'No hay preferencias guardadas.',
                        style: TextStyle(
                          fontStyle: selectedFont.style,
                          fontWeight: selectedFont.weight,
                          color: textColor,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: prefsMap.length,
                      itemBuilder: (context, index) {
                        final key = prefsMap.keys.elementAt(index);
                        final value = prefsMap[key]!;
                        return PreferenceCard(
                          title: key,
                          value: value,
                          colorTheme: selectedColor,
                          fontStyle: selectedFont,
                          isDark: isDark || isImage,
                        );
                      },
                    ),
            ),

            Text('Axel Enrique Garcia Vazquez', style: TextStyle(
                  fontSize: 20,
                  color: selectedColor.color,
                ),)
          ],
        ),
      ),
    );
  }
}