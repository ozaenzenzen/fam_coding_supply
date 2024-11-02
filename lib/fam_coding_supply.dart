// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:fam_coding_supply/logic/app_connectivity_service.dart';
import 'package:fam_coding_supply/logic/app_device_info.dart';
import 'package:fam_coding_supply/logic/app_info.dart';
import 'package:fam_coding_supply/logic/local_service_hive.dart';

class FamCodingSupply {
  // Future<String?> getPlatformVersion() {
  //   return FamCodingSupplyPlatform.instance.getPlatformVersion();
  // }
  AppConnectivityService appConnectivityService = AppConnectivityService();
  AppInfo appInfo = AppInfo();
  AppDeviceInfo appDeviceInfo = AppDeviceInfo();
  LocalServiceHive localServiceHive = LocalServiceHive();
}
