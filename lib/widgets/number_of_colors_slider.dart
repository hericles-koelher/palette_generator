import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:palette_generator/models.dart';
import 'package:palette_generator/utils/constants.dart';
import 'package:provider/provider.dart';

class NumberOfColorsSlider extends StatelessWidget {
  const NumberOfColorsSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sliderNotifier = Provider.of<SliderStateNotifier>(context);

    return StateNotifierBuilder<int>(
      stateNotifier: sliderNotifier,
      builder: (context, state, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Number of colors:",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    state.toString(),
                    style: Theme.of(context).textTheme.bodyText1!,
                  ),
                ],
              ),
            ),
            Slider(
              label: state.toString(),
              value: state.toDouble(),
              min: kMinColorsPalette.toDouble(),
              max: kMaxColorsPalette.toDouble(),
              // divisions: 32,
              onChanged: (value) {
                sliderNotifier.change(value.toInt());
              },
            ),
          ],
        );
      },
    );
  }
}
