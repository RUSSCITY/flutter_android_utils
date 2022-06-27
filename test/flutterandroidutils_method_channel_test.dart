import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterandroidutils/flutterandroidutils_method_channel.dart';

void main() {
  MethodChannelFlutterandroidutils platform = MethodChannelFlutterandroidutils();
  const MethodChannel channel = MethodChannel('flutterandroidutils');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
