import 'package:flutter/material.dart';

class AppRouteObserver extends NavigatorObserver {
  static final AppRouteObserver instance = AppRouteObserver();

  String? currentRoute;
  String? previousRoute;
  bool lastNavigationWasPop = false;

  @override
  void didPush(Route route, Route? previousRoute) {
    this.previousRoute = previousRoute?.settings.name;
    lastNavigationWasPop = false;
    currentRoute = route.settings.name;
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    lastNavigationWasPop = true;
    currentRoute = previousRoute?.settings.name;
  }
}