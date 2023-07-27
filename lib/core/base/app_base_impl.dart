part of 'app_base.dart';

class _AppBaseImpl implements AppBase {
  /// Controls some sort of debug actions in the app.
  ///
  /// Egg.: It controls if we can click on the drawer items [RegisterDrawerWidget]
  /// to go to the specified page.
  /// ToDo: Toggle it to [Flavor.production] to generate a release version
  @override
  Flavor? flavor = Flavor.production;

  @override
  bool get isProduction => flavor == Flavor.production;

  @override
  bool get isStaging => flavor == Flavor.development;

  /// Forces the log to show.
  @override
  bool forceLog = false;

  /// Init the basic process of the app.
  ///
  /// Should be called before the [runApp] call.
  @override
  Future<void> init(Flavor env, {bool forceLog = false}) async {
    flavor = env;
    this.forceLog = forceLog;

    Intl.defaultLocale =
        (Intl.defaultLocale == 'pt_BR') ? Intl.defaultLocale : 'en';

    // await FirebaseManager().init();
    // HttpClient.enableTimelineLogging = (flavor == Flavor.development);
    AppNavigate.instance.init();
    await AppServiceLocator.I.init();
  }
}
