import 'package:flutter/material.dart';

class CustomMenuAnchor<T> extends StatelessWidget {
  final String label;
  final List<T> items;
  final IconData icon;
  final Function(T) onSelected;
  final Widget Function(T) itemBuilder;
  final Color color;
  final FontStyle fontStyle;
  final FontWeight fontWeight;

  const CustomMenuAnchor({
    super.key,
    required this.label,
    required this.items,
    required this.icon,
    required this.onSelected,
    required this.itemBuilder,
    required this.color,
    required this.fontStyle,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (BuildContext context, MenuController controller, Widget? child) {
        return ElevatedButton.icon(
          icon: Icon(icon),
          onPressed: () => controller.open(),
          label: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontStyle: fontStyle,
              fontWeight: fontWeight,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            minimumSize: const Size(290, 30),
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