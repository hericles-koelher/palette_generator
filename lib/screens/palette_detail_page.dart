import 'package:flutter/material.dart';
import 'package:palette_generator/models/palette_info.dart';
import 'package:palette_generator/models/palette_state_notifier.dart';
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
          "Details",
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
    );
  }
}
