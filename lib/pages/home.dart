import 'package:flutter/material.dart';
import 'package:shared_pref/models/color_theme.dart';
import 'package:shared_pref/utils/preferences_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_pref/models/custom_font_style.dart';
import 'package:shared_pref/models/background.dart';
import 'package:shared_pref/models/menu_entry.dart';
import 'package:shared_pref/widgets/custom_menu_anchor.dart';
import 'package:shared_pref/widgets/text_input_field.dart';
import 'package:shared_pref/widgets/save_button.dart';
import 'package:shared_pref/utils/decorators.dart';
import 'show_prefs.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MenuEntry? selectedEntry;
  ColorTheme selectedColor = ColorTheme.azul;
  CustomFontStyle selectedFont = CustomFontStyle.normal;
  Background selectedBackground = Background.light;
  final TextEditingController userName = TextEditingController();
  final TextEditingController userFN = TextEditingController();
  final TextEditingController userSn = TextEditingController();  
  
  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    selectedColor = getColorThemeFromString(prefs.getString('theme') ?? 'azul');
    selectedFont = getFontStyleFromString(prefs.getString('font') ?? 'normal');
    selectedBackground = getBackgroundFromString(prefs.getString('background') ?? 'light');
  });
}


  void _activateGender(MenuEntry entry) {
    setState(() => selectedEntry = entry);
  }

  void _activateColor(ColorTheme theme) {
    setState(() => selectedColor = theme);
  }

  void _activateFont(CustomFontStyle font) {
    setState(() => selectedFont = font);
  }

  void _activateBackground(Background background) {
    setState(() => selectedBackground = background);
  }

  Future<void> _saveInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', userName.text);
    await prefs.setString('fn', userFN.text);
    await prefs.setString('sn', userSn.text);
    await prefs.setString('background', selectedBackground.name);
    await prefs.setString('theme', selectedColor.name);
    await prefs.setString('font', selectedFont.name);
    await prefs.setString('gender', selectedEntry?.name ?? '');

    await prefs.setString('backgroundLabel', selectedBackground.label);
    await prefs.setString('themeLabel', selectedColor.label);
    await prefs.setString('fontLabel', selectedFont.label);
    await prefs.setString('genderLabel', selectedEntry?.label ?? '');
    
    if (prefs.getString('name')?.isNotEmpty == true && 
        prefs.getString('fn')?.isNotEmpty == true && 
        prefs.getString('sn')?.isNotEmpty == true &&
        prefs.getString('background')?.isNotEmpty == true &&
        prefs.getString('theme')?.isNotEmpty == true &&
        prefs.getString('font')?.isNotEmpty == true &&
        prefs.getString('gender')?.isNotEmpty == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ShowPrefs(title: 'Mostrar Preferencias')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Te falta seleccionar una o varias opciones'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.home),
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
      body: Container(
        decoration: getBackgroundDecoration(selectedBackground),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextInputField(
                  controller: userName,
                  labelText: 'Nombre(s)',
                  color: selectedColor.color,
                  fontStyle: selectedFont.style,
                  fontWeight: selectedFont.weight,
                ),
                const SizedBox(height: 10),
                TextInputField(
                  controller: userFN,
                  labelText: 'Apellido Paterno',
                  color: selectedColor.color,
                  fontStyle: selectedFont.style,
                  fontWeight: selectedFont.weight,
                ),
                const SizedBox(height: 10),
                TextInputField(
                  controller: userSn,
                  labelText: 'Apellido Materno',
                  color: selectedColor.color,
                  fontStyle: selectedFont.style,
                  fontWeight: selectedFont.weight,
                ),
                const SizedBox(height: 20),
                
                // Menú de Género
                CustomMenuAnchor<MenuEntry>(
                  label: selectedEntry?.label ?? 'Selecciona tu género',
                  items: MenuEntry.values,
                  icon: Icons.arrow_drop_down,
                  onSelected: _activateGender,
                  itemBuilder: (entry) => Row(
                    children: [
                      Icon(entry.icon, color: selectedColor.color),
                      const SizedBox(width: 10),
                      Text(entry.label),
                    ],
                  ),
                  color: selectedColor.color,
                  fontStyle: selectedFont.style,
                  fontWeight: selectedFont.weight,
                ),
                const SizedBox(height: 15),

                // Menú de Colores
                CustomMenuAnchor<ColorTheme>(
                  label: 'Tema: ${selectedColor.label}',
                  items: ColorTheme.values,
                  icon: Icons.color_lens,
                  onSelected: _activateColor,
                  itemBuilder: (entry) => Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: entry.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(entry.label),
                    ],
                  ),
                  color: selectedColor.color,
                  fontStyle: selectedFont.style,
                  fontWeight: selectedFont.weight,
                ),
                const SizedBox(height: 15),

                // Menú de Fuentes
                CustomMenuAnchor<CustomFontStyle>(
                  label: 'Fuente: ${selectedFont.label}',
                  items: CustomFontStyle.values,
                  icon: Icons.font_download,
                  onSelected: _activateFont,
                  itemBuilder: (entry) => Row(
                    children: [
                      Icon(Icons.text_fields, color: selectedColor.color),
                      const SizedBox(width: 10),
                      Text(
                        entry.label,
                        style: TextStyle(
                          fontStyle: entry.style,
                          fontWeight: entry.weight,
                        ),
                      ),
                    ],
                  ),
                  color: selectedColor.color,
                  fontStyle: selectedFont.style,
                  fontWeight: selectedFont.weight,
                ),
                const SizedBox(height: 15),

                // Menú de Fondo
                CustomMenuAnchor<Background>(
                  label: 'Fondo: ${selectedBackground.label}',
                  items: Background.values,
                  icon: Icons.color_lens,
                  onSelected: _activateBackground,
                  itemBuilder: (entry) => Row(
                    children: [
                      Icon(entry.icon, color: selectedColor.color),
                      const SizedBox(width: 10),
                      Text(entry.label),
                    ],
                  ),
                  color: selectedColor.color,
                  fontStyle: selectedFont.style,
                  fontWeight: selectedFont.weight,
                ),
                const SizedBox(height: 20),
                
                SaveButton(
                  onPressed: _saveInfo,
                  color: selectedColor.color,
                  fontStyle: selectedFont.style,
                  fontWeight: selectedFont.weight,
                ),

                Text('Axel Enrique Garcia Vazquez', style: TextStyle(
                  fontSize: 20,
                  color: selectedColor.color,
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}