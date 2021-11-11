import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NumberOfColorsSlider extends StatelessWidget {
  const NumberOfColorsSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sliderNotifier = Provider.of<SliderStateNotifier>(context);
    final settingsNotifier = Provider.of<SettingsStateNotifier>(
      context,
      listen: false,
    );
    final localizations = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: StateNotifierBuilder<int>(
        stateNotifier: sliderNotifier,
        builder: (context, state, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      localizations!.numberOfColors,
                    ),
                    Text(
                      state.toString(),
                    ),
                  ],
                ),
              ),
              Slider(
                label: state.toString(),
                value: state.toDouble(),
                min: settingsNotifier.state.minColors.toDouble(),
                max: settingsNotifier.state.maxColors.toDouble(),
                onChanged: (value) {
                  sliderNotifier.change(value.toInt());
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
