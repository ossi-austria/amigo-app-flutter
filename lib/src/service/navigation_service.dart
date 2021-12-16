import 'package:flutter/material.dart';

class NavigationService {
  NavigationService(this.navigatorKey);

  final GlobalKey<NavigatorState> navigatorKey;

  Future<dynamic> navigateTo(String routeName,
      {bool removeAllRoutes = false, Object? arguments}) {
    if (removeAllRoutes) {
      return navigatorKey.currentState!.pushNamedAndRemoveUntil(
          routeName, (_) => false,
          arguments: arguments);
    } else {
      return navigatorKey.currentState!
          .pushNamed(routeName, arguments: arguments);
    }
  }

  void navigateBack() {
    navigatorKey.currentState!.pop();
  }
}
