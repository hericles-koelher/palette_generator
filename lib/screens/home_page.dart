import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:palette_generator/models/palette_info.dart';
import 'package:palette_generator/models/palette_state_notifier.dart';
import 'package:palette_generator/screens/palette_creation_page.dart';
import 'package:palette_generator/widgets/palette_list_tile.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            expandedHeight: screenHeight / 3,
            collapsedHeight: screenHeight / 12,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "PALETTE GENERATOR",
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        "Saved Palettes",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: StateNotifierBuilder<List<PaletteInfo>>(
                        builder: (context, state, child) {
                          return Column(
                            children: List.generate(
                              state.length > 0 ? (state.length * 2) - 1 : 0,
                              (index) {
                                if (index.isEven)
                                  return PaletteListTile(
                                    paletteInfo: state[index ~/ 2],
                                  );
                                else
                                  return Divider();
                              },
                            ),
                          );
                        },
                        stateNotifier:
                            Provider.of<PaletteStateNotifier>(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 30.0,
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
    );
  }
}
