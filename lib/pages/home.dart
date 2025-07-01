import 'package:flutter/material.dart';
import 'package:shared_pref/utils/colors.dart';
import 'package:shared_pref/utils/custom_font_style.dart';
import 'package:shared_pref/utils/menu_entry.dart';
import 'package:shared_pref/pages/show_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Color Theme Enum
enum ColorTheme {
  blue,
  green,
  purple,
  orange,
}

// Font Style Enum
enum CustomFontStyle {
  normal,
  bold,
  italic,
  boldItalic,
}

// Background Enum
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  MenuEntry? selectedEntry;
  ColorTheme selectedColor = ColorTheme.blue;
  CustomFontStyle selectedFont = CustomFontStyle.normal;
  Background selectedBackground = Background.light;
  TextEditingController userName = TextEditingController();
  TextEditingController userFN =  TextEditingController();
  TextEditingController userSn =  TextEditingController();  

  void _activateGender(MenuEntry entry) {
    setState(() {
      selectedEntry = entry;
    });
  }

  void _activateColor(ColorTheme theme) {
    setState(() {
      selectedColor = theme;
    });
  }

  void _activateFont(CustomFontStyle font) {
    setState(() {
      selectedFont = font;
    });
  }

  void _activateBackground(Background background) {
    setState(() {
      selectedBackground = background;
    });
  }

  void _saveInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = userName.text;
    String lastName = userFN.text;
    String secondName = userSn.text;
    await prefs.setString('name', name);
    await prefs.setString('fn', lastName);
    await prefs.setString('sn', secondName);
    await prefs.setString('background', selectedBackground.name);
    await prefs.setString('theme', selectedColor.name);
    await prefs.setString('font', selectedFont.name);
    await prefs.setString('gender', selectedEntry?.name ?? '');
    
    if (prefs.getString('name')?.isNotEmpty == true && 
    prefs.getString('fn')?.isNotEmpty == true && 
    prefs.getString('sn')?.isNotEmpty == true &&
    prefs.getString('background')?.isNotEmpty == true &&
    prefs.getString('theme')?.isNotEmpty == true &&
    prefs.getString('font')?.isNotEmpty == true &&
    prefs.getString('gender')?.isNotEmpty == true){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ShowPrefs(title: 'Mostrar Preferencias',)),
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


  BoxDecoration _getBackgroundDecoration() {
    switch (selectedBackground) {
      case Background.light:
        return BoxDecoration(color: Colors.grey[100]);
      case Background.dark:
        return BoxDecoration(color: Colors.grey[800]);
      case Background.image:
        return BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ken.jpg'),
            fit: BoxFit.cover,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontStyle: selectedFont.style,
            fontWeight: selectedFont.weight,
            color: Colors.white
          ),
        ),
        elevation: 4,
        backgroundColor: selectedColor.color,
      ),
      body: Container(
        decoration: _getBackgroundDecoration(),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 280,
                  child: TextField(
                    style: TextStyle(
                      fontStyle: selectedFont.style,
                      fontWeight: selectedFont.weight,
                      color: selectedColor.color
                      ),
                    controller: userName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nombre(s)',
                      labelStyle: TextStyle(color: selectedColor.color),
                      
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: selectedColor.color),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 280,
                  child: TextField(
                    controller: userFN,
                    style: TextStyle(
                      fontStyle: selectedFont.style,
                      fontWeight: selectedFont.weight,
                      color: selectedColor.color
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Apellido Paterno',
                      labelStyle: TextStyle(color: selectedColor.color),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: selectedColor.color),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 280,
                  child: TextField(
                    style: TextStyle(
                      fontStyle: selectedFont.style,
                      fontWeight: selectedFont.weight,
                      color: selectedColor.color
                    ),
                    controller: userSn,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Apellido Materno',
                      labelStyle: TextStyle(color: selectedColor.color),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: selectedColor.color),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // MENÚ DE GÉNERO
                _buildMenuAnchor(
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
                ),
                const SizedBox(height: 15),

                // MENÚ DE COLORES
                _buildMenuAnchor(
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
                          color: (entry).color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(entry.label),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // MENÚ DE FUENTES
                _buildMenuAnchor(
                  label: 'Fuente: ${selectedFont.label}',
                  items: CustomFontStyle.values,
                  icon: Icons.font_download,
                  onSelected: _activateFont,
                  itemBuilder: (entry) => Row(
                    children: [
                      Icon(Icons.text_fields, color: selectedColor.color),
                      const SizedBox(width: 10),
                      Text(
                        (entry).label,
                        style: TextStyle(
                          fontStyle: entry.style,
                          fontWeight: entry.weight,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // MENÚ DE FONDO
                _buildMenuAnchor(
                  label: 'Fondo: ${selectedBackground.label}',
                  items: Background.values,
                  icon: Icons.color_lens,
                  onSelected: _activateBackground,
                  itemBuilder: (entry) => Row(
                    children: [
                      Icon((entry).icon, color: selectedColor.color),
                      const SizedBox(width: 10),
                      Text(entry.label),
                    ],
                  ),

                ),

                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: _saveInfo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedColor.color,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    shadowColor: selectedColor.color,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.save, size: 24),
                      SizedBox(width: 20),
                      Text(
                        'Guardar Preferencias',
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: selectedFont.style,
                          fontWeight: selectedFont.weight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuAnchor<T>({
    required String label,
    required List<T> items,
    required IconData icon,
    required Function(T) onSelected,
    required Widget Function(T) itemBuilder,
  }) {
    return MenuAnchor(
      builder: (BuildContext context, MenuController controller, Widget? child) {
        return ElevatedButton.icon(
          icon: Icon(icon),
          onPressed: () {
            controller.open();
          },
          label: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontStyle: selectedFont.style,
              fontWeight: selectedFont.weight,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: selectedColor.color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            minimumSize: Size(290, 30),
            elevation: 4,
          ),
        );
      },
      menuChildren: items.map((entry) {
        return MenuItemButton(
          onPressed: () => onSelected(entry),
          child: itemBuilder(entry),
        );
      }).toList(),
    );
  }
  
}