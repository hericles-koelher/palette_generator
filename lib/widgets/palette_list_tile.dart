import 'package:flutter/material.dart';
import 'package:palette_generator/models/palette_info.dart';

class PaletteListTile extends StatelessWidget {
  final PaletteInfo paletteInfo;

  const PaletteListTile({Key? key, required this.paletteInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.palette),
      title: Text(paletteInfo.paletteName),
      trailing:
          Icon(paletteInfo.isFavorite ? Icons.favorite : Icons.favorite_border),
    );
  }
}
