import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:palette_generator/src/constants.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PaletteCreationPage extends StatefulWidget {
  static const String name = "creation";

  @override
  State<PaletteCreationPage> createState() => _PaletteCreationPageState();
}

class _PaletteCreationPageState extends State<PaletteCreationPage> {
  final TextEditingController _nameController;
  final TextEditingController _descriptionController;
  final GlobalKey<FormState> _formKey;
  late final PaletteStateNotifier paletteNotifier;
  late final ColorListStateNotifier colorListNotifier;
  late final SliderStateNotifier sliderNotifier;

  _PaletteCreationPageState()
      : _formKey = GlobalKey<FormState>(),
        _nameController = TextEditingController(),
        _descriptionController = TextEditingController();

  @override
  void initState() {
    paletteNotifier = Provider.of<PaletteStateNotifier>(context, listen: false);

    colorListNotifier =
        Provider.of<ColorListStateNotifier>(context, listen: false);

    sliderNotifier = Provider.of<SliderStateNotifier>(context, listen: false);

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

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
          localizations!.createYourPalette,
        ),
        actions: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.solidSave,
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                List<int> colors = colorListNotifier.state;

                paletteNotifier.savePalette(
                  name: _nameController.text.trim(),
                  description: _descriptionController.text.trim(),
                  colors: colors,
                );

                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          vertical: kVerticalPadding,
          horizontal: kHorizontalPadding,
        ),
        physics: BouncingScrollPhysics(),
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: localizations.name,
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? text) {
                      if (text == null || text.isEmpty) {
                        return localizations.paletteCreationErrorMessage;
                      } else {
                        return null;
                      }
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(kNameMaxLength)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    controller: _descriptionController,
                    minLines: 1,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: "${localizations.description}*",
                      helperText: "*${localizations.optional}",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          NumberOfColorsSlider(),
          StateNotifierBuilder<List<int>>(
            stateNotifier: Provider.of<ColorListStateNotifier>(context),
            builder: (context, state, child) => PaletteGrid(colors: state),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        label: Text(localizations.refresh),
        icon: FaIcon(FontAwesomeIcons.syncAlt),
        onPressed: () {
          colorListNotifier.createColorList(
            numberOfColors: sliderNotifier.state,
          );
        },
      ),
    );
  }
}
