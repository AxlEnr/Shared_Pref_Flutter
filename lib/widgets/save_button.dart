import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final FontStyle fontStyle;
  final FontWeight fontWeight;

  const SaveButton({
    super.key,
    required this.onPressed,
    required this.color,
    required this.fontStyle,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 4,
        shadowColor: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.save, size: 24),
          const SizedBox(width: 20),
          Text(
            'Guardar Preferencias',
            style: TextStyle(
              fontSize: 16,
              fontStyle: fontStyle,
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    );
  }
}