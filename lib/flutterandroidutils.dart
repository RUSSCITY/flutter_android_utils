
import 'flutterandroidutils_platform_interface.dart';

class Flutterandroidutils {
  Future<String?> getPlatformVersion() {
    return FlutterandroidutilsPlatform.instance.getPlatformVersion();
  }

  Future<bool> isAccessibilityServiceProvided(String className){
    return FlutterandroidutilsPlatform.instance.isAccessibilityServiceProvided(className);
  }

  Future<bool> isServiceRunning(String className){
    return FlutterandroidutilsPlatform.instance.isServiceRunning(className);
  }

  Future<bool> startService(String className){
    return FlutterandroidutilsPlatform.instance.startService(className);
  }

  Future<bool> isScreenAccessProvided(){
    return FlutterandroidutilsPlatform.instance.isScreenAccessProvided();
  }

  Future<bool> requestScreenAccess(){
    return FlutterandroidutilsPlatform.instance.requestScreenAccess();
  }

  Future<bool> test(){
    return FlutterandroidutilsPlatform.instance.test();
  }
}
