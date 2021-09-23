import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../widgets.dart';

enum _DetailsPageActions {
  share,
  delete,
  rename,
}

extension ParseToString on _DetailsPageActions {
  String valueToCapitalizedString() {
    String result = this.toString().split('.').last;

    return "${result[0].toUpperCase()}${result.substring(1)}";
  }
}

// usar uma sliverappbar e fazer ela ocupar espaço remanescente na tela...

class PaletteDetailPage extends StatefulWidget {
  final PaletteInfo paletteInfo;
  final TextEditingController _renameController;

  PaletteDetailPage(this.paletteInfo)
      : _renameController = TextEditingController(
          text: paletteInfo.paletteName,
        );

  @override
  State<PaletteDetailPage> createState() =>
      _PaletteDetailPageState(paletteInfo);
}

class _PaletteDetailPageState extends State<PaletteDetailPage> {
  late final PaletteStateNotifier _paletteStateNotifier;
  PaletteInfo _currentPaletteInfo;

  _PaletteDetailPageState(this._currentPaletteInfo) : super();

  @override
  void initState() {
    _currentPaletteInfo = widget.paletteInfo;
    _paletteStateNotifier =
        Provider.of<PaletteStateNotifier>(context, listen: false);

    super.initState();
  }

  void _deleteAction(BuildContext context) {
    _paletteStateNotifier.deletePalette(_currentPaletteInfo.id);

    Navigator.pop(context);

    // SnackBar snackBar = SnackBar(
    //   content: Text(
    //     "Palette \'${_currentPaletteInfo.paletteName}\' was deleted!",
    //   ),
    //   action: SnackBarAction(
    //     label: "UNDO",
    //     onPressed: () {
    //       _paletteStateNotifier.undo();
    //     },
    //   ),
    // );
    //
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _renameAction(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialogTextField(
        title: "What is your palette new name?",
        textController: widget._renameController,
        onCompleted: () {
          setState(
            () {
              _currentPaletteInfo = _paletteStateNotifier.updatePalette(
                _currentPaletteInfo,
                paletteName: widget._renameController.text,
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          _currentPaletteInfo.paletteName,
        ),
        actions: [
          IconButton(
            icon: _currentPaletteInfo.isFavorite
                ? FaIcon(
                    FontAwesomeIcons.solidHeart,
                    color: Colors.redAccent,
                  )
                : FaIcon(FontAwesomeIcons.heart),
            onPressed: () {
              setState(
                () {
                  _currentPaletteInfo = _paletteStateNotifier.updatePalette(
                    _currentPaletteInfo,
                    isFavorite: !_currentPaletteInfo.isFavorite,
                  );
                },
              );
            },
          ),
          PopupMenuButton<_DetailsPageActions>(
            icon: FaIcon(FontAwesomeIcons.ellipsisV),
            onSelected: (action) {
              switch (action) {
                case _DetailsPageActions.delete:
                  _deleteAction(context);
                  break;
                case _DetailsPageActions.share:
                  // TODO: Arrumar isso aqui.
                  break;
                case _DetailsPageActions.rename:
                  _renameAction(context);
                  break;
              }
            },
            itemBuilder: (context) {
              return _DetailsPageActions.values
                  .map(
                    (enumValue) => PopupMenuItem(
                      padding: EdgeInsets.only(left: 15, right: 40),
                      value: enumValue,
                      child: Text(
                        enumValue.valueToCapitalizedString(),
                      ),
                    ),
                  )
                  .toList();
            },
          ),
        ],
      ),
      body: PaletteGrid(
        colors: _currentPaletteInfo.colors,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
      ),
    );
  }
}
