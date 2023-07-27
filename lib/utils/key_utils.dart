import 'package:flutter/material.dart';

abstract class KeyUtils {
  static Key generateKey({
    required String className,
    String? widgetName,
    int? id,
  }) {
    String stringKey = className;
    if (widgetName?.isNotEmpty == true) {
      stringKey += '-$widgetName';
    }

    if (id != null) {
      stringKey += '-${id.toString()}';
    }
    return Key(stringKey);
  }
}
