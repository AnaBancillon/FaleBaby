part of 'app_navigate.dart';

class _AppNavigateImpl implements AppNavigate {
  @override
  final List<Route> stackOfViews = <Route>[];

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void init() {
    observer = AppNavigatorObserver(
      onDidPop: _onDidPop,
      onDidPush: _onDidPush,
      onDidReplace: _onDidReplace,
    );
  }

  @override
  void debugShowAppes() {
    if (stackOfViews.isEmpty) return;

    if (AppBase.instance.flavor == Flavor.development) {
      debugPrint('┌───────────────────────────────────────');

      debugPrint('| Stack of all living pages: ');

      for (var index = 0; index < stackOfViews.length; index++) {
        debugPrint(
          '| Widget: ${stackOfViews[index].settings.name ?? 'null'} order: $index',
        );
      }

      debugPrint('└───────────────────────────────────────');
    }
  }

  @override
  void _onDidPop(Route route, Route? previousRoute) {
    if (stackOfViews.isNotEmpty) {
      stackOfViews.removeLast();
    }
  }

  @override
  void _onDidPush(Route route, Route? previousRoute) {
    stackOfViews.add(route);
  }

  @override
  void _onDidReplace(Route? route, Route? previousRoute) {
    if (stackOfViews.isNotEmpty) {
      stackOfViews.removeLast();
      if (route != null) {
        stackOfViews.add(route);
      }
    }
  }

  @override
  void dismissKeyboard() {
    try {
      navigatorKey.currentState?.focusScopeNode.requestFocus(FocusNode());
    } catch (e) {
      AppLogger.error("_AppNavigateImpl", "dismissKeyboard", e);
    }
  }

  @override
  Future<dynamic> to({
    required Widget page,
    bool keepStateAlive = true,
    bool shouldDismissKeyboard = true,
    RouteAnimation animation = RouteAnimation.defaultOne,
  }) async {
    if (shouldDismissKeyboard) dismissKeyboard();

    final result = await navigatorKey.currentState?.push(
      NavigatorHelper.createRoute(
        page,
        keepStateAlive: keepStateAlive,
        animation: animation,
      ),
    );

    return result;
  }

  @override
  Future<dynamic> toNamed({
    required String routeName,
    Object? arguments,
  }) async {
    dismissKeyboard();
    final result = await navigatorKey.currentState?.pushNamed(
      routeName,
      arguments: arguments,
    );
    return result;
  }

  @override
  Future<dynamic> popAndToNamed({
    required String routeName,
    Object? arguments,
  }) async {
    dismissKeyboard();
    final result = await navigatorKey.currentState?.popAndPushNamed(
      routeName,
      arguments: arguments,
    );
    return result;
  }

  @override
  Future pushRoute<T>({
    required Route<T> route,
    bool keepStateAlive = true,
  }) async {
    return navigatorKey.currentState?.push(route);
  }

  @override
  Future pushReplacementRoute<T>({
    required Route<T> route,
    bool keepStateAlive = true,
  }) async {
    return navigatorKey.currentState?.pushReplacement(route);
  }

  @override
  void replaceWith({
    required Widget page,
  }) {
    navigatorKey.currentState?.pushReplacement(
      NavigatorHelper.createRoute(page),
    );
  }

  @override
  void pushAndClear({
    required Widget page,
    bool animateFromBottom = false,
  }) {
    navigatorKey.currentState?.pushAndRemoveUntil(
      animateFromBottom
          ? NavigatorHelper.createRouteAnimationFromBottom(page)
          : NavigatorHelper.createRoute(page),
      (route) => false,
    );
  }

  @override
  Future<void> pushNamedAndClear({
    required String routeName,
    bool animateFromBottom = false,
  }) async {
    await navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: animateFromBottom,
    );
  }

  @override
  Future<void> pushAndClearUntil({
    required Widget page,
    required bool Function(Route<dynamic>) predicate,
    RouteAnimation animation = RouteAnimation.defaultOne,
  }) async {
    await navigatorKey.currentState?.pushAndRemoveUntil(
      NavigatorHelper.createRoute(page, animation: animation),
      predicate,
    );
  }

  @override
  Future<void> pushNamedAndClearUntil({
    required String routeName,
    required bool Function(Route<dynamic>) predicate,
  }) async {
    await navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      predicate,
    );
  }

  @override
  void pop({result}) {
    if (stackOfViews.length == 1) {
      return;
    }
    navigatorKey.currentState?.pop(result);
  }

  @override
  void popUntil(bool Function(Route<dynamic>) predicate) {
    if (stackOfViews.length == 1) {
      return;
    }
    navigatorKey.currentState?.popUntil(predicate);
  }

  @override
  late AppNavigatorObserver observer;
}
