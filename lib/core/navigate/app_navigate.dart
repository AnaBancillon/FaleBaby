import 'package:flutter/material.dart';
import 'package:fale_baby_app/core/base/app_base.dart';
import 'package:fale_baby_app/core/navigate/observer/app_navigator_observer.dart';
import 'package:fale_baby_app/core/app_logger.dart';

import 'helper/navigator_helper.dart';

part 'app_navigate_impl.dart';

abstract class AppNavigate {
  /// Singleton declaration
  static AppNavigate? _instance;

  @Deprecated('use the instance getter instead')
  factory AppNavigate() => instance;

  /// access to the Singleton instance of IPDNavigate.
  static AppNavigate get instance {
    _instance ??= _AppNavigateImpl();
    return _instance!;
  }

  /// Short version.
  static AppNavigate get I => instance;

  /// Retrieve a brand new instance of IPDNavigate.
  factory AppNavigate.newInstance() {
    return _AppNavigateImpl();
  }

  /// Instance of [IPDNavigatorObserver]
  ///
  /// Listen to route changes as pop and push.
  /// mainly used to maintain the [stackOfViews] updated
  late AppNavigatorObserver observer;

  /// init the [AppNavigate].
  ///
  /// start the [observer].
  /// must be initialized before the [runApp]
  void init();

  /// Listen the pop of a route.
  void _onDidPop(Route route, Route? previousRoute);

  /// Listen to when a route is pushed.
  void _onDidPush(Route route, Route? previousRoute);

  /// Listen to the replacement of routes.
  void _onDidReplace(Route? route, Route? previousRoute);

  /// Shows the routes in [stackOfViews].
  void debugShowAppes();

  /// Store the living routes in the app.
  abstract final List<Route> stackOfViews;

  /// Holds the [NavigatorState] key.
  ///
  /// The core to [AppNavigate] since it will
  /// manage all the route transitions and provide
  /// the context.
  abstract final GlobalKey<NavigatorState> navigatorKey;

  /// request a new focus resulting in the dismiss of the keyboard.
  void dismissKeyboard() {
    try {
      navigatorKey.currentState?.focusScopeNode.requestFocus(FocusNode());
    } catch (e) {
      // IPDLogger.error('IPDNavigate', 'dismissKeyboard', e);
    }
  }

  /// Navigates to the given page.
  ///
  /// it can be used to retrieve a result from
  /// another page
  /// egg.:
  /// ```dart
  ///   var result = await IPDNavigate.
  ///                         instance.
  ///                         to(page: MyAppe());
  ///                         use IPDNavigate.instance.pop(result: "result");
  ///   print(result);
  /// ```
  Future<dynamic> to({
    required Widget page,
    bool keepStateAlive = true,
    bool shouldDismissKeyboard = true,
    RouteAnimation animation = RouteAnimation.defaultOne,
  });

  /// Navigates to the given route name
  Future<dynamic> toNamed({
    required String routeName,
    Object? arguments,
  });

  /// Pops the page and navigates to the given route name
  Future<dynamic> popAndToNamed({
    required String routeName,
    Object? arguments,
  });

  /// Push using custom route
  ///
  /// it can be used if you want custom animation transition between pages
  Future<dynamic> pushRoute<T>({
    required Route<T> route,
    bool keepStateAlive = true,
  });

  /// PushReplacement using custom route
  ///
  /// it can be used if you want custom animation transition between pages
  Future<dynamic> pushReplacementRoute<T>({
    required Route<T> route,
    bool keepStateAlive = true,
  });

  /// Replaces the current page with the given one.
  void replaceWith({
    required Widget page,
  });

  /// push a new push and clear all the history.
  void pushAndClear({
    required Widget page,
    bool animateFromBottom = false,
  });

  /// push a new route and clear all the history until the predicate is satisfied.
  Future<void> pushAndClearUntil({
    required Widget page,
    required bool Function(Route<dynamic>) predicate,
    RouteAnimation animation = RouteAnimation.defaultOne,
  });

  /// push a new named route and clear all the history.
  /// you can also pass a [animateFromBottom] which brings the animation from the bottom if it's true
  Future<void> pushNamedAndClear({
    required String routeName,
    bool animateFromBottom = false,
  });

  /// push a new named route and clear all the history until the predicate is satisfied.
  Future<void> pushNamedAndClearUntil({
    required String routeName,
    required bool Function(Route<dynamic>) predicate,
  });

  /// pop the current page.
  void pop({result});

  // pop until the predicate is satisfied
  void popUntil(bool Function(Route<dynamic>) predicate);
}
