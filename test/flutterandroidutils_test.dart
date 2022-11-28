import 'package:flutter_test/flutter_test.dart';
import 'package:flutterandroidutils/flutterandroidutils.dart';
import 'package:flutterandroidutils/flutterandroidutils_platform_interface.dart';
import 'package:flutterandroidutils/flutterandroidutils_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterandroidutilsPlatform 
    with MockPlatformInterfaceMixin
    implements FlutterandroidutilsPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterandroidutilsPlatform initialPlatform = FlutterandroidutilsPlatform.instance;

  test('$MethodChannelFlutterandroidutils is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterandroidutils>());
  });

  test('getPlatformVersion', () async {
    FlutterAndroidUtils flutterandroidutilsPlugin = FlutterAndroidUtils();
    MockFlutterandroidutilsPlatform fakePlatform = MockFlutterandroidutilsPlatform();
    FlutterandroidutilsPlatform.instance = fakePlatform;
  
    expect(await flutterandroidutilsPlugin.getPlatformVersion(), '42');
  });
}
