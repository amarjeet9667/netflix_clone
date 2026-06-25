import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:netflix_clone/indections/injection_container.dart' as di;

import 'app.dart';
import 'core/config/app_config.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // ── Dev environment ───────────────────────────────────────
  AppConfig.initialize(environment: Environment.dev);

  await di.init();

  runApp(const NetflixApp());
}