import 'dart:developer';

import 'package:flutter/foundation.dart';

class AppLoggerCS {
  static void debugLog(
    String value, {
    bool isActive = true,
  }) {
    // if (useLogger != null && useLogger == true) {
    if (useLogger) {
      if (isActive) {
        if (useFoundation) {
          debugPrint(value);
        } else {
          log(value);
        }
      }
    }
  }

  static void debugLogSpecific({
    required String value,
    required String processName,
    required String functionName,
    bool isActive = true,
  }) {
    // if (useLogger != null && useLogger == true) {
    if (useLogger) {
      if (isActive) {
        if (useFoundation) {
          debugPrint("[$functionName][$processName]: $value");
        } else {
          log("[$functionName][$processName]: $value");
        }
      }
    }
  }

  /// WARNING!!! THIS SHOULD BE FALSE ON PRODUCTION
  static bool useFoundation = false;

  /// WARNING!!! THIS SHOULD BE FALSE ON PRODUCTION
  static bool useLogger = false;
}
