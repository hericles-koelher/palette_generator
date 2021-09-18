import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:palette_generator/models/color_list_state_notifier.dart';
import 'package:palette_generator/models/slider_state_notifier.dart';
import 'package:palette_generator/widgets/save_alert_dialog.dart';
import 'package:palette_generator/widgets/palette_grid.dart';
import 'package:palette_generator/widgets/number_of_colors_slider.dart';
import 'package:provider/provider.dart';

class PaletteCreationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorListNotifier =
        Provider.of<ColorListStateNotifier>(context, listen: false);

    final sliderNotifier =
        Provider.of<SliderStateNotifier>(context, listen: false);

    // colorListNotifier.createColorList(numberOfColors: sliderNotifier.state);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.arrowLeft,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "PALETTE CREATOR",
        ),
        actions: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.solidSave,
            ),
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (context) => SaveAlertDialog(),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 35.0,
              ),
              child: StateNotifierBuilder<List<Color>>(
                stateNotifier: Provider.of<ColorListStateNotifier>(context),
                builder: (context, state, child) {
                  return PaletteGrid(colors: state);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NumberOfColorsSlider(),
                  ElevatedButton(
                    onPressed: () {
                      colorListNotifier.createColorList(
                        numberOfColors: sliderNotifier.state,
                      );
                    },
                    child: Text(
                      "GENERATE",
                      style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
