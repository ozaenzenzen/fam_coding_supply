import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'fam_coding_supply_platform_interface.dart';

/// An implementation of [FamCodingSupplyPlatform] that uses method channels.
class MethodChannelFamCodingSupply extends FamCodingSupplyPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('fam_coding_supply');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
