import 'dart:developer';

class AppLoggerCS {
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
