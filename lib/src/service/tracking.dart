import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class Tracking {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  Tracking() {
    init();
  }

  Future<void> init({bool analyticsStorageConsentGranted = true}) async {
    await _analytics.setDefaultEventParameters({'version': '0.1.0'});
    await _crashlytics.setCustomKey('version', '0.1.0');
    await _analytics.setSessionTimeoutDuration(const Duration(minutes: 1));
    await _analytics.setConsent(
        adStorageConsentGranted: false,
        analyticsStorageConsentGranted: analyticsStorageConsentGranted);
  }

  void logEvent(String name) async {
    _analytics.logEvent(name: name);
    _analytics.logEvent(name: name);
  }

  void logEventVariant(String name, String variant) async {
    _analytics.logEvent(name: name, parameters: {'variant': variant});
  }

  void setCurrentScreen(String screenName) async {
    _analytics.setCurrentScreen(screenName: screenName);
  }

  void logError(
      dynamic exception, String reason, StackTrace? stackTrace) async {
    await _crashlytics.recordError(
      exception,
      stackTrace,
      reason: reason,
    );
  }
}
