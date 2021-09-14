import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:palette_generator/models/palette_info.dart';
import 'package:palette_generator/models/palette_state_notifier.dart';
import 'package:palette_generator/screens/palette_creation_page.dart';
import 'package:palette_generator/utils/constants.dart';
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
            expandedHeight: screenHeight / 3,
            collapsedHeight: screenHeight / 10,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "PALETTE GENERATOR",
                style: kDefaultTextStyle.copyWith(fontSize: 20.0),
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
                      padding: const EdgeInsets.all(25.0),
                      child: Text(
                        "Saved Palettes",
                        style: kPrimaryTextStyle.copyWith(fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: StateNotifierBuilder<List<PaletteInfo>>(
                        builder: (context, state, child) {
                          debugPrint("build...");
                          return Column(
                            children: List.generate(
                              state.length,
                              (index) => PaletteListTile(
                                paletteInfo: state[index],
                              ),
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
          // Puto pq não tá pegando a cor do tema?
          color: Colors.white,
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
