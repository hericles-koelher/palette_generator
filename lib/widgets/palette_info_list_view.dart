import 'package:flutter/material.dart';
import 'package:palette_generator/widgets/palette_info_list_tile.dart';

class PaletteInfoListView extends StatelessWidget {
  final List<Color> colors;

  PaletteInfoListView({required this.colors});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: List.generate(
        (colors.length * 2) - 1,
        (index) {
          if (index.isEven)
            return PaletteInfoListTile(color: colors[index ~/ 2]);
          else
            return Divider();
        },
      ),
    );
  }
}
