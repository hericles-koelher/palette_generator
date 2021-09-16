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
      leading: Icon(
        Icons.palette,
        size: 25,
      ),
      title: Text(
        paletteInfo.paletteName,
        maxLines: 1,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
            ),
      ),
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
