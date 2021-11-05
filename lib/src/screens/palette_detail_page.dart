import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

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
              _currentPaletteInfo.paletteName,
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

  void _editAction(BuildContext context) {}

  // TODO: ajustar para exportar para o formato selecionado nas configurações.
  void _shareAction(BuildContext context) async {
    final documents = await getApplicationDocumentsDirectory();

    final paletteFile =
        File(documents.path + "/${_currentPaletteInfo.paletteName}.gpl");

    await paletteFile.writeAsString(_currentPaletteInfo.toGpl());

    debugPrint(paletteFile.existsSync().toString());

    await Share.shareFiles([paletteFile.path], mimeTypes: ["application/gpl"]);
  }

  void _deleteAction(BuildContext context) {
    _paletteStateNotifier.deletePalette(_currentPaletteInfo.id);

    Navigator.pop(context);

    final SnackBar snackBar = SnackBar(
      content: Text(
        "Palette \'${_currentPaletteInfo.paletteName}\' was deleted!",
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
