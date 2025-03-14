import 'package:fam_coding_supply/fam_coding_supply.dart';
import 'package:geolocator/geolocator.dart';
import 'package:safe_device/safe_device.dart';

class AppSafeDeviceCS {
  static bool isJailBroken = false;
  static bool isMockLocation = false;
  static bool isRealDevice = false;
  static bool isOnExternalStorage = false;
  static bool isSafeDevice = false;
  static bool isDevelopmentModeEnable = false;

  static Future<void> permissionHandler() async {
    try {
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        await AppSettings.openAppSettings(type: AppSettingsType.location);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> init({
    Function(bool value)? callbackJailBroken,
    Function(bool value)? callbackMockLocation,
    Function(bool value)? callbackRealDevice,
    Function(bool value)? callbackOnExternalStorage,
    Function(bool value)? callbackSafeDevice,
    Function(bool value)? callbackDevelopmentModeEnable,
  }) async {
    try {
      await permissionHandler();

      isJailBroken = await SafeDevice.isJailBroken;
      if (isJailBroken) {
        callbackJailBroken?.call(isJailBroken);
      }
      isMockLocation = await SafeDevice.isMockLocation;
      if (isMockLocation) {
        callbackMockLocation?.call(isMockLocation);
      }
      isRealDevice = await SafeDevice.isRealDevice;
      if (isRealDevice) {
        callbackRealDevice?.call(isRealDevice);
      }
      isOnExternalStorage = await SafeDevice.isOnExternalStorage;
      if (isOnExternalStorage) {
        callbackOnExternalStorage?.call(isOnExternalStorage);
      }
      isSafeDevice = await SafeDevice.isSafeDevice;
      if (isSafeDevice) {
        callbackSafeDevice?.call(isSafeDevice);
      }
      isDevelopmentModeEnable = await SafeDevice.isDevelopmentModeEnable;
      if (isDevelopmentModeEnable) {
        callbackDevelopmentModeEnable?.call(isDevelopmentModeEnable);
      }
    } on Exception catch (error) {
      AppLoggerCS.debugLog("[AppSafeDeviceCS][init] $error");
    }
  }

  static Future<bool> detectMockLocation() async {
    await permissionHandler();

    isMockLocation = await SafeDevice.isMockLocation;
    return isMockLocation;
  }
}
