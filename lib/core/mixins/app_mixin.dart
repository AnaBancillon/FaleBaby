import 'package:fale_baby_app/core/navigate/app_navigate.dart';
import 'package:fale_baby_app/generated/l10n.dart';


mixin AppWidgetMixin {
  AppNavigate get navigator => AppNavigate.instance;

  S get translate => S.current;

  void dismissKeyboard() => navigator.dismissKeyboard();

// IPDAnalyticsManager get analytics => IPDAnalyticsManager();
// void trackEvent(String screenName, String event,
//         {Map<String, String>? parameters}) =>
//     analytics.track(screenName, event, parameters: parameters);
}
