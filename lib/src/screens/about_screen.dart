import 'package:flutter/material.dart';

import '../widgets.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Palette Generator"),
            CircleAvatar(
              child: Image.asset("images/paint-palette.png"),
              // TODO: mudar isso aqui depois
              backgroundColor: Colors.deepPurple[600],
              radius: 50,
            ),
            Text("Developed by Hericles Koelher"),
            // TODO: add twitter
          ],
        ),
      ),
      drawer: ApplicationDrawer(),
    );
  }
}
