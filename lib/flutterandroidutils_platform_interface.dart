import 'dart:ffi';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutterandroidutils_method_channel.dart';

abstract class FlutterandroidutilsPlatform extends PlatformInterface {
  /// Constructs a FlutterandroidutilsPlatform.
  FlutterandroidutilsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterandroidutilsPlatform _instance =
      MethodChannelFlutterandroidutils();

  /// The default instance of [FlutterandroidutilsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterandroidutils].
  static FlutterandroidutilsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterandroidutilsPlatform] when
  /// they register themselves.
  static set instance(FlutterandroidutilsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('getPlatformVersion() has not been implemented.');
  }

  Future<bool> isAccessibilityServiceProvided(String className) {
    throw UnimplementedError(
        'isAccessibilityServiceProvided() has not been implemented.');
  }

  Future<bool> isScreenAccessProvided() {
    throw UnimplementedError(
        'isScreenAccessProvided() has not been implemented.');
  }

  Future<bool> requestScreenAccess() {
    throw UnimplementedError(
        'isScreenAccessProvided() has not been implemented.');
  }

  Future<bool> test() {
    throw UnimplementedError(
        'isScreenAccessProvided() has not been implemented.');
  }

  Future<bool> startService(String className) {
    throw UnimplementedError('startService() has not been implemented.');
  }

  Future<bool> isServiceRunning(String className) {
    throw UnimplementedError(
        'isAccessibilityServiceProvided() has not been implemented.');
  }

  Future<bool> getSharedPreferencesBool(String name, bool defaultValue) {
    throw UnimplementedError(
        'getSharedPreferencesBool() has not been implemented.');
  }

  Future<int> getSharedPreferencesInt(String name, int defaultValue) async {
    throw UnimplementedError(
        'getSharedPreferencesInt() has not been implemented.');
  }

  Future<int> getSharedPreferencesLong(String name, int defaultValue) async {
    throw UnimplementedError(
        'getSharedPreferencesInt() has not been implemented.');
  }

  Future<String> getSharedPreferencesString(
      String name, String defaultValue) async {
    throw UnimplementedError(
        'getSharedPreferencesString() has not been implemented.');
  }

  Future<bool> putSharedPreferencesBool(String name, bool value) async {
    throw UnimplementedError(
        'putSharedPreferencesBool() has not been implemented.');
  }

  Future<bool> putSharedPreferencesInt(String name, int value) async {
    throw UnimplementedError(
        'putSharedPreferencesInt() has not been implemented.');
  }

  Future<bool> putSharedPreferencesLong(String name, int value) async {
    throw UnimplementedError(
        'putSharedPreferencesInt() has not been implemented.');
  }

  Future<bool> putSharedPreferencesString(String name, String value) async {
    throw UnimplementedError(
        'putSharedPreferencesString() has not been implemented.');
  }

  Future<bool> stopScreenAccess() async {
    throw UnimplementedError('stopScreenAccess() has not been implemented.');
  }

  Future<bool> stopService(String className) async {
    throw UnimplementedError('stopScreenAccess() has not been implemented.');
  }

  Future<List<dynamic>> getAvailableCameras() async {
    throw UnimplementedError('getAvailableCameras() has not been implemented.');
  }
}
