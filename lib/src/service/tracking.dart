import 'package:amigoapp/main.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../utils/logger.dart';

class Tracking {

  late FirebaseAnalytics _analytics;
  late FirebaseCrashlytics _crashlytics;

  final _log = getLogger();

  var _enabled = false;

  Future<void> init() async {
    if (!_enabled) {
      _log.i('init Tracking');
      _analytics = FirebaseAnalytics.instance;
      _crashlytics = FirebaseCrashlytics.instance;
    }
    _enabled = true;
    await _analytics.setDefaultEventParameters({'version': '0.1.0'});
    await _crashlytics.setCustomKey('version', '0.1.0');
    await _analytics.setSessionTimeoutDuration(const Duration(minutes: 1));
    await _analytics.setConsent(
        adStorageConsentGranted: false, analyticsStorageConsentGranted: true);
  }

  void logEvent(String name) async {
    if (!_enabled) return;
    _log.i('logEvent: $name');
    _analytics.logEvent(name: name);
  }

  void logEventVariant(String name, String variant) async {
    if (!_enabled) return;
    _log.i('logEvent: $name: $variant');
    _analytics.logEvent(name: name, parameters: {'variant': variant});
  }

  void setCurrentScreen(String screenName) async {
    if (!_enabled) return;
    _log.i('setCurrentScreen: $screenName');
    _analytics.setCurrentScreen(screenName: screenName);
  }

  void logError(
      dynamic exception, String reason, StackTrace? stackTrace) async {
    if (!_enabled) return;
    await _crashlytics.recordError(
      exception,
      stackTrace,
      reason: reason,
    );
  }
}
