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

  final _flutterandroidutilsPlugin = Flutterandroidutils();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initPlatformState();
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
              Text(
                  'Is Accessibility Service Provided: $_accessibilityProvided'),
              Text('Is Screen access provided: $_isScreenAccessProvided'),
              TextButton(
                  onPressed: () async {
                    _flutterandroidutilsPlugin.requestScreenAccess();
                  },
                  child: Text("REQUEST SCREEN ACCESS")),
            ],
          ),
        ),
      ),
    );
  }
}
