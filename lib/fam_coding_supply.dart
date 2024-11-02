// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

library FamCodingSupply;

import 'package:fam_coding_supply/fam_coding_supply_platform_interface.dart';

import 'package:fam_coding_supply/logic/export.dart';

export 'package:fam_coding_supply/logic/export.dart';
export 'package:fam_coding_supply/ui/export.dart';
export 'package:fam_coding_supply/fam_coding_supply.dart';

class FamCodingSupply {
  AppConnectivityService appConnectivityService = AppConnectivityService();
  AppInfo appInfo = AppInfo();
  AppDeviceInfo appDeviceInfo = AppDeviceInfo();
  LocalServiceHive localServiceHive = LocalServiceHive();

  Future<String?> getPlatformVersion() {
    return FamCodingSupplyPlatform.instance.getPlatformVersion();
  }
}
