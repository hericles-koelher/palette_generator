import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:palette_generator/src/constants.dart';
import 'package:palette_generator/src/models.dart';
import 'package:provider/provider.dart';
import '../widgets.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

extension ParsePaletteToString on SortByPalette {
  String toShortString() {
    return this
        .toString()
        .split('.')
        .last
        .split("_")
        .map((e) => e.capitalize())
        .join(" ");
  }
}

extension ParseFileTypeToString on FileType {
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

  @override
  void initState() {
    _settingsStateNotifier =
        Provider.of<SettingsStateNotifier>(context, listen: false);

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
        child: StateNotifierBuilder<Settings>(
          stateNotifier: _settingsStateNotifier,
          builder: (context, state, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Number of colors",
                  style: textTheme.bodyText1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildNumberPicker("Minimum", state.minColors, (value) {
                        _settingsStateNotifier.setMinColors(value);
                      }),
                      buildNumberPicker("Maximum", state.maxColors, (value) {
                        _settingsStateNotifier.setMaxColors(value);
                      }),
                    ],
                  ),
                ),
                const Divider(),
                Text(
                  "Sorting schema",
                  style: textTheme.bodyText1,
                ),
                DropdownButton<SortByPalette>(
                  value: state.sortByPalette,
                  isExpanded: true,
                  items: SortByPalette.values
                      .map(
                        (item) => DropdownMenuItem<SortByPalette>(
                          value: item,
                          child: Text(
                            item.toShortString(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    _settingsStateNotifier.sortBy(value!);
                  },
                ),
                Text(
                  "Export file format",
                  style: textTheme.bodyText1,
                ),
                DropdownButton<FileType>(
                  value: state.fileType,
                  isExpanded: true,
                  items: FileType.values
                      .map(
                        (item) => DropdownMenuItem<FileType>(
                          value: item,
                          child: Text(
                            item.toShortString(),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    _settingsStateNotifier.changeExportFileFormat(value!);
                  },
                ),
              ],
            );
          },
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
