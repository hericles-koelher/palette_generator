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
      physics: BouncingScrollPhysics(),
      children: List.generate(
        colors.length,
        (index) => Container(
          margin: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[900]!,
              width: 2.5,
            ),
            color: colors[index],
            borderRadius: BorderRadius.circular(
              25.0,
            ),
          ),
        ),
      ),
    );
  }
}
