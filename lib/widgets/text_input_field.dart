import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Color color;
  final FontStyle fontStyle;
  final FontWeight fontWeight;

  const TextInputField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.color,
    required this.fontStyle,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: TextField(
        style: TextStyle(
          fontStyle: fontStyle,
          fontWeight: fontWeight,
          color: color,
        ),
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          labelStyle: TextStyle(color: color),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: color),
          ),
        ),
      ),
    );
  }
}