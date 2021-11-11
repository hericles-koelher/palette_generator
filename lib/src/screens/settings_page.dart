import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:palette_generator/src/constants.dart';
import 'package:palette_generator/src/models.dart';
import 'package:provider/provider.dart';
import '../widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  static const String name = "settings";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final SettingsStateNotifier _settingsStateNotifier =
        Provider.of<SettingsStateNotifier>(context, listen: false);
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations!.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: kVerticalPadding,
          horizontal: kHorizontalPadding,
        ),
        child: StateNotifierBuilder<Settings>(
          stateNotifier: _settingsStateNotifier,
          builder: (context, state, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  localizations.numberOfColors,
                  style: textTheme.bodyText1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildNumberPicker(
                        label: localizations.minimum,
                        value: state.minColors,
                        onChanged: (value) {
                          _settingsStateNotifier.setMinColors(value);
                        },
                        context: context,
                      ),
                      buildNumberPicker(
                        label: localizations.maximum,
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
                  localizations.sortBy,
                  style: textTheme.bodyText1,
                ),
                DropdownButton<SortByPalette>(
                  value: state.sortByPalette,
                  isExpanded: true,
                  items: [
                    buildSortDropdown(
                      value: SortByPalette.name_ascending,
                      label: localizations.ascending,
                      icon: FaIcon(
                        FontAwesomeIcons.sortAlphaDown,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    buildSortDropdown(
                      value: SortByPalette.name_descending,
                      label: localizations.descending,
                      icon: FaIcon(
                        FontAwesomeIcons.sortAlphaUp,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    buildSortDropdown(
                      value: SortByPalette.creation_newest,
                      label: localizations.newest,
                      icon: FaIcon(
                        FontAwesomeIcons.sortNumericDown,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    buildSortDropdown(
                      value: SortByPalette.creation_oldest,
                      label: localizations.oldest,
                      icon: FaIcon(
                        FontAwesomeIcons.sortNumericUp,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    _settingsStateNotifier.sortBy(value!);
                  },
                ),
                Text(
                  localizations.exportFileFormat,
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

  DropdownMenuItem<SortByPalette> buildSortDropdown({
    required SortByPalette value,
    required String label,
    required Widget icon,
  }) {
    return DropdownMenuItem<SortByPalette>(
      value: value,
      child: Row(
        children: [
          icon,
          SizedBox(width: 15),
          Text(label),
        ],
      ),
    );
  }
}
