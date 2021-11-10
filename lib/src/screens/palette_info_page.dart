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

class PaletteInfoPage extends StatefulWidget {
  static const String name = "info";
  final PaletteInfo paletteInfo;

  PaletteInfoPage(this.paletteInfo);

  @override
  State<PaletteInfoPage> createState() => _PaletteInfoPageState(paletteInfo);
}

class _PaletteInfoPageState extends State<PaletteInfoPage> {
  late final PaletteStateNotifier _paletteStateNotifier;
  final _editionFormKey;
  final _nameController;
  final _descriptionController;
  PaletteInfo _currentPaletteInfo;

  _PaletteInfoPageState(this._currentPaletteInfo)
      : _editionFormKey = GlobalKey<FormState>(),
        _nameController = TextEditingController(),
        _descriptionController = TextEditingController(),
        super();

  @override
  void initState() {
    _currentPaletteInfo = widget.paletteInfo;
    _paletteStateNotifier =
        Provider.of<PaletteStateNotifier>(context, listen: false);

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
    _nameController.text = _currentPaletteInfo.name;
    _descriptionController.text = _currentPaletteInfo.description;

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
              key: _editionFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: _nameController,
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
                      controller: _descriptionController,
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
                            if (_editionFormKey.currentState!.validate()) {
                              setState(() {
                                _currentPaletteInfo =
                                    _paletteStateNotifier.updatePalette(
                                  _currentPaletteInfo,
                                  name: _nameController.text,
                                  description: _descriptionController.text,
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

  void _shareAction(BuildContext context) async {
    final documents = await getApplicationDocumentsDirectory();
    final settings = Provider.of<SettingsStateNotifier>(context, listen: false);

    File paletteFile;
    List<String> mimeTypes = [];

    switch (settings.state.fileType) {
      case FileType.gpl:
        mimeTypes = ["application/gpl"];
        paletteFile = File(documents.path + "/${_currentPaletteInfo.name}.gpl");
        await paletteFile.writeAsString(_currentPaletteInfo.toGpl());
        break;
      case FileType.jasc_pal:
        mimeTypes = ["application/pal"];
        paletteFile = File(documents.path + "/${_currentPaletteInfo.name}.pal");
        await paletteFile.writeAsString(_currentPaletteInfo.toJascPal());
        break;
      case FileType.hex:
        mimeTypes = ["application/hex"];
        paletteFile = File(documents.path + "/${_currentPaletteInfo.name}.hex");
        await paletteFile.writeAsString(_currentPaletteInfo.toHex());
        break;
    }

    await Share.shareFiles([paletteFile.path], mimeTypes: mimeTypes);
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
