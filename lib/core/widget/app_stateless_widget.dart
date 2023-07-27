import 'package:flutter/material.dart';
import 'package:fale_baby_app/core/mixins/app_mixin.dart';
import 'package:fale_baby_app/utils/key_utils.dart';

abstract class AppStatelessWidget extends StatelessWidget
    with AppWidgetMixin {
  AppStatelessWidget({
    Key? key,
    required String className,
    String? widgetName,
    int? id,
  }) : super(
          key: key ??
              KeyUtils.generateKey(
                className: className,
                widgetName: widgetName,
                id: id,
              ),
        );
}
