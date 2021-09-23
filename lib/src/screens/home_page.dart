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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          body: Builder(
            builder: (context) {
              return CustomScrollView(
                slivers: [
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),
                  SliverFillRemaining(
                    child: Column(
                      children: [
                        TabBar(
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
                              _listFavoritePalettes(context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: _header(context),
              ),
            ];
          },
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

  Widget _header(context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double barHeight = 2 * screenHeight / 5;

    return SliverAppBar(
      pinned: true,
      expandedHeight: barHeight,
      collapsedHeight: barHeight,
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
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _listPalettes(List<PaletteInfo> palettes) {
    return ListView(
      padding: EdgeInsets.only(top: 10),
      physics: BouncingScrollPhysics(),
      children: List.generate(
        palettes.length > 0 ? (palettes.length * 2) - 1 : 0,
        (index) {
          if (index.isEven)
            return HomePaletteListTile(
              paletteInfo: palettes[index ~/ 2],
            );
          else
            return Divider();
        },
      ),
    );
  }

  Widget _listAllPalettes(BuildContext context) {
    return StateNotifierBuilder<List<PaletteInfo>>(
      builder: (context, state, child) {
        return _listPalettes(state);
      },
      stateNotifier: Provider.of<PaletteStateNotifier>(context),
    );
  }

  Widget _listFavoritePalettes(BuildContext context) {
    return StateNotifierBuilder<List<PaletteInfo>>(
      builder: (context, state, child) {
        List<PaletteInfo> favorites =
            state.where((palette) => palette.isFavorite).toList();

        return _listPalettes(favorites);
      },
      stateNotifier: Provider.of<PaletteStateNotifier>(context),
    );
  }
}
