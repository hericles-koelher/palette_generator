import 'package:flutter/material.dart';
import 'package:palette_generator/models/color_list_state_notifier.dart';
import 'package:palette_generator/models/palette_state_notifier.dart';
import 'package:palette_generator/utils/constants.dart';
import 'package:provider/provider.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({Key? key}) : super(key: key);

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
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
      ),
      content: TextField(
        controller: _textEditingController,
        maxLines: 1,
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel"),
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
                        "Palette \"${_textEditingController.text}\" was saved!"),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
          child: Text("Done"),
        ),
      ],
    );
  }
}
