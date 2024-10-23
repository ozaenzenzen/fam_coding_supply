import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class AppLocalStorage {
  static init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.openBox("VehicleLogApps");
  }
}
