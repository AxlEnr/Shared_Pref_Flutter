import 'package:flutter/material.dart';
import 'package:shared_pref/pages/home.dart';
import 'package:shared_pref/pages/show_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  Future<bool> _checkPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name')?.isNotEmpty == true &&
        prefs.getString('fn')?.isNotEmpty == true &&
        prefs.getString('sn')?.isNotEmpty == true &&
        prefs.getString('background')?.isNotEmpty == true &&
        prefs.getString('theme')?.isNotEmpty == true &&
        prefs.getString('font')?.isNotEmpty == true &&
        prefs.getString('gender')?.isNotEmpty == true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkPreferences(),
      builder: (context, snapshot) {
        return MaterialApp(
          title: 'SharedPreferences',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey.shade900),
          ),
          home: snapshot.connectionState == ConnectionState.waiting
              ? const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                )
              : (snapshot.data == true
                  ? const ShowPrefs(title: 'Preferencias Guardadas')
                  : const MyHomePage(title: 'Guadar Informacion')),
        );
      },
    );
  }
}
