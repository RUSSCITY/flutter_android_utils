
import 'flutterandroidutils_platform_interface.dart';

class Flutterandroidutils {
  Future<String?> getPlatformVersion() {
    return FlutterandroidutilsPlatform.instance.getPlatformVersion();
  }

  Future<bool> isAccessibilityServiceProvided(String className){
    return FlutterandroidutilsPlatform.instance.isAccessibilityServiceProvided(className);
  }
}
