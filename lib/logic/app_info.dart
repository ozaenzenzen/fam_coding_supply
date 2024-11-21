import 'package:package_info_plus/package_info_plus.dart';

class AppInfoCS {
  String? appVersion = "-";
  // static String? get appVersion => _appVersion;
  // static set appVersion(String? appVersion) {
  //   _appVersion = appVersion;
  // }

  String buildTypeCustom = '';

  PackageInfo? packageInfo;

  Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = "${packageInfo.version}+${packageInfo.buildNumber}$buildTypeCustom";
  }

  Future<String?> showAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = "${packageInfo.version}+${packageInfo.buildNumber}$buildTypeCustom";
    return appVersion;
  }
}
