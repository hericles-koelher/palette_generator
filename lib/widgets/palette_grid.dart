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
      children: List.generate(colors.length, (index) {
        Color currentColor = colors[index];

        return Tooltip(
          message:
              "RGB (${currentColor.red}, ${currentColor.green}, ${currentColor.blue})",
          triggerMode: TooltipTriggerMode.tap,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Material(
              shape: CircleBorder(),
              elevation: 5.0,
              child: Container(
                margin: const EdgeInsets.all(5.0),
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: currentColor,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
