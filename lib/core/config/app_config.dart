import 'package:flutter/foundation.dart';

enum Environment { dev, test, prod }

class AppConfig {
  AppConfig._(); // prevent instantiation

  static Environment _environment = Environment.dev;
  static AppConfig? _instance;

  static AppConfig get instance {
    _instance ??= AppConfig._();
    return _instance!;
  }

  // ─── Setup ───────────────────────────────────────────────
  static void initialize({required Environment environment}) {
    _environment = environment;
    _instance = AppConfig._();
    if (kDebugMode) {
      debugPrint(
        'AppConfig initialized → $_environment | baseUrl: $baseUrl',
      );
    }
  }

  // ─── Environment ─────────────────────────────────────────
  static Environment get environment => _environment;

  static bool get isDev => _environment == Environment.dev;
  static bool get isTest => _environment == Environment.test;
  static bool get isProd => _environment == Environment.prod;

  // ─── Base URLs ───────────────────────────────────────────
  static String get baseUrl => switch (_environment) {
    Environment.dev => 'https://dev-api.example.com',
    Environment.test => 'https://dummyjson.com',
    Environment.prod => 'https://api.example.com',
  };

  static String get imageBaseUrl => switch (_environment) {
    Environment.dev => 'https://dev-images.example.com',
    Environment.test => 'https://dummyjson.com',
    Environment.prod => 'https://image.example.com',
  };

  static String get socketUrl => switch (_environment) {
    Environment.dev => 'wss://dev-ws.example.com',
    Environment.test => 'wss://test-ws.example.com',
    Environment.prod => 'wss://ws.example.com',
  };

  // ─── Timeouts ────────────────────────────────────────────
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 20);

  // ─── API Config ──────────────────────────────────────────
  static const String apiVersion = 'v1';
  static String get apiBaseUrl => '$baseUrl/api/$apiVersion';

  static const int maxRetryAttempts = 3;
  static const int paginationLimit = 20;

  // ─── Feature Flags ───────────────────────────────────────
  static bool get enableLogging => !isProd;
  static bool get enableCrashlytics => isProd;
  static bool get enableAnalytics => isProd;
  static bool get showDebugBanner => !isProd;

  // ─── App Info ────────────────────────────────────────────
  static const String appName = 'Netflix Clone';
  static const String appVersion = '1.0.0';
  static const String buildNumber = '1';
}

// ─── Usage Example (keep as comment for team reference) ───
/*
  // in main.dart
  void main() {
    AppConfig.initialize(environment: Environment.dev);
    runApp(const MyApp());
  }

  // in main_prod.dart
  void main() {
    AppConfig.initialize(environment: Environment.prod);
    runApp(const MyApp());
  }

  // anywhere in app
  final url  = AppConfig.baseUrl;
  final isD  = AppConfig.isDev;
  final logs = AppConfig.enableLogging;
*/
