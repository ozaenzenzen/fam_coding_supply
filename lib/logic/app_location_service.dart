import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:geolocator/geolocator.dart';

class AppLocationService {
//   Location location = new Location();

// bool _serviceEnabled;
// PermissionStatus _permissionGranted;

// _serviceEnabled = await location.serviceEnabled();
// if (!_serviceEnabled) {
//  _serviceEnabled = await location.requestService();
//  if (!_serviceEnabled) {
//    return null;
//  }
// }

// _permissionGranted = await location.hasPermission();
// if (_permissionGranted == PermissionStatus.denied) {
//  _permissionGranted = await location.requestPermission();
//  if (_permissionGranted != PermissionStatus.granted) {
//    return null;
//  }
// }

  static init() async {
    await permissionHandlerLocation();
  }

  static Future<bool> permissionHandlerLocation() async {
    try {
      LocationPermission locationPermission;
      locationPermission = await Geolocator.checkPermission();
      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.denied) {
          return false;
        } else {
          return true;
        }
      } else if (locationPermission == LocationPermission.deniedForever) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<void> requestPermissionLocation({
    Future<void> Function()? onServiceNotEnabled,
    Future<void> Function(Future<void> Function() retry)? onDenied,
    Future<void> Function(Future<void> Function() openSettings)? onDedniedFOrever,
  }) async {
    try {
      //
    } catch (e) {
      //
    }
  }

  static Future<Position?> getCurrentPosition() async {
    try {
      bool serviceEnabled;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      } else {
        Position currentPosition = await Geolocator.getCurrentPosition();
        return currentPosition;
      }
    } catch (e) {
      return null;
    }
  }

  // Future<String> _getAddress(double? lat, double? lang) async {
  //   if (lat == null || lang == null) return "";
  //   GeoCode geoCode = GeoCode();
  //   Address address = await geoCode.reverseGeocoding(latitude: lat, longitude: lang);
  //   return "${address.streetAddress}, ${address.city}, ${address.countryName}, ${address.postal}";
  // }

  Position? currentPosition;
  StreamSubscription<Position>? _positionStream;

  bool _serviceEnabled = false;

  int _distanceFilter = 100;
  int get distanceFilter => _distanceFilter;
  set distanceFilter(int distance) {
    _distanceFilter = distance;
    _positionStream?.cancel();
    requestPermission();
  }

  final List<CBLocationListener> _listener = [];
  void addListener(CBLocationListener listener) {
    _listener.add(listener);
  }

  void removeListener(String key) {
    _listener.removeWhere((element) => element.key == key);
  }

  Future<void> start() async {
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    var serviceEnabledStream = Geolocator.getServiceStatusStream();
    serviceEnabledStream.listen((event) {
      _serviceEnabled = event == ServiceStatus.enabled;
      if (_serviceEnabled) {
        requestPermission();
      } else {
        currentPosition = null;
        _positionStream?.cancel();
      }
    });
    if (_serviceEnabled) {
      requestPermission();
    }
  }

  Future<void> requestPermission({
    Future<void> Function()? onServiceNotEnabled,
    Future<void> Function(Future<void> Function() retry)? onDenied,
    Future<void> Function(Future<void> Function() openSetting)? onDeniedForever,
  }) async {
    if (!_serviceEnabled) {
      return onServiceNotEnabled?.call();
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await onDenied?.call(requestPermission);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      await onDeniedForever?.call(
        () async {
          await AppSettings.openAppSettings(type: AppSettingsType.location);
        },
      );
    }
    _getLocation();
  }

  void _getLocation() {
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 100,
      ),
    ).listen((event) {
      currentPosition = event;
      for (var listener in _listener) {
        listener.listener.call(event);
      }
    }, onError: (error) {
      currentPosition = null;
      _positionStream?.cancel();
    });
  }
}

class CBLocationListener {
  final String key;
  final Function(Position position) listener;

  CBLocationListener({required this.key, required this.listener});
}
