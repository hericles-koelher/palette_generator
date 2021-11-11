import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../widgets.dart';

class AboutPage extends StatelessWidget {
  static const String name = "about";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
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
                    packageInfo.appName,
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
                    "Developed by Hericles Koelher",
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
