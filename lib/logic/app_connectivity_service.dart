import 'package:connectivity_plus/connectivity_plus.dart';

enum AppConnectivityStatus { wifi, cellular, offline }

class AppConnectivityService {
  static AppConnectivityStatus connectionStatus = AppConnectivityStatus.offline;

  static init() async {
    connectionStatus = _connectionStatus(await Connectivity().checkConnectivity());
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatus = _connectionStatus(result);
    });
  }

  /// Convert from the third part enum to our own enum
  static AppConnectivityStatus _connectionStatus(ConnectivityResult result) {
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
