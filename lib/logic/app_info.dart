import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  static String? appVersion = "-";
  // static String? get appVersion => _appVersion;
  // static set appVersion(String? appVersion) {
  //   _appVersion = appVersion;
  // }

  static String buildTypeCustom = '';

  static PackageInfo? packageInfo;

  static Future<void> appInfoInit() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = "${packageInfo.version}+${packageInfo.buildNumber}$buildTypeCustom";
  }

  static Future<String?> showAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = "${packageInfo.version}+${packageInfo.buildNumber}$buildTypeCustom";
    return appVersion;
  }
}
