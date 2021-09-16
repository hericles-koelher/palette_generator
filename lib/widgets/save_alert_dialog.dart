import 'package:flutter/material.dart';
import 'package:palette_generator/models/color_list_state_notifier.dart';
import 'package:palette_generator/models/palette_state_notifier.dart';
import 'package:provider/provider.dart';

class SaveAlertDialog extends StatefulWidget {
  const SaveAlertDialog({Key? key}) : super(key: key);

  @override
  _SaveAlertDialogState createState() => _SaveAlertDialogState();
}

class _SaveAlertDialogState extends State<SaveAlertDialog> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "What is your palette name?",
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 20,
            ),
      ),
      content: TextField(
        controller: _textEditingController,
        maxLines: 1,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              fontSize: 18,
            ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
          ),
        ),
        TextButton(
          onPressed: _textEditingController.text.isEmpty
              ? null
              : () {
                  List<Color> colors = Provider.of<ColorListStateNotifier>(
                          context,
                          listen: false)
                      .state;

                  var paletteNotifier =
                      Provider.of<PaletteStateNotifier>(context, listen: false);

                  paletteNotifier.savePalette(
                    paletteName: _textEditingController.text,
                    colors: colors,
                  );

                  Navigator.popUntil(context, (route) => route.isFirst);

                  final snackBar = SnackBar(
                    content: Text(
                      "Palette \"${_textEditingController.text}\" was saved!",
                      maxLines: 1,
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
          child: Text("Done"),
        ),
      ],
    );
  }
}
