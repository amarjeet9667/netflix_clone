import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'package:netflix_clone/injections/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── Lock to portrait (Netflix default) ───────────────────
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // ── Status bar style (dark overlay on black bg) ───────────
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  // ── Environment ───────────────────────────────────────────
  AppConfig.initialize(environment: Environment.prod);

  // ── Dependency injection ──────────────────────────────────
  await di.init();

  runApp(const NetflixApp());
}