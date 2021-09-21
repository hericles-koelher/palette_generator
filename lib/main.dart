import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:palette_generator/src/models.dart';
import 'package:palette_generator/src/constants.dart';
import 'palette_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(PaletteInfoAdapter());
  Hive.registerAdapter(ConfigurationsAdapter());

  await Hive.openBox(kPaletteBox);

  runApp(PaletteGenerator());
}
