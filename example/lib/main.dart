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

  // shared preferences
  int storedInt = 0;
  String storedString = "";
  bool storedBool = false;

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
    bool accesibilityProvided;
    bool isScreenAccessProvided;

    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterandroidutilsPlugin.getPlatformVersion() ??
          'Unknown platform version';
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

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _accessibilityProvided = accesibilityProvided;
      _isScreenAccessProvided = isScreenAccessProvided;
    });
  }

  Future<void> initStoredSharedPreferences() async {
    bool newStoredSharedBool = await FlutterAndroidUtils()
        .getSharedPreferencesBool("STORED_SHARED_BOOL", false);
    String newStoredSharedString = await FlutterAndroidUtils()
        .getSharedPreferencesString("STORED_SHARED_STRING", "NONE");
    int newStoredSharedInt = await FlutterAndroidUtils()
        .getSharedPreferencesInt("STORED_SHARED_INT", -1);

    setState(() {
      storedInt = newStoredSharedInt;
      storedString = newStoredSharedString;
      storedBool = newStoredSharedBool;
    });
  }

  Future<void> updateValues() async {
    bool newStoredSharedBool = await FlutterAndroidUtils()
        .getSharedPreferencesBool("STORED_SHARED_BOOL", false);
    String newStoredSharedString = await FlutterAndroidUtils()
        .getSharedPreferencesString("STORED_SHARED_STRING", "NONE");
    int newStoredSharedInt = await FlutterAndroidUtils()
        .getSharedPreferencesInt("STORED_SHARED_INT", -1);

    await FlutterAndroidUtils()
        .putSharedPreferencesBool("STORED_SHARED_BOOL", !newStoredSharedBool);
    await FlutterAndroidUtils().putSharedPreferencesString(
        "STORED_SHARED_STRING", "${newStoredSharedString}a");
    await FlutterAndroidUtils()
        .putSharedPreferencesInt("STORED_SHARED_INT", newStoredSharedInt + 1);

    initStoredSharedPreferences();
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
              TextButton(
                  onPressed: () async {
                    _flutterandroidutilsPlugin
                        .startService("city.russ.services.MainService");
                  },
                  child: Text("START MAIN SERVICE")),
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
                      "int: $storedInt, string: $storedString, bool: $storedBool")
                ],
              ),
              TextButton(
                  onPressed: () {
                    updateValues();
                  },
                  child: Text("Update values".toUpperCase()))
            ],
          ),
        ),
      ),
    );
  }
}
