import 'package:flutter_test/flutter_test.dart';
import 'package:fam_coding_supply/fam_coding_supply.dart';
import 'package:fam_coding_supply/fam_coding_supply_platform_interface.dart';
import 'package:fam_coding_supply/fam_coding_supply_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFamCodingSupplyPlatform
    with MockPlatformInterfaceMixin
    implements FamCodingSupplyPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FamCodingSupplyPlatform initialPlatform = FamCodingSupplyPlatform.instance;

  test('$MethodChannelFamCodingSupply is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFamCodingSupply>());
  });

  test('getPlatformVersion', () async {
    FamCodingSupply famCodingSupplyPlugin = FamCodingSupply();
    MockFamCodingSupplyPlatform fakePlatform = MockFamCodingSupplyPlatform();
    FamCodingSupplyPlatform.instance = fakePlatform;

    expect(await famCodingSupplyPlugin.getPlatformVersion(), '42');
  });
}
