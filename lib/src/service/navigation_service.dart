import 'package:flutter/material.dart';

class NavigationService {
  NavigationService(this.navigatorKey);

  final GlobalKey<NavigatorState> navigatorKey;

  Future<dynamic> navigateTo(String routeName, {bool removeAllRoutes = false}) {
    if (removeAllRoutes) {
      return navigatorKey.currentState!
          .pushNamedAndRemoveUntil(routeName, (_) => false);
    } else {
      return navigatorKey.currentState!.pushNamed(routeName);
    }
  }
}
