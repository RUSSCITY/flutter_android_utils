import 'dart:ffi';

import 'flutterandroidutils_platform_interface.dart';

class FlutterAndroidUtils {
  Future<String?> getPlatformVersion() {
    return FlutterandroidutilsPlatform.instance.getPlatformVersion();
  }

  Future<bool> isAccessibilityServiceProvided(String className) {
    return FlutterandroidutilsPlatform.instance
        .isAccessibilityServiceProvided(className);
  }

  Future<bool> isServiceRunning(String className) {
    return FlutterandroidutilsPlatform.instance.isServiceRunning(className);
  }

  Future<bool> getSharedPreferencesBool(String name, bool defaultValue) {
    return FlutterandroidutilsPlatform.instance
        .getSharedPreferencesBool(name, defaultValue);
  }

  Future<int> getSharedPreferencesInt(String name, int defaultValue) async {
    return FlutterandroidutilsPlatform.instance
        .getSharedPreferencesInt(name, defaultValue);
  }

  Future<bool> putSharedPreferencesBool(String name, bool value) async {
    return FlutterandroidutilsPlatform.instance
        .putSharedPreferencesBool(name, value);
  }

  Future<bool> putSharedPreferencesInt(String name, int value) async {
    return FlutterandroidutilsPlatform.instance
        .putSharedPreferencesInt(name, value);
  }

  Future<bool> putSharedPreferencesString(String name, String value) async {
    return FlutterandroidutilsPlatform.instance
        .putSharedPreferencesString(name, value);
  }

  Future<String> getSharedPreferencesString(
      String name, String defaultValue) async {
    return FlutterandroidutilsPlatform.instance
        .getSharedPreferencesString(name, defaultValue);
  }

  Future<bool> startService(String className) {
    return FlutterandroidutilsPlatform.instance.startService(className);
  }

  Future<bool> isScreenAccessProvided() {
    return FlutterandroidutilsPlatform.instance.isScreenAccessProvided();
  }

  Future<bool> requestScreenAccess() {
    return FlutterandroidutilsPlatform.instance.requestScreenAccess();
  }

  Future<bool> stopScreenAccess() {
    return FlutterandroidutilsPlatform.instance.stopScreenAccess();
  }

  Future<bool> test() {
    return FlutterandroidutilsPlatform.instance.test();
  }
}
