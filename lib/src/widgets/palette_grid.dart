import 'package:flutter/material.dart';

class PaletteGrid extends StatelessWidget {
  final List<int> colors;
  final EdgeInsetsGeometry? padding;

  const PaletteGrid({
    Key? key,
    required this.colors,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      physics: BouncingScrollPhysics(),
      children: List.generate(colors.length, (index) {
        Color currentColor = Color(colors[index]);

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
