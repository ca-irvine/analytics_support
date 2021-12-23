import 'dart:io';

import 'package:flutter/services.dart';

enum _AnalyticsSupportMethod {
  getGoogleClientId,
  showConsoleLog,
}

extension on _AnalyticsSupportMethod {
  String get value => toString().split('.')[1];
}

class AnalyticsSupport {
  AnalyticsSupport({
    required this.gaTrackingId,
  });

  static const _trackerChannel = MethodChannel('com.cairvine.analytics_support/tracker');

  final String gaTrackingId;
  String? _clientId;

  Future<String?> get clientId async {
    return _clientId ??= await _trackerChannel.invokeMethod(
      _AnalyticsSupportMethod.getGoogleClientId.value,
      gaTrackingId,
    );
  }

  Future<void> startIosLogging() => _iOSConsoleLog(isShow: true);

  Future<void> stopIosLogging() => _iOSConsoleLog(isShow: false);

  Future<void> _iOSConsoleLog({required bool isShow}) {
    return Platform.isIOS
        ? _trackerChannel.invokeMethod(
            _AnalyticsSupportMethod.showConsoleLog.value,
            isShow,
          )
        : Future.value();
  }
}
