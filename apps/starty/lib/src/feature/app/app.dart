import 'dart:ui';

import 'package:app_shared/initialization.dart' deferred as initialization;
import 'package:app_shared/utils.dart' as app_utils;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:l/l.dart';
import 'package:starty/src/feature/app/data/initialization_process.dart';
import 'package:starty/src/feature/app/data/model/dependencies.dart';
import 'package:starty/src/feature/app/widget/error_app.dart'
    deferred as error_app;
import 'package:starty/src/feature/app/widget/starty_app.dart'
    deferred as starty;
import 'package:starty/src/feature/app/widget/starty_splash.dart';

Future<void> _confifure() => app_utils.runTimeLoggedAsync(() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized()
    ..deferFirstFrame();

  final sourcePlatformDispatcherError = PlatformDispatcher.instance.onError;
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    final source = sourcePlatformDispatcherError?.call(error, stackTrace);
    l.e(error, stackTrace);
    return source ?? false;
  };
  final sourceFlutterError = FlutterError.onError;
  FlutterError.onError = (details) {
    l.e(details.exceptionAsString(), details.stack);
    sourceFlutterError?.call(details);
  };

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  widgetsBinding.allowFirstFrame();
}, name: '_configure');

Future<void> run() => app_utils.runTimeLoggedAsync(() async {
  final initProgress = ValueNotifier((percent: 0, message: ''));
  final container = Dependencies();

  await initialization.loadLibrary();
  await initialization.initializeApp(
    configuration: _confifure,
    container: () => container,
    initializationProcess: initializationProcesss,
    splash: StartySplash(initProgress: initProgress),
    onProgress: (progress) {
      l.d('${progress.percent}% | ${progress.message}');
      initProgress.value = progress;
    },
    onSuccess: (dependencies) async {
      await starty.loadLibrary();
      runApp(starty.StartyApp(dependencies: dependencies));
    },
    onError: (error, stackTrace) async {
      l.e(error, stackTrace);

      await error_app.loadLibrary();
      runApp(error_app.ErrorApp(error: error));
    },
  );
}, name: 'run');
