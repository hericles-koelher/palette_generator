import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:palette_generator/src/constants.dart';
import 'package:palette_generator/src/models.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';
import '../widgets.dart';

extension ParsePaletteToString on SortByPalette {
  String toShortString() {
    return this
        .toString()
        .split('.')
        .last
        .split("_")
        .map((e) => e.toUpperCase())
        .join(" ");
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final SettingsStateNotifier _settingsStateNotifier;
  late int minColors;
  late int maxColors;
  late SortByPalette sortingSchema;
  late FileType exportFileType;

  @override
  void initState() {
    _settingsStateNotifier =
        Provider.of<SettingsStateNotifier>(context, listen: false);
    minColors = _settingsStateNotifier.state.minColors;
    maxColors = _settingsStateNotifier.state.maxColors;
    sortingSchema = _settingsStateNotifier.state.sortByPalette;
    exportFileType = _settingsStateNotifier.state.fileType;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Number of colors",
              style: textTheme.headline6,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildNumberPicker("Minimum", minColors, (value) {
                    setState(() {
                      minColors = value;
                    });
                  }),
                  buildNumberPicker("Maximum", maxColors, (value) {
                    setState(() {
                      maxColors = value;
                    });
                  }),
                ],
              ),
            ),
            const Divider(),
            Text(
              "Sorting schema",
              style: textTheme.headline6,
            ),
            SelectFormField(
              items: SortByPalette.values
                  .map((e) => {
                        "value": e,
                        "label": e.toShortString(),
                      }.cast<String, dynamic>())
                  .toList(),
            ),
            const Divider(),
            Text(
              "Export file format",
              style: textTheme.headline6,
            ),
            // TODO: add save button.
          ],
        ),
      ),
      drawer: ApplicationDrawer(),
    );
  }

  Widget buildNumberPicker(
      String label, int value, void Function(int) onChanged) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        NumberPicker(
          minValue: kMinColors,
          maxValue: kMaxColors,
          value: value,
          onChanged: onChanged,
          itemHeight: 35,
        ),
        Text(label),
      ],
    );
  }
}
