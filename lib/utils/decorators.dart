import 'package:flutter/material.dart';
import '../models/background.dart';

BoxDecoration getBackgroundDecoration(Background background) {
  switch (background) {
    case Background.light:
      return BoxDecoration(color: Colors.grey[100]);
    case Background.dark:
      return BoxDecoration(color: Colors.grey[800]);
    case Background.image:
      return const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/ken.jpg'),
          fit: BoxFit.cover,
        ),
      );
  }
}