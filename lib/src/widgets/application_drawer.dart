import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../screens.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ApplicationDrawer extends StatelessWidget {
  const ApplicationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);

    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Container(
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        localizations!.appName,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        child: Image.asset("images/paint-palette.png"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            child: ListTile(
              title: Text(localizations.home),
              leading: FaIcon(FontAwesomeIcons.home),
              onTap: () {
                context.goNamed(HomePage.name);
              },
            ),
          ),
          Flexible(
            child: ListTile(
              title: Text(localizations.settings),
              leading: FaIcon(FontAwesomeIcons.cog),
              onTap: () {
                context.goNamed(SettingsPage.name);
              },
            ),
          ),
          Flexible(
            child: ListTile(
              title: Text(localizations.about),
              leading: FaIcon(FontAwesomeIcons.infoCircle),
              onTap: () {
                context.goNamed(AboutPage.name);
              },
            ),
          ),
        ],
      ),
    );
  }
}
