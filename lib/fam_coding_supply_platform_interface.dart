import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'fam_coding_supply_method_channel.dart';

abstract class FamCodingSupplyPlatform extends PlatformInterface {
  /// Constructs a FamCodingSupplyPlatform.
  FamCodingSupplyPlatform() : super(token: _token);

  static final Object _token = Object();

  static FamCodingSupplyPlatform _instance = MethodChannelFamCodingSupply();

  /// The default instance of [FamCodingSupplyPlatform] to use.
  ///
  /// Defaults to [MethodChannelFamCodingSupply].
  static FamCodingSupplyPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FamCodingSupplyPlatform] when
  /// they register themselves.
  static set instance(FamCodingSupplyPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
