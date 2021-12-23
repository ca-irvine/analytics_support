import 'package:analytics_support/analytics_support.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _clientId = 'Unknown';
  static const _yourTrackingId = 'YOUR_TRACKING_ID';

  @override
  void initState() {
    super.initState();
    initClientId();
  }

  Future<void> initClientId() async {
    String clientId;
    try {
      clientId = await AnalyticsSupport(gaTrackingId: _yourTrackingId).clientId ??
          'Unknown platform version';
    } on PlatformException {
      clientId = 'Failed to get client id.';
    }

    if (mounted) {
      setState(() {
        _clientId = clientId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Client ID: $_clientId\n'),
        ),
      ),
    );
  }
}
