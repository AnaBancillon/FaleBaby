import 'package:flutter/material.dart';
import 'package:fale_baby_app/utils/key_utils.dart';

abstract class AppStateFulWidget extends StatefulWidget {
  AppStateFulWidget({
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
