import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:palette_generator/models/slider_state_notifier.dart';
import 'package:palette_generator/utils/constants.dart';
import 'package:provider/provider.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sliderNotifier = Provider.of<SliderStateNotifier>(context);

    return StateNotifierBuilder<int>(
      stateNotifier: sliderNotifier,
      builder: (context, state, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Number of colors:",
                    style: kPrimaryTextStyle.copyWith(fontSize: 20.0),
                  ),
                  Text(
                    state.toString(),
                    style: kPrimaryTextStyle.copyWith(fontSize: 20.0),
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
