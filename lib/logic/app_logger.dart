import 'dart:developer';

class AppLogger {
  static void debugLog(
    String value, {
    bool isActive = true,
  }) {
    if (useLogger != null && useLogger == true) {
      if (isActive) {
        log(value);
      }
    }
  }

  static bool? useLogger;
}
