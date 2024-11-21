import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:fam_coding_supply/logic/model/device_info_data_entity.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

class AppDeviceInfoCS {
  final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  // final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static DeviceInfoData? deviceInfoData;

  Future<DeviceInfoData> getDeviceData() async {
    String deviceId;
    String deviceName;
    String deviceType;
    String osVersion;

    // Get Device Information
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id; // Android ID or generate a UUID
      deviceName = androidInfo.model;
      deviceType = "Android";
      osVersion = "Android ${androidInfo.version.release}";
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? const Uuid().v4(); // iOS Device ID or generate a UUID
      deviceName = iosInfo.utsname.machine;
      deviceType = "iOS";
      osVersion = "iOS ${iosInfo.systemVersion}";
    } else {
      deviceId = const Uuid().v4();
      deviceName = "Unknown Device";
      deviceType = "Unknown";
      osVersion = "Unknown OS";
    }

    // Get App Version
    final packageInfo = await PackageInfo.fromPlatform();
    String appVersion = packageInfo.version;

    // Get Push Token for Push Notifications
    // String? pushToken = await firebaseMessaging.getToken();

    // Get Current Time for RegisteredAt
    String registeredAt = DateTime.now().toIso8601String();

    DeviceInfoData result = DeviceInfoData(
      deviceId: deviceId,
      deviceName: deviceName,
      deviceType: deviceType,
      osVersion: osVersion,
      appVersion: appVersion,
      registeredAt: registeredAt,
    );
    deviceInfoData = result;
    return result;
  }
}
