// created by: FAMZY CodeWorks
import 'package:flutter/material.dart';
import 'package:rehan_trader_website/core/services/navigation_service.dart';

class AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    NavigationService().updateRouteName(route.settings.name);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    NavigationService().updateRouteName(previousRoute?.settings.name);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    NavigationService().updateRouteName(newRoute?.settings.name);
  }
}
