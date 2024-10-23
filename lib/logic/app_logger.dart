import 'dart:developer';

class AppLogger {
  static void debugLog(
    String value, {
    isActive = true,
  }) {
    if (isActive) {
      log(value);
    }
  }
}
