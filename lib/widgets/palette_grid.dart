import 'package:flutter/material.dart';

class PaletteGrid extends StatelessWidget {
  final List<Color> colors;

  const PaletteGrid({Key? key, required this.colors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      physics: PageScrollPhysics(),
      children: List.generate(
        colors.length,
        (index) => Container(
          decoration: BoxDecoration(
            color: colors[index],
          ),
        ),
      ),
    );
  }
}
