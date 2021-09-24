import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Screen not implemented yet",
              style: Theme.of(context).textTheme.headline6,
            ),
            FaIcon(
              FontAwesomeIcons.solidSadTear,
              color: Theme.of(context).primaryColor,
              size: 75,
            ),
          ],
        ),
      ),
      drawer: ApplicationDrawer(),
    );
  }
}
