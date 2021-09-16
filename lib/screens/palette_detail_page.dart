import 'package:flutter/material.dart';
import 'package:palette_generator/models/palette_info.dart';
import 'package:palette_generator/models/palette_state_notifier.dart';
import 'package:palette_generator/widgets/palette_info_list_view.dart';
import 'package:provider/provider.dart';

class PaletteDetailPage extends StatelessWidget {
  final PaletteInfo paletteInfo;

  const PaletteDetailPage(this.paletteInfo);

  @override
  Widget build(BuildContext context) {
    final PaletteStateNotifier paletteNotifier =
        Provider.of<PaletteStateNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          paletteInfo.paletteName,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete_outlined,
            ),
            onPressed: () {
              paletteNotifier.deletePalette(paletteInfo.id);

              Navigator.pop(context);

              SnackBar snackBar = SnackBar(
                content: Text(
                  "Palette \'${paletteInfo.paletteName}\' was deleted!",
                ),
                action: SnackBarAction(
                  label: "UNDO",
                  onPressed: () {
                    paletteNotifier.undo();
                  },
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          IconButton(
            icon: Icon(
              Icons.share,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 25,
          right: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "Number of colors: ${paletteInfo.colors.length}",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 18,
                    ),
              ),
            ),
            Expanded(
              flex: 8,
              child: PaletteInfoListView(colors: paletteInfo.colors),
            ),
          ],
        ),
      ),
    );
  }
}
