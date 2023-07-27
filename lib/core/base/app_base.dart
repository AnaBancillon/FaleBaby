import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fale_baby_app/core/navigate/app_navigate.dart';
import 'package:fale_baby_app/managers/service_locator/app_service_locator_manager.dart';

part 'app_base_impl.dart';

abstract class AppBase {
  /// Singleton declaration.
  static AppBase? _instance;

  /// Old way to declare the [AppBase].
  @Deprecated('use the getter instance instead')
  factory AppBase() => instance;

  /// Retrieves the singleton [_instance].
  static AppBase get instance {
    _instance ??= _AppBaseImpl();
    return _instance!;
  }

  /// Short version of [instance].
  static AppBase get I {
    _instance ??= _AppBaseImpl();
    return _instance!;
  }

  /// Retrieve a brand new instance of IPDBase.
  factory AppBase.newInstance() {
    return _AppBaseImpl();
  }

  /// Controls some sort of debug actions in the app.
  ///
  /// Ex.: It controls if we can click on the drawer items [RegisterDrawerWidget]
  /// to go to the specified page.
  /// ToDo: Toggle it to [Flavor.production] to generate a release version
  Flavor? flavor;

  /// Forces the log to show.
  bool forceLog = false;

  /// Init the basic process of the app.
  ///
  /// Should be called before the [runApp] call.
  Future<void> init(Flavor env, {bool forceLog});

  bool get isProduction;
  bool get isStaging;
}

/// controls the env. of the app.
enum Flavor { development, production, qa }
