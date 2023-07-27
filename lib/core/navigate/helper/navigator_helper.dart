import 'package:flutter/material.dart';

enum RouteAnimation {
  defaultOne,
  fromBottom,
  fade,
}

class NavigatorHelper {
  static RouteSettings createSettings(Widget page) {
    return RouteSettings(name: page.toStringShort());
  }

  static Route createRoute(
    Widget page, {
    bool keepStateAlive = true,
    RouteSettings? settings,
    RouteAnimation animation = RouteAnimation.defaultOne,
  }) {
    switch (animation) {
      case RouteAnimation.defaultOne:
        return MaterialPageRoute(
            settings: settings ?? createSettings(page),
            maintainState: keepStateAlive,
            builder: (_) {
              return page;
            });
      case RouteAnimation.fromBottom:
        return createRouteAnimationFromBottom(
          page,
          keepStateAlive: keepStateAlive,
          settings: settings,
        );

      case RouteAnimation.fade:
        return createRouteAnimationFade(
          page,
          keepStateAlive: keepStateAlive,
          settings: settings,
        );
    }
  }

  static Route createRouteAnimationFromBottom(
    Widget page, {
    bool keepStateAlive = true,
    RouteSettings? settings,
  }) {
    return PageRouteBuilder(
      settings: settings ?? createSettings(page),
      maintainState: keepStateAlive,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Route createRouteAnimationFade(
    Widget page, {
    bool keepStateAlive = true,
    RouteSettings? settings,
  }) {
    return PageRouteBuilder(
      settings: settings ?? createSettings(page),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
