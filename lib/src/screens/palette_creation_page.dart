import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../widgets.dart';

class PaletteCreationPage extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final paletteNotifier =
        Provider.of<PaletteStateNotifier>(context, listen: false);

    final colorListNotifier =
        Provider.of<ColorListStateNotifier>(context, listen: false);

    final sliderNotifier =
        Provider.of<SliderStateNotifier>(context, listen: false);

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
                builder: (context) => AlertDialogTextField(
                  title: "What is your palette name?",
                  textController: _textEditingController,
                  dismissOnComplete: false,
                  onCompleted: () {
                    List<int> colors = colorListNotifier.state;

                    paletteNotifier.savePalette(
                      paletteName: _textEditingController.text,
                      colors: colors,
                    );

                    Navigator.popUntil(context, (route) => route.isFirst);

                    // SnackBar snackBar = SnackBar(
                    //   content: Text(
                    //     "Palette \'${_textEditingController.text}\' was saved!",
                    //   ),
                    // );
                    //
                    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                ),
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
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: StateNotifierBuilder<List<int>>(
                stateNotifier: Provider.of<ColorListStateNotifier>(context),
                builder: (context, state, child) {
                  return PaletteGrid(
                    colors: state,
                    padding: EdgeInsets.only(top: 25),
                  );
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
