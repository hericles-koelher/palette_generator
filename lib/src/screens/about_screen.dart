import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            Flexible(
              flex: 2,
              child: Text(
                "Palette Generator",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Spacer(),
            Flexible(
              flex: 2,
              child: CircleAvatar(
                child: Image.asset("images/paint-palette.png"),
                backgroundColor: Theme.of(context).primaryColor,
                radius: 50,
              ),
            ),
            Spacer(),
            Flexible(
              flex: 2,
              child: Text(
                "Developed by Hericles Koelher",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            // Spacer(),
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: FaIcon(
                      FontAwesomeIcons.twitter,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                  Flexible(
                    child: Text("@HericlesKoelher"),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      drawer: ApplicationDrawer(),
    );
  }
}
