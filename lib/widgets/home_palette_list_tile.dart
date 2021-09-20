import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:palette_generator/models/palette_info.dart';
import 'package:palette_generator/models.dart';
import 'package:palette_generator/screens/palette_detail_page.dart';
import 'package:provider/provider.dart';

class HomePaletteListTile extends StatelessWidget {
  final PaletteInfo paletteInfo;

  const HomePaletteListTile({Key? key, required this.paletteInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(FontAwesomeIcons.palette),
      title: Text(
        paletteInfo.paletteName,
        maxLines: 1,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 18,
              overflow: TextOverflow.ellipsis,
            ),
      ),
      trailing: IconButton(
        icon: paletteInfo.isFavorite
            ? FaIcon(
                FontAwesomeIcons.solidHeart,
                color: Colors.redAccent,
              )
            : FaIcon(FontAwesomeIcons.heart),
        onPressed: () {
          Provider.of<PaletteStateNotifier>(context, listen: false)
              .updatePalette(
            paletteInfo,
            isFavorite: !paletteInfo.isFavorite,
          );
        },
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
