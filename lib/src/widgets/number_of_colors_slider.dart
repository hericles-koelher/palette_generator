import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import '../models.dart';

class NumberOfColorsSlider extends StatelessWidget {
  const NumberOfColorsSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sliderNotifier = Provider.of<SliderStateNotifier>(context);
    final configNotifier = Provider.of<SettingsStateNotifier>(
      context,
      listen: false,
    );

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
              min: configNotifier.state.minColors.toDouble(),
              max: configNotifier.state.maxColors.toDouble(),
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
