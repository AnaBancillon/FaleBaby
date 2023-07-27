import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fale_baby_app/core/base/app_base.dart';


/// Logs the necessary info into the console.
///
/// With better logs, the >>>developer<<< can
/// understand the problem faster and then
/// fix it faster.
///
/// All of these methods will only work on
/// [IPDBase.instance.flavor] equal to
/// [Flavor.development]
class AppLogger {

  static bool _shouldShowLog() {
    return AppBase.I.flavor == Flavor.development || AppBase.I.forceLog;
  }

  /// Log simple information to the developer.
  ///
  /// It should be used as a temporary info that
  /// will be deleted at the end of the feat creation.
  ///
  /// GOOD
  /// ```dart
  ///   IPDLogger.info("Downloading file, current progress: $progress");
  /// ```
  ///
  /// BAD
  /// ```dart
  ///   IPDLogger.info("success, the code got here");
  /// ```
  static void info(dynamic message, {bool asJson = false}) {
    if (_shouldShowLog()) {
      debugPrint('┌────────────  AppInfoLog ℹ️ ─────────');
      debugPrint('│ 💡           Hello, dev!           💡');
      debugPrint('├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄');
      if (asJson && message is Map) {
        for (var mapEntry in message.entries) {
          debugPrint("| ${mapEntry.key}: ${mapEntry.value}");
        }
      } else {
        if (message == null) {
          message = "Message is null";
        } else if (message.toString().isEmpty) {
          message = "Message is empty";
        }
      }

      debugPrint('│ $message');
      debugPrint('└─────────────────────────────────────');
    }
  }

  /// Log debug info to the developer.
  ///
  /// Accepts a list of parameters so it can be used to
  /// show values without entering into IDE's debug mode.
  static void debug({
    String? message,
    String? where,
    String? function,
    List<dynamic> parameters = const [],
  }) {
    if (_shouldShowLog()) {
      debugPrint('┌──────────── AppDebugLog 🐛 ──────────');
      debugPrint('│ 👾           Hello, dev!           👾');
      debugPrint('│ 👾       lets kill some bugs       👾');

      if (message != null && message.isNotEmpty) {
        debugPrint('├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄');
        debugPrint('│ Message: $message');
      }

      if (where != null && where.isNotEmpty) {
        debugPrint('├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄');
        debugPrint('│ Where: $where');
      }

      if (function != null && function.isNotEmpty) {
        debugPrint('├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄');
        debugPrint('│ Function: $function');
      }

      if (parameters != null && parameters.isNotEmpty) {
        debugPrint('├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄');
        debugPrint('│ Parameters:');
        for (var parameter in parameters) {
          debugPrint('│ $parameter');
        }
      }

      debugPrint('└─────────────────────────────────────');
    }
  }

  /// Provide info about an exception in the project.
  ///
  /// If the dangerous log is seem, it means that something
  /// really bad happened some[where] in the project and must
  /// be fixed as fast as possible.
  ///
  /// if the normal error log has been seen, it doesnt mean
  /// that it is the end of the world, but you should be aware
  /// of it.
  static void error(String where, String function, exception,
      {List<dynamic> parameters = const [], bool isDangerous = false}) {
    if (_shouldShowLog()) {
      debugPrint('┌─────────── AppExceptionLog ────────');
      if (isDangerous) {
        debugPrint('│ ⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔');
        debugPrint('│ Hello, dev. There was a DANGEROUS ');
        debugPrint('│ exception. Take care of it ASAP   ');
        debugPrint('│ ⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔⛔');
      } else {
        debugPrint('│ ⛔ Hello, dev. There was an error ⛔');
      }
      debugPrint('├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄ ');
      debugPrint('│ Where: $where');
      debugPrint('├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄');
      debugPrint('│ Function: $function');
      debugPrint('├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄');
      debugPrint('│ $exception');
      if (parameters != null && parameters.isNotEmpty) {
        debugPrint('├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄');
        debugPrint('│ Parameters:');
        for (var parameter in parameters) {
          debugPrint('│ ${parameter.runtimeType}: $parameter');
        }
      }
      debugPrint('└────────────────────────────────────');
    }
  }

  static void apiError(Response response, RequestOptions requestOptions) {
    if (!_shouldShowLog()) return;

    final baseUrl = requestOptions?.baseUrl;
    final path = requestOptions?.path;
    final method = requestOptions?.method;
    final body = requestOptions.data;

    final statusCode = response?.statusCode;
    final message = response?.statusMessage;
    final data = response?.data;

    debugPrint('┌─────────────── AppApiErrorLog ──────────────');
    debugPrint('│ ⛔🌐 Hello, dev. There was an api error 🌐⛔');
    debugPrint('├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄');
    debugPrint('├ Request');
    debugPrint('│ Base url: $baseUrl');
    debugPrint('│ Path: $path');
    debugPrint('│ Method: $method');
    debugPrint('│ Body: $body');
    debugPrint('├┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄┄');
    debugPrint('├ Response');
    debugPrint('│ Status code: $statusCode');
    debugPrint('│ Message: $message');
    debugPrint('│ Data: $data');
    debugPrint('└─────────────────────────────────────────────');
  }
}
