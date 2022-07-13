import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutterandroidutils_platform_interface.dart';

/// An implementation of [FlutterandroidutilsPlatform] that uses method channels.
class MethodChannelFlutterandroidutils extends FlutterandroidutilsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutterandroidutils');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool> isAccessibilityServiceProvided(String className) async {
    final isProvided = await methodChannel.invokeMethod<bool>(
        'isAccessibilityEnabled', {'serviceClassName': className});
    return isProvided ?? false;
  }

  @override
  Future<bool> isScreenAccessProvided() async {
    final isProvided =
        await methodChannel.invokeMethod<bool>('isScreenAccessProvided');
    return isProvided ?? false;
  }

  @override
  Future<bool> requestScreenAccess() async {
    final isProvided =
    await methodChannel.invokeMethod<bool>('requestScreenAccess');
    return isProvided ?? false;
  }

  @override
  Future<bool> test() async {
    final isProvided =
    await methodChannel.invokeMethod<bool>('test');
    return isProvided ?? false;
  }
}
