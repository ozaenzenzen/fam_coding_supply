import 'package:permission_handler/permission_handler.dart';
export 'package:permission_handler/permission_handler.dart';

class AppPermissionHandler {
  // Check if a specific permission is granted
  static Future<bool> isPermissionGranted(Permission permission) async {
    return await permission.isGranted;
  }

  // Request a single permission
  static Future<bool> requestPermission(Permission permission) async {
    final status = await permission.request();
    return status.isGranted;
  }

  // Request multiple permissions at once
  static Future<Map<Permission, PermissionStatus>> requestMultiplePermissions(List<Permission> permissions) async {
    return await permissions.request();
  }

  // Check and request permission if not granted
  static Future<bool> checkAndRequestPermission(Permission permission) async {
    if (await isPermissionGranted(permission)) {
      return true;
    }
    return await requestPermission(permission);
  }

  // Common permission checks
  static Future<bool> checkAndRequestStorage() async {
    return await checkAndRequestPermission(Permission.storage);
  }

  static Future<bool> checkAndRequestCamera() async {
    return await checkAndRequestPermission(Permission.camera);
  }

  static Future<bool> checkAndRequestLocation() async {
    return await checkAndRequestPermission(Permission.location);
  }

  static Future<bool> checkAndRequestMicrophone() async {
    return await checkAndRequestPermission(Permission.microphone);
  }

  // Open app settings for manual permission management
  static Future<bool> openAppSettings() async {
    return await openAppSettings();
  }

  // Check if permission is permanently denied
  static Future<bool> isPermanentlyDenied(Permission permission) async {
    return await permission.isPermanentlyDenied;
  }

  // Handle permission with user guidance
  static Future<bool> handlePermission({
    required Permission permission,
    required Function onPermanentlyDenied,
    required Function onDenied,
    required Function onGranted,
  }) async {
    final status = await permission.status;

    if (status.isGranted) {
      onGranted();
      return true;
    } else if (status.isPermanentlyDenied) {
      onPermanentlyDenied();
      return false;
    } else {
      final result = await permission.request();
      if (result.isGranted) {
        onGranted();
        return true;
      } else if (result.isPermanentlyDenied) {
        onPermanentlyDenied();
        return false;
      } else {
        onDenied();
        return false;
      }
    }
  }
}
