import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutterandroidutils_method_channel.dart';

abstract class FlutterandroidutilsPlatform extends PlatformInterface {
  /// Constructs a FlutterandroidutilsPlatform.
  FlutterandroidutilsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterandroidutilsPlatform _instance = MethodChannelFlutterandroidutils();

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
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> isAccessibilityServiceProvided(String className){
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
