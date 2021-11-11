import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutPage extends StatelessWidget {
  static const String name = "about";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations!.about),
      ),
      body: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final packageInfo = snapshot.data!;

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    localizations.appName,
                    style: textTheme.headline5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: CircleAvatar(
                      child: Image.asset("images/paint-palette.png"),
                      backgroundColor: theme.colorScheme.primary,
                      radius: 50,
                    ),
                  ),
                  Text(
                    "v${packageInfo.version}",
                    style: textTheme.caption,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    localizations.developedBy("Hericles Koelher"),
                    style: textTheme.bodyText1,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
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
                ],
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      drawer: ApplicationDrawer(),
    );
  }
}
