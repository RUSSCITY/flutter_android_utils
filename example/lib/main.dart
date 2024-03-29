import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutterandroidutils/flutterandroidutils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  String _platformVersion = 'Unknown';
  bool? _accessibilityProvided;
  bool? _isScreenAccessProvided;
  bool? _notificationListenerEnabled;
  String? _deviceOpenId;

  // shared preferences
  int storedInt = 0;
  String storedString = "";
  bool storedBool = false;
  int storedLong = 0;

  // camera
  List<dynamic>? availableCameras;

  // channels
  String? callbackFromAndroid;
  String? _androidId;

  final _flutterandroidutilsPlugin = FlutterAndroidUtils();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initPlatformState();
    initStoredSharedPreferences();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      initPlatformState();
    }
  }

  Future sleep(int milliseconds) {
    return Future.delayed(Duration(milliseconds: milliseconds), () => "1");
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    String? androidId;
    String? deviceOpenId;
    bool accesibilityProvided;
    bool isScreenAccessProvided;
    bool isNotificationListenerEnabled;

    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterandroidutilsPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    try {
      deviceOpenId = await _flutterandroidutilsPlugin.getDeviceOpenId() ??
          'Unknown device open id';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    try {
      accesibilityProvided =
          await _flutterandroidutilsPlugin.isAccessibilityServiceProvided(
              "software.ragimov.flutterandroidutils_example.MainActivity");
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
      accesibilityProvided = false;
    }

    try {
      isScreenAccessProvided =
          await _flutterandroidutilsPlugin.isScreenAccessProvided();
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
      isScreenAccessProvided = false;
    }

    try {
      isNotificationListenerEnabled =
          await _flutterandroidutilsPlugin.isNotificationListenerActive();
    } catch (e) {
      isNotificationListenerEnabled = false;
    }

    try {
      androidId = await _flutterandroidutilsPlugin.getAndroidId();
    } catch (e) {}

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _accessibilityProvided = accesibilityProvided;
      _isScreenAccessProvided = isScreenAccessProvided;
      _notificationListenerEnabled = isNotificationListenerEnabled;
      _androidId = androidId;
      _deviceOpenId = deviceOpenId;
    });
  }

  Future<void> initStoredSharedPreferences() async {
    bool newStoredSharedBool = await FlutterAndroidUtils()
        .getSharedPreferencesBool("STORED_SHARED_BOOL", false);
    String newStoredSharedString = await FlutterAndroidUtils()
        .getSharedPreferencesString("STORED_SHARED_STRING", "NONE");
    int newStoredSharedInt = await FlutterAndroidUtils()
        .getSharedPreferencesInt("STORED_SHARED_INT", -1);
    int newStoredSharedLong = await FlutterAndroidUtils()
        .getSharedPreferencesLong("STORED_SHARED_LONG", -1);
    setState(() {
      storedInt = newStoredSharedInt;
      storedString = newStoredSharedString;
      storedBool = newStoredSharedBool;
      storedLong = newStoredSharedLong;
    });
  }

  Future<void> updateValues() async {
    bool newStoredSharedBool = await FlutterAndroidUtils()
        .getSharedPreferencesBool("STORED_SHARED_BOOL", false);
    String newStoredSharedString = await FlutterAndroidUtils()
        .getSharedPreferencesString("STORED_SHARED_STRING", "NONE");
    int newStoredSharedInt = await FlutterAndroidUtils()
        .getSharedPreferencesInt("STORED_SHARED_INT", -1);
    int newStoredSharedLong = await FlutterAndroidUtils()
        .getSharedPreferencesLong("STORED_SHARED_LONG", -1);

    await FlutterAndroidUtils()
        .putSharedPreferencesBool("STORED_SHARED_BOOL", !newStoredSharedBool);
    await FlutterAndroidUtils().putSharedPreferencesString(
        "STORED_SHARED_STRING", "${newStoredSharedString}a");
    await FlutterAndroidUtils()
        .putSharedPreferencesInt("STORED_SHARED_INT", newStoredSharedInt + 1);
    await FlutterAndroidUtils().putSharedPreferencesLong(
        "STORED_SHARED_LONG", newStoredSharedLong + 1);

    initStoredSharedPreferences();
  }

  Future<void> getAvailableCameras() async {
    setState(() {
      availableCameras = null;
    });
    final newAvailableCameras =
        await FlutterAndroidUtils().getAvailableCameras();
    setState(() {
      availableCameras = newAvailableCameras;
    });
  }

  Future<void> sendBroadCastToAndroid() async {
    FlutterAndroidUtils().setCallBackListener((data) {
      setState(() {
        callbackFromAndroid = data;
      });
    });
    FlutterAndroidUtils().sendBroadCast(jsonEncode({"action": "showTime"}));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Running on: $_platformVersion\n'),
              Text('Android ID: $_androidId\n'),
              Text('Device Open Id: $_deviceOpenId\n'),
              Text(
                  'Notification Listener Service Enabled: $_notificationListenerEnabled\n'),
              TextButton(
                  onPressed: () async {
                    _flutterandroidutilsPlugin.openAccessibilityServiceSettings(
                        "city.russ.services.MyAccessibilityService");
                  },
                  child: Text("OPEN ACCESSIBILIY SERVICE SETTINGS")),
              TextButton(
                  onPressed: () async {
                    _flutterandroidutilsPlugin
                        .startService("city.russ.services.MainService");
                  },
                  child: Text("START MAIN SERVICE")),
              TextButton(
                  onPressed: () async {
                    _flutterandroidutilsPlugin
                        .stopService("city.russ.services.MainService");
                  },
                  child: Text("STOP MAIN SERVICE")),
              Text(
                  'Is Accessibility Service Provided: $_accessibilityProvided'),
              Text('Is Screen access provided: $_isScreenAccessProvided'),
              TextButton(
                  onPressed: () async {
                    _flutterandroidutilsPlugin.requestScreenAccess();
                  },
                  child: Text("REQUEST SCREEN ACCESS")),
              _isScreenAccessProvided == true
                  ? TextButton(
                      onPressed: () async {
                        _flutterandroidutilsPlugin.stopScreenAccess();
                      },
                      child: Text("STOP SCREEN ACCESS"))
                  : Container(),
              const Text("Checking shared preferences:"),
              Wrap(
                children: [
                  Text(
                      "int: $storedInt, string: $storedString, bool: $storedBool, long: $storedLong")
                ],
              ),
              TextButton(
                  onPressed: () {
                    updateValues();
                  },
                  child: Text("Update values".toUpperCase())),
              availableCameras != null
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black26)),
                      child: Text(jsonEncode(availableCameras!)),
                    )
                  : Container(),
              TextButton(
                  onPressed: () {
                    getAvailableCameras();
                  },
                  child: Text("Get available cameras".toUpperCase())),
              const SizedBox(
                height: 12,
              ),
              callbackFromAndroid != null
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black26)),
                      child: Text(callbackFromAndroid!),
                    )
                  : Container(),
              const SizedBox(
                height: 12,
              ),
              TextButton(
                  onPressed: () {
                    sendBroadCastToAndroid();
                  },
                  child: Text("Send broadcast to Android".toUpperCase()))
            ],
          ),
        ),
      ),
    );
  }
}
