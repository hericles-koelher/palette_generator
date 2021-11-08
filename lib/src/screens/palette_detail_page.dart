import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:palette_generator/src/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models.dart';
import '../widgets.dart';

enum _DetailsPageActions {
  edit,
  share,
  delete,
}

class PaletteDetailPage extends StatefulWidget {
  final PaletteInfo paletteInfo;

  PaletteDetailPage(this.paletteInfo);

  @override
  State<PaletteDetailPage> createState() =>
      _PaletteDetailPageState(paletteInfo);
}

class _PaletteDetailPageState extends State<PaletteDetailPage> {
  late final PaletteStateNotifier _paletteStateNotifier;
  final GlobalKey<FormState> _editionFormKey;
  bool _editionEnabled = false;
  PaletteInfo _currentPaletteInfo;

  _PaletteDetailPageState(this._currentPaletteInfo)
      : _editionFormKey = GlobalKey<FormState>(),
        super();

  @override
  void initState() {
    _currentPaletteInfo = widget.paletteInfo;
    _paletteStateNotifier =
        Provider.of<PaletteStateNotifier>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Info",
        ),
        actions: [
          PopupMenuButton<_DetailsPageActions>(
            icon: FaIcon(FontAwesomeIcons.ellipsisV),
            onSelected: (action) {
              switch (action) {
                case _DetailsPageActions.delete:
                  _deleteAction(context);
                  break;
                case _DetailsPageActions.share:
                  _shareAction(context);
                  break;
                case _DetailsPageActions.edit:
                  _editAction(context);
                  break;
              }
            },
            itemBuilder: (_) => [
              buildPopupMenuItem(
                label: "Edit",
                value: _DetailsPageActions.edit,
                iconData: FontAwesomeIcons.edit,
              ),
              buildPopupMenuItem(
                label: "Share",
                value: _DetailsPageActions.share,
                iconData: FontAwesomeIcons.shareAlt,
              ),
              buildPopupMenuItem(
                label: "Delete",
                value: _DetailsPageActions.delete,
                iconData: FontAwesomeIcons.trashAlt,
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: kVerticalPadding,
          horizontal: kHorizontalPadding,
        ),
        children: [
          Text(
            "Palette Name:",
            style: textTheme.bodyText1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Text(
              _currentPaletteInfo.name,
            ),
          ),
          Text(
            "Description:",
            style: textTheme.bodyText1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Text(
              _currentPaletteInfo.description ?? "Palette by Palette Generator",
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          PaletteGrid(colors: _currentPaletteInfo.colors),
        ],
      ),
    );
  }

  PopupMenuEntry<_DetailsPageActions> buildPopupMenuItem({
    required String label,
    required _DetailsPageActions value,
    required IconData iconData,
  }) {
    return PopupMenuItem(
      value: value,
      child: ListTile(
        trailing: FaIcon(iconData),
        title: Text(label),
      ),
    );
  }

  void _editAction(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController =
        TextEditingController(text: _currentPaletteInfo.name);
    final descriptionController =
        TextEditingController(text: _currentPaletteInfo.description);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: kVerticalPadding,
              horizontal: kHorizontalPadding,
            ),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Palette Name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? text) {
                        if (text == null || text.isEmpty) {
                          return "Please give your palette a name.";
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
                      controller: descriptionController,
                      minLines: 1,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: "Palette Description*",
                        helperText: "*Optional",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Cancel",
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Talvez quando eu trocar pro Navigator 2 eu resolva essa gambiarra...
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                _currentPaletteInfo =
                                    _paletteStateNotifier.updatePalette(
                                  _currentPaletteInfo,
                                  name: nameController.text,
                                  description: descriptionController.text,
                                );
                              });
                              Navigator.pop(context);
                            }
                          },
                          child: Text("Apply"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // TODO: ajustar para exportar para o formato selecionado nas configurações.
  void _shareAction(BuildContext context) async {
    final documents = await getApplicationDocumentsDirectory();

    final paletteFile =
        File(documents.path + "/${_currentPaletteInfo.name}.gpl");

    await paletteFile.writeAsString(_currentPaletteInfo.toGpl());

    debugPrint(paletteFile.existsSync().toString());

    await Share.shareFiles([paletteFile.path], mimeTypes: ["application/gpl"]);
  }

  void _deleteAction(BuildContext context) {
    _paletteStateNotifier.deletePalette(_currentPaletteInfo.id);

    Navigator.pop(context);

    final SnackBar snackBar = SnackBar(
      content: Text(
        "Palette \'${_currentPaletteInfo.name}\' was deleted!",
      ),
      action: SnackBarAction(
        label: "UNDO",
        onPressed: () {
          _paletteStateNotifier.undo();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
