import 'package:flutter/material.dart';

class PaletteInfoListTile extends StatelessWidget {
  final Color color;

  PaletteInfoListTile({required this.color});

  String _colorToHex() {
    return "#${color.value.toRadixString(16).toUpperCase()}";
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(5.0),
      title: Text(
        _colorToHex(),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: Material(
        elevation: 4.0,
        shape: CircleBorder(),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
