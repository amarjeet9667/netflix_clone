// ============================================================
//  network_info.dart
//  lib/core/networks/network_info.dart
//
//  Abstraction over internet connectivity check
//  Inject this into repositories — never use connectivity
//  package directly in business logic
// ============================================================

import 'dart:io';

abstract class NetworkInfo {
  /// Returns true if device has an active internet connection
  Future<bool> get isConnected;

  /// Throws [NetworkException] if not connected
  Future<void> checkConnectivity();
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 5));
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> checkConnectivity() async {
    final connected = await isConnected;
    if (!connected) {
      throw Exception('No internet connection.');
    }
  }
}
