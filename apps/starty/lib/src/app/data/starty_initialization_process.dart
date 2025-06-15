import 'package:app_shared/initialization.dart';
import 'package:app_shared/settings.dart';
import 'package:app_shared/utils.dart' as utils;
import 'package:flutter/foundation.dart';
import 'package:l/l.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starty/src/_internal/constant/constant.dart';
import 'package:starty/src/app/data/model/app_dependencies.dart';
import 'package:starty/src/app/data/model/dependencies.dart';

final InitializationProcess<Dependencies> initializationProcesss = {
  //* --- Misc --- *//
  if (kDebugMode)
    'Log debug info': (_) => l.i('''Building Application with:
    env: ${AppConfig.env.name}
 flavor: ${AppConfig.flavor.name}
API url: ${AppConfig.baseUrl}
'''),
  'Setup error logging': (container) {
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      utils.logError(error, stackTrace, fatal: true, clue: 'Platform').ignore();
      return true;
    };
    FlutterError.onError = utils.logFlutterError;
    // There is no point to call previous callbacks
    // of PlatformDispatcher and FlutterError,
    // therefore at this point logging is redefined.
  },
  'Initialize app dependencies': (container) =>
      container.app = AppDependencies()
        ..name = 'Starty'
        ..sharedPreferencesAsync = SharedPreferencesAsync(),
  //* --- settings --- *//
  'Initialize settings dependencies': (container) async {
    final repository = SettingsRepositoryImpl(
      SettingsLocalDatasourceImpl(container.app.sharedPreferencesAsync),
    );
    container.settings = SettingsDependencies()
      ..repository = repository
      ..settingsBloc = SettingsBloc(
        repository,
        initialData: await repository.fetchSettings(),
      );
  },
  //* --- Misc --- *//
  'Test async': (container) async =>
      await Future.delayed(const Duration(seconds: 1)),
  'Test another async': (container) async =>
      await Future.delayed(const Duration(seconds: 2)),
  'Test final async': (container) async =>
      await Future.delayed(const Duration(seconds: 3)),
};
