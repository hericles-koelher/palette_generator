import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens.dart';

class ApplicationDrawer extends StatelessWidget {
  const ApplicationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Container(
              width: double.maxFinite,
              child: Column(
                children: [
                  // TODO: arrumar essa porra aqui
                  Expanded(
                    child: Text("Palette Generator"),
                  ),
                  Expanded(
                    flex: 2,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Image.asset("images/paint-palette.png"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text("Home"),
            leading: FaIcon(FontAwesomeIcons.home),
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
          ListTile(
            title: Text("Settings"),
            leading: FaIcon(FontAwesomeIcons.cog),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ConfigScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("About"),
            leading: FaIcon(FontAwesomeIcons.infoCircle),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
