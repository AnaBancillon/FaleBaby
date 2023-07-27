import 'package:fale_baby_app/core/mixins/app_mixin.dart';
import 'package:fale_baby_app/core/widget/app_stateful_widget.dart';
import 'package:fale_baby_app/features/home/src/presentation/pages/home_page.dart';
import 'package:fale_baby_app/utils/responsive_utils.dart';
import 'package:fale_baby_design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SplashScreen extends AppStateFulWidget {
  static const name = '/';

  SplashScreen({
    Key? key,
    String? widgetName,
    int? id,
  }) : super(
          key: key,
          className: name,
          id: id,
          widgetName: widgetName,
        );

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with AppWidgetMixin {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      navigator.pushNamedAndClear(routeName: Home.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveUtils.I.init(context);
    return Scaffold(
      backgroundColor: kColorBlue80,
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/images/splash-background.png'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/splash-logo.png',
            ),
          ],
        ),
      ),
    );
  }
}
