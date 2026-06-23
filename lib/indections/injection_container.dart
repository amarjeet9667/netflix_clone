// ============================================================
//  injection_container.dart
//  lib/injection/injection_container.dart
//
//  GetIt service locator — single sl instance used everywhere
//  Call init() once in main() before runApp()
//  Usage anywhere: sl<AuthBloc>()  sl<MovieRepository>()
// ============================================================

import 'package:get_it/get_it.dart';

// ── Core ─────────────────────────────────────────────────────
import 'package:netflix_clone/core/networks/network_info.dart';

// ── Modules ──────────────────────────────────────────────────
import 'modules/network_module.dart';
import 'modules/repository_module.dart';
import 'modules/usecase_module.dart';
import 'modules/bloc_module.dart';

/// Global service locator instance.
/// Access via `sl<T>()` anywhere in the app.
final GetIt sl = GetIt.instance;

/// Call once in [main] before [runApp].
Future<void> init() async {
  // ── Order matters: each layer depends on the one above it ──
  // 1. External / core services
  await _registerCore();

  // 2. Network (Dio, interceptors)
  NetworkModule.register(sl);

  // 3. Data sources → Repositories
  RepositoryModule.register(sl);

  // 4. Use cases
  UsecaseModule.register(sl);

  // 5. BLoCs / Cubits (depend on use cases)
  BlocModule.register(sl);
}

Future<void> _registerCore() async {
  // Network connectivity checker
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(),
  );
}