import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/locales.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:palette_generator/src/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'src/constants.dart';
import 'src/models.dart';
import 'src/screens.dart';

class PaletteGenerator extends StatefulWidget {
  final Box paletteBox;

  PaletteGenerator({Key? key})
      : paletteBox = Hive.box(kPaletteBox),
        super(key: key);

  @override
  State<PaletteGenerator> createState() => _PaletteGeneratorState();
}

class _PaletteGeneratorState extends State<PaletteGenerator> {
  late final PaletteStateNotifier _paletteStateNotifier;
  late final ColorListStateNotifier _colorListStateNotifier;
  late final SliderStateNotifier _sliderStateNotifier;
  late final SettingsStateNotifier _settingsStateNotifier;
  // using "late final" just for access paletteStateNotifier
  late final _goRouter = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        name: HomePage.name,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: HomePage(),
        ),
        routes: [
          GoRoute(
            path: "create",
            name: PaletteCreationPage.name,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: PaletteCreationPage(),
            ),
          ),
          GoRoute(
            path: "info/:id",
            name: PaletteInfoPage.name,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              child: PaletteInfoPage(
                _paletteStateNotifier.getPalette(state.params["id"]!),
              ),
            ),
          ),
        ],
      ),
      GoRoute(
        path: "/settings",
        name: SettingsPage.name,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: SettingsPage(),
        ),
      ),
      GoRoute(
        path: "/about",
        name: AboutPage.name,
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: AboutPage(),
        ),
      ),
    ],
    errorPageBuilder: errorPage,
  );

  @override
  void initState() {
    _settingsStateNotifier = SettingsStateNotifier(
      paletteBox: widget.paletteBox,
    );

    _paletteStateNotifier = PaletteStateNotifier(
      paletteBox: widget.paletteBox,
      settings: _settingsStateNotifier,
    );

    _sliderStateNotifier = SliderStateNotifier(
      settings: _settingsStateNotifier,
    );

    _colorListStateNotifier = ColorListStateNotifier(
      settings: _settingsStateNotifier,
    );

    super.initState();
  }

  @override
  Future<void> dispose() async {
    await _paletteStateNotifier.dispose();
    await _settingsStateNotifier.dispose();
    await _colorListStateNotifier.dispose();
    await _sliderStateNotifier.dispose();

    await widget.paletteBox.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StateNotifierProvider.value(value: _paletteStateNotifier),
        StateNotifierProvider.value(value: _colorListStateNotifier),
        StateNotifierProvider.value(value: _sliderStateNotifier),
        StateNotifierProvider.value(value: _settingsStateNotifier),
      ],
      child: StateNotifierBuilder<Settings>(
        stateNotifier: _settingsStateNotifier,
        builder: (context, state, child) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          locale: state.language != null ? Locale(state.language!) : null,
          title: "Palette Generator",
          theme: ThemeManager.light,
          routeInformationParser: _goRouter.routeInformationParser,
          routerDelegate: _goRouter.routerDelegate,
        ),
      ),
    );
  }

  static Page errorPage(BuildContext context, GoRouterState state) {
    return MaterialPage(
      child: Center(
        child: Text(AppLocalizations.of(context)!.errorMessage),
      ),
    );
  }
}
