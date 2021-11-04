import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:palette_generator/src/constants.dart';
import 'package:palette_generator/src/models.dart';
import 'package:provider/provider.dart';
import '../widgets.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final SettingsStateNotifier _settingsStateNotifier =
        Provider.of<SettingsStateNotifier>(context, listen: false);

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
                      buildNumberPicker(
                        label: "Minimum",
                        value: state.minColors,
                        onChanged: (value) {
                          _settingsStateNotifier.setMinColors(value);
                        },
                        context: context,
                      ),
                      buildNumberPicker(
                        label: "Maximum",
                        value: state.maxColors,
                        onChanged: (value) {
                          _settingsStateNotifier.setMaxColors(value);
                        },
                        context: context,
                      ),
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

  Widget buildNumberPicker({
    required BuildContext context,
    required String label,
    required int value,
    required void Function(int) onChanged,
  }) {
    final themeData = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        NumberPicker(
          minValue: kMinColors,
          maxValue: kMaxColors,
          value: value,
          onChanged: onChanged,
          itemHeight: 35,
          selectedTextStyle: themeData.textTheme.headline5!.copyWith(
            color: themeData.colorScheme.primary,
          ),
        ),
        Text(label),
      ],
    );
  }
}
