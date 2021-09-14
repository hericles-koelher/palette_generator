import 'package:flutter/material.dart';
import 'package:palette_generator/models/palette_info.dart';
import 'package:palette_generator/screens/palette_detail_page.dart';

class PaletteListTile extends StatelessWidget {
  final PaletteInfo paletteInfo;

  const PaletteListTile({Key? key, required this.paletteInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.palette),
      title: Text(paletteInfo.paletteName),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaletteDetailPage(paletteInfo),
          ),
        );
      },
    );
  }
}
