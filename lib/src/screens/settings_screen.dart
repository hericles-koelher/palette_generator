import 'package:flutter/material.dart';

import '../widgets.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      drawer: ApplicationDrawer(),
    );
  }
}
