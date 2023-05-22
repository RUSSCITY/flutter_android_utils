import 'dart:convert';

import 'package:flutter/services.dart';

import 'flutterandroidutils_platform_interface.dart';

/// An implementation of [FlutterandroidutilsPlatform] that uses method channels.
class MethodChannelFlutterandroidutils extends FlutterandroidutilsPlatform {
  /// The method channel used to interact with the native platform.
  final methodChannel = const MethodChannel('flutterandroidutils');

  @override
  Future<bool> sendBroadCast(String message) async {
    final isProvided = await methodChannel
        .invokeMethod<bool>('sendBroadCast', {'message': message});
    return isProvided ?? false;
  }

  @override
  Future<void> setCallBackListener(Function? callback) async {
    methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "messageToClient":
          if (callback != null) {
            callback!(call.arguments);
          }
          break;
        default:
          print('no method handler for method ${call.method}');
      }
    });
  }

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
  Future<bool> openAccessibilityServiceSettings(String className) async {
    final isProvided = await methodChannel.invokeMethod<bool>(
        'openAccessibilityServiceSettings', {'serviceClassName': className});
    return isProvided ?? false;
  }

  @override
  Future<bool> getSharedPreferencesBool(String name, bool defaultValue) async {
    final isProvided = await methodChannel.invokeMethod<bool>(
        'getSharedPreferencesBool',
        {'name': name, 'defaultValue': defaultValue});
    return isProvided ?? defaultValue;
  }

  @override
  Future<int> getSharedPreferencesInt(String name, int defaultValue) async {
    final isProvided = await methodChannel.invokeMethod<int>(
        'getSharedPreferencesInt',
        {'name': name, 'defaultValue': defaultValue});
    return isProvided ?? defaultValue;
  }

  @override
  Future<int> getSharedPreferencesLong(String name, int defaultValue) async {
    final isProvided = await methodChannel.invokeMethod<int>(
        'getSharedPreferencesLong',
        {'name': name, 'defaultValue': defaultValue});
    return isProvided ?? defaultValue;
  }

  @override
  Future<String> getSharedPreferencesString(String name,
      String defaultValue) async {
    final isProvided = await methodChannel.invokeMethod<String>(
        'getSharedPreferencesString',
        {'name': name, 'defaultValue': defaultValue});
    return isProvided ?? defaultValue;
  }

  @override
  Future<bool> putSharedPreferencesBool(String name, bool value) async {
    return await methodChannel.invokeMethod<bool>(
        'putSharedPreferencesBool', {'name': name, 'value': value}) ??
        false;
  }

  @override
  Future<bool> putSharedPreferencesInt(String name, int value) async {
    return await methodChannel.invokeMethod<bool>(
        'putSharedPreferencesInt', {'name': name, 'value': value}) ??
        false;
  }

  @override
  Future<bool> putSharedPreferencesLong(String name, int value) async {
    return await methodChannel.invokeMethod<bool>(
        'putSharedPreferencesLong', {'name': name, 'value': value}) ??
        false;
  }

  @override
  Future<bool> putSharedPreferencesString(String name, String value) async {
    return await methodChannel.invokeMethod<bool>(
        'putSharedPreferencesString', {'name': name, 'value': value}) ??
        false;
  }

  @override
  Future<bool> isServiceRunning(String className) async {
    final isProvided = await methodChannel.invokeMethod<bool>(
        'isServiceRunning', {'serviceClassName': className});
    return isProvided ?? false;
  }

  @override
  Future<bool> isScreenAccessProvided() async {
    final isProvided =
    await methodChannel.invokeMethod<bool>('isScreenAccessProvided');
    return isProvided ?? false;
  }

  @override
  Future<bool> isNotificationListenerActive() async {
    final isActive =
    await methodChannel.invokeMethod<bool>('isNotificationListenerActive');
    return isActive ?? false;
  }

  @override
  Future<bool> requestScreenAccess() async {
    final isProvided =
    await methodChannel.invokeMethod<bool>('requestScreenAccess');
    return isProvided ?? false;
  }

  @override
  Future<bool> stopScreenAccess() async {
    final isProvided =
    await methodChannel.invokeMethod<bool>('stopScreenAccess');
    return isProvided ?? false;
  }

  @override
  Future<bool> startService(String className) async {
    final isProvided = await methodChannel
        .invokeMethod<bool>('startService', {'serviceClassName': className});
    return isProvided ?? false;
  }

  @override
  Future<bool> stopService(String className) async {
    final isStopped = await methodChannel
        .invokeMethod<bool>('stopService', {'serviceClassName': className});
    return isStopped ?? false;
  }

  @override
  Future<bool> test() async {
    final isProvided = await methodChannel.invokeMethod<bool>('test');
    return isProvided ?? false;
  }

  @override
  Future<List<dynamic>> getAvailableCameras() async {
    final availableCameras =
    await methodChannel.invokeMethod<String>('getAvailableCameras');
    if (availableCameras != null) {
      final result = json.decode(availableCameras);
      return result;
    }
    return [];
  }

  @override
  Future<String?> getAndroidId() async {
    final androidId = await methodChannel.invokeMethod<String>('getAndroidId');
    return androidId;
  }

  @override
  Future<String?> getDeviceOpenId() async {
    final deviceOpenId =
    await methodChannel.invokeMethod<String>('getDeviceOpenId');
    return deviceOpenId;
  }
}
