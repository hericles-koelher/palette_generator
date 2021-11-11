import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models.dart';
import '../screens.dart';
import '../widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  static const String name = "home";

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: _header(context),
              ),
            ];
          },
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
                        Material(
                          elevation: 2,
                          child: TabBar(
                            tabs: [
                              Tab(
                                text: localizations!.all,
                              ),
                              Tab(
                                text: localizations.favorites,
                              ),
                            ],
                          ),
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
        ),
        floatingActionButton: FloatingActionButton(
          child: FaIcon(
            FontAwesomeIcons.plus,
          ),
          onPressed: () {
            context.goNamed(PaletteCreationPage.name);
          },
        ),
        drawer: ApplicationDrawer(),
      ),
    );
  }

  Widget _header(context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double barHeight = 0.4 * screenHeight;
    final localizations = AppLocalizations.of(context);

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
                Colors.orangeAccent,
                Colors.red,
                Colors.deepPurple,
              ],
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          localizations!.appName.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }

  Widget _listPalettes(BuildContext context, List<PaletteInfo> palettes) {
    final paletteNotifier =
        Provider.of<PaletteStateNotifier>(context, listen: false);
    final localizations = AppLocalizations.of(context);

    return ListView.separated(
      itemCount: palettes.length,
      padding: const EdgeInsets.only(top: 10),
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, index) {
        String paletteId = palettes[index].id;

        final palette = PaletteInfoListTile(
          paletteInfo: palettes[index],
        );

        void Function() deleteAndShowSnackBar = () {
          paletteNotifier.deletePalette(paletteId);

          final SnackBar snackBar = SnackBar(
            content: Text(
              localizations!.paletteDeletedMessage(palette.paletteInfo.name),
            ),
            action: SnackBarAction(
              label: localizations.undo,
              onPressed: () {
                paletteNotifier.undo();
              },
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        };

        return Slidable(
          actionPane: SlidableScrollActionPane(),
          actionExtentRatio: 0.4,
          key: Key(paletteId),
          dismissal: SlidableDismissal(
            child: SlidableDrawerDismissal(),
            onDismissed: (type) {
              deleteAndShowSnackBar();
            },
          ),
          actions: [
            IconSlideAction(
              color: Theme.of(context).primaryColor,
              icon: FontAwesomeIcons.trashAlt,
              onTap: deleteAndShowSnackBar,
            ),
          ],
          child: palette,
        );
      },
    );
  }

  Widget _listAllPalettes(BuildContext context) {
    return StateNotifierBuilder<List<PaletteInfo>>(
      builder: (context, state, child) {
        return _listPalettes(context, state);
      },
      stateNotifier: Provider.of<PaletteStateNotifier>(context),
    );
  }

  Widget _listFavoritePalettes(BuildContext context) {
    return StateNotifierBuilder<List<PaletteInfo>>(
      builder: (context, state, child) {
        List<PaletteInfo> favorites =
            state.where((palette) => palette.isFavorite).toList();

        return _listPalettes(context, favorites);
      },
      stateNotifier: Provider.of<PaletteStateNotifier>(context),
    );
  }
}
