import 'package:flutter/material.dart';

typedef RouteEventFunc = void Function(Route? route, Route? previousRoute);
typedef RouteEventFuncOptional = void Function(
    Route route, Route? previousRoute);

class AppNavigatorObserver extends RouteObserver<PageRoute> {
  final RouteEventFuncOptional? onDidPush;
  final RouteEventFuncOptional? onDidPop;
  final RouteEventFunc? onDidReplace;

  AppNavigatorObserver({
    this.onDidPush,
    this.onDidPop,
    this.onDidReplace,
  });

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (onDidPush != null) {
      onDidPush!(route, previousRoute);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (onDidPop != null) {
      onDidPop!(route, previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (onDidReplace != null) {
      onDidReplace!(newRoute, oldRoute);
    }
  }
}
