import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:palette_generator/models/color_list_state_notifier.dart';
import 'package:palette_generator/models/slider_state_notifier.dart';
import 'package:palette_generator/widgets/custom_alert_dialog.dart';
import 'package:palette_generator/widgets/palette_grid.dart';
import 'package:palette_generator/widgets/custom_slider.dart';
import 'package:provider/provider.dart';

// Topo com Grid de cores.
// Parte de baixo com slider e botão de gerar.

// Mudar para um sliver a exibição...
// resolve varios problemas...

class PaletteCreationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
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
            onPressed: () {
              // TODO: Ao salvar pedir para definir o nome da paletta.
              showDialog<void>(
                context: context,
                builder: (context) => CustomAlertDialog(),
              );
            },
            icon: Icon(
              Icons.save,
            ),
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
                  CustomSlider(),
                  ElevatedButton(
                    onPressed: () {
                      final colorListNotifier =
                          Provider.of<ColorListStateNotifier>(context,
                              listen: false);

                      final sliderNotifier = Provider.of<SliderStateNotifier>(
                          context,
                          listen: false);

                      colorListNotifier.createColorList(
                          numberOfColors: sliderNotifier.state);
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
