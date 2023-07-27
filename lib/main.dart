import 'dart:async';

import 'package:fale_baby_app/core/app_logger.dart';
import 'package:fale_baby_app/core/base/app_base.dart';
import 'package:fale_baby_app/core/mixins/app_mixin.dart';
import 'package:fale_baby_app/core/navigate/helper/navigator_helper.dart';
import 'package:fale_baby_app/features/home/src/presentation/pages/home_page.dart';
import 'package:fale_baby_app/features/questions/question.dart';
import 'package:fale_baby_app/features/splash/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';

Future<void> main() async {
  // const flavorToEnv = {
  //   "staging": Flavor.development,
  //   "prod": Flavor.production,
  //   "qa": Flavor.qa,
  // };
  //
  // const flavor = String.fromEnvironment('flavor');
  // const forceLog = String.fromEnvironment(
  //       'forceLog',
  //       defaultValue: "false",
  //     ) ==
  //     "true";

  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await AppBase.I.init(
        Flavor.development,
        forceLog: true,
      );
      FlutterError.onError = _onFlutterError;

      AppLogger.info(
        'Environment initialized: develop ${true ? 'with log forced' : ''}',
      );
      runApp(const PagFlexApp());
      FlutterError.onError = _onFlutterError;
    },
    (exception, stackTrace) {
      if (AppBase.instance.flavor == Flavor.development) {
        AppLogger.error('Initializing app', 'runZonedGuarded', exception);
      } else if (shouldReportException(exception)) {
        // SentryManager.I.captureException(
        //   exception,
        //   stackTrace: stackTrace,
        // );
      }
    },
  );
}

bool shouldReportException(dynamic exception) {
  // if (exception is RPCError) {
  //   return (exception.errorCode != -32603);
  // }

  return true;
}

void _onFlutterError(FlutterErrorDetails details) {
  if (kDebugMode) {
    FlutterError.presentError(details);
  }

  if (AppBase.instance.flavor == Flavor.development) {
    // FirebaseCrashlytics.instance.recordFlutterError(details);
  } else {
    // SentryManager.I.captureException(
    //   details.exceptionAsString(),
    //   stackTrace: details.stack,
    // );
  }
}

class PagFlexApp extends StatelessWidget with AppWidgetMixin {
  const PagFlexApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      navigatorKey: navigator.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Fale Baby',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Color(0xff212121),
            // fontFamily: fonts.ceraproMedium,
            fontSize: 18,
          ),
        ),
      ),
      supportedLocales: S.delegate.supportedLocales,
      navigatorObservers: [
        navigator.observer,
        // FirebaseAnalyticsObserver(
        //   analytics: IPDAnalyticsManager().getAnalytics(),
        // )
      ],
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      onGenerateRoute: _onGenerateRoute,
      builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Stack(
            children: [
              widget ?? const SizedBox.shrink(),
            ],
          ),
        );
      },
      home: SplashScreen(),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;

    if (settings.name == Home.name) {
      page = Home();
      return NavigatorHelper.createRouteAnimationFade(
        page,
        settings: settings,
      );
    }

    if (settings.name == QuestionsPage.name) {
      page = QuestionsPage();
      return NavigatorHelper.createRouteAnimationFade(
        page,
        settings: settings,
      );
    }

    return NavigatorHelper.createRoute(Container(), settings: settings);
  }
}
