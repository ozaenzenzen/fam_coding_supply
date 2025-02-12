// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

library fam_coding_supply;

import 'package:fam_coding_supply/fam_coding_supply_platform_interface.dart';

import 'package:fam_coding_supply/logic/export.dart';

export 'package:fam_coding_supply/logic/export.dart';
export 'package:fam_coding_supply/ui/export.dart';
export 'package:fam_coding_supply/fam_coding_supply.dart';
export 'package:google_fonts/google_fonts.dart';
export 'package:super_tooltip/super_tooltip.dart';
export 'package:intl/intl.dart';
export 'package:dio/dio.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';

class FamCodingSupply {
  AppConnectivityServiceCS appConnectivityService = AppConnectivityServiceCS();
  AppInfoCS appInfo = AppInfoCS();
  AppDeviceInfoCS appDeviceInfo = AppDeviceInfoCS();
  LocalServiceHive localServiceHive = LocalServiceHive();

  Future<String?> getPlatformVersion() {
    return FamCodingSupplyPlatform.instance.getPlatformVersion();
  }
}
