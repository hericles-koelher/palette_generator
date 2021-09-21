import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../screens.dart';
import '../widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: true,
              expandedHeight: 2 * screenHeight / 5,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.lime,
                        Colors.yellow[400]!,
                        // Colors.orange,
                        Colors.red,
                        // Colors.blue,
                        // Colors.blue[700]!,
                        // Colors.deepPurple,
                      ],
                    ),
                  ),
                ),
                centerTitle: true,
                title: Text(
                  "PALETTE GENERATOR",
                ),
              ),
            ),
            SliverFillRemaining(
              child: Column(
                children: [
                  // TODO: transferir essa tabbar para ficar junto ao sliverappbar.
                  // conferir: https://medium.com/@diegoveloper/flutter-collapsing-toolbar-sliver-app-bar-14b858e87abe
                  TabBar(
                    indicatorColor: Colors.deepPurple,
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.grey[600],
                    labelStyle: Theme.of(context).textTheme.bodyText1,
                    tabs: [
                      Tab(
                        text: "All",
                      ),
                      Tab(
                        text: "Favorites",
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _listAllPalettes(context),
                        Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: FaIcon(
            FontAwesomeIcons.plus,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaletteCreationPage(),
              ),
            );
          },
        ),
        drawer: ApplicationDrawer(),
      ),
    );
  }

  Widget _listAllPalettes(BuildContext context) {
    return StateNotifierBuilder<List<PaletteInfo>>(
      builder: (context, state, child) {
        return Column(
          children: List.generate(
            state.length > 0 ? (state.length * 2) - 1 : 0,
            (index) {
              if (index.isEven)
                return HomePaletteListTile(
                  paletteInfo: state[index ~/ 2],
                );
              else
                return Divider();
            },
          ),
        );
      },
      stateNotifier: Provider.of<PaletteStateNotifier>(context),
    );
  }
}
