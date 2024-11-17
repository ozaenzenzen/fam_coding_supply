import 'package:connectivity_plus/connectivity_plus.dart';

enum AppConnectivityStatus { wifi, cellular, offline }

class AppConnectivityService {
  AppConnectivityService._internal();

  static final AppConnectivityService _instance = AppConnectivityService._internal();

  factory AppConnectivityService() {
    return _instance;
  }

  AppConnectivityStatus connectionStatus = AppConnectivityStatus.offline;

  Future<void> init() async {
    connectionStatus = _connectionStatus(await Connectivity().checkConnectivity());
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatus = _connectionStatus(result);
    });
  }

  /// Convert from the third part enum to our own enum
  AppConnectivityStatus _connectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return AppConnectivityStatus.cellular;
      case ConnectivityResult.wifi:
        return AppConnectivityStatus.wifi;
      case ConnectivityResult.none:
        return AppConnectivityStatus.offline;
      default:
        return AppConnectivityStatus.wifi;
    }
  }
}
