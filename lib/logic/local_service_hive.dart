import 'package:fam_coding_supply/logic/encrypt_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
export 'package:hive_flutter/hive_flutter.dart';

class LocalServiceHive {
  /// get initalize status
  // static bool isInitialized = false;

  /// Initialize
  /// Should be call in every modules. will be ignored when initialized
  Future<void> init() async {
    try {
      await Hive.initFlutter();
    } catch (e) {
      Hive.init("./");
    }
    if (Hive.isBoxOpen("config")) {
      config = await Hive.openBox("config");
      await config.close();
      config = await Hive.openBox("config");
    } else {
      config = await Hive.openBox("config");
    }

    if (Hive.isBoxOpen("app")) {
      user = await Hive.openBox("app");
      await user.close();
      user = await Hive.openBox("app");
    } else {
      user = await Hive.openBox("app");
    }
  }

  /// Config box that can save configuration data of the apps
  late Box config;

  /// User data to stored data based on user session and can be cleared when logout
  late Box user;
}

extension SecureBox on Box {
  /// Saves the [key] - [value] pair securely.
  Future<void> putSecure({
    required String key,
    required dynamic data,
  }) async {
    key = HEX
        .encode(key.split("").reversed.join().codeUnits)
        .split("")
        .reversed
        .join();
    if (data != null) {
      data = EncryptUtils().encryptRandom(data: data);
    }
    await put(key, data);
  }

  /// Returns the value associated with the given [key]. If the key does not exist, null is returned.
  /// If [defaultValue] is specified, it is returned in case the key does not exist.
  dynamic getSecure({required String key, dynamic defaultValue}) {
    key = HEX
        .encode(key.split("").reversed.join().codeUnits)
        .split("")
        .reversed
        .join();

    var data = containsKey(key) ? get(key) : defaultValue;
    if (data != null) {
      data = EncryptUtils().decryptRandom(data: data);
    }

    return data;
  }
}