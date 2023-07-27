import 'package:fale_baby_app/core/app_logger.dart';
import 'package:fale_baby_app/managers/storage/storage_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../storage/storage_manager_impl.dart';
import 'injection_container.dart';

typedef InstanceInjection<T> = T Function();

enum InjectionType { factory, singleton, lazySingleton }

abstract class AppServiceLocator {
  /// Singleton declaration.
  static AppServiceLocator? _instance;

  factory AppServiceLocator() => instance;

  static AppServiceLocator get instance {
    _instance ??= _AppServiceLocatorImpl();
    return _instance!;
  }

  static AppServiceLocator get I => instance;

  Future<void> init();

  T get<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  });

  void resetLazySingleton<T extends Object>();

  Future<void> resetAll();
}

class _AppServiceLocatorImpl implements AppServiceLocator {
  final GetIt _serviceLocator = GetIt.I;

  final List<InjectionContainer> _injectionContainerList = [];

  @override
  Future<void> init() async {
    try {
      await _registerSingletons();
    } catch (e) {
      AppLogger.error("AppServiceLocator", "init", e);
    }
  }

  @override
  T get<T extends Object>({
    String? instanceName,
    dynamic param1,
    dynamic param2,
  }) {
    try {
      final T instance = _serviceLocator.get<T>(
        instanceName: instanceName,
        param1: param1,
        param2: param2,
      );
      return instance;
    } catch (e) {
      AppLogger.error('ServiceLocator', 'get', e, parameters: [T.toString()]);
      rethrow;
    }
  }

  @override
  void resetLazySingleton<T extends Object>() {
    try {
      if (_serviceLocator.isRegistered<T>()) {
        _serviceLocator.resetLazySingleton<T>();
      }
    } catch (e) {
      AppLogger.error("ServiceLocator", "resetSingleton", e,
          parameters: [T.toString()]);
    }
  }

  Future<void> _registerSingletons() async {
    await _registerServices();

    await _registerManagers();

    await _injectFeatures();
  }

  Future<void> _registerServices() async {}

  Future<void> _registerManagers() async {
    _serviceLocator.allowReassignment = true;
  }

  Future<void> _injectFeatures() async {
    _serviceLocator.registerSingleton<StorageManager>(
      StorageManagerImpl(
        storage: const FlutterSecureStorage(),
      ),
    );
  }

  @override
  Future<void> resetAll() async {
    await _serviceLocator.reset();
  }
}
