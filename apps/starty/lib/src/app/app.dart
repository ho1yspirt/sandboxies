import 'dart:io';
import 'dart:ui';

import 'package:app_shared/initialization.dart' deferred as initialization;
import 'package:app_shared/utils.dart' as utils;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:l/l.dart';
import 'package:starty/src/app/data/starty_initialization_process.dart';
import 'package:starty/src/app/data/model/dependencies.dart';
import 'package:starty/src/app/widget/error_app.dart' deferred as error_app;
import 'package:starty/src/app/widget/starty_app.dart' deferred as starty_app;
import 'package:starty/src/app/widget/starty_splash.dart';
import 'package:window_manager/window_manager.dart';

Future<void> _confifure() => utils.runTimeLoggedAsync(() async {
  // Ensure for widgets binding initialization first,
  // then freeze last frame of native splash.
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized()
    ..deferFirstFrame();

  // Log errors of on platform and framework levels.
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

  // Set display refresh rate for android devices.
  if (!kIsWeb && Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }

  // Set initial window configuration for desktop devices.
  if (!(kIsWeb || Platform.isAndroid || Platform.isIOS)) {
    await windowManager.ensureInitialized();
    windowManager.waitUntilReadyToShow(
      const WindowOptions(
        center: true,
        skipTaskbar: false,
        titleBarStyle: TitleBarStyle.hidden,
        backgroundColor: Colors.transparent,
        size: Size(741, 527),
        minimumSize: Size(375, 527),
      ),
      () async {
        await windowManager.show();
        await windowManager.focus();
      },
    );
  }

  // Set edge-to-edge mode on suppported platforms.
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Release last frame of native splash and show Flutter view.
  widgetsBinding.allowFirstFrame();
}, name: '_configure');

Future<void> run() => utils.runTimeLoggedAsync(() async {
  final initProgress = ValueNotifier((percent: 0, message: ''));
  final container = Dependencies();

  await initialization.loadLibrary();
  await initialization.initializeApp(
    configuration: _confifure,
    container: container,
    initializationProcess: initializationProcesss,
    splash: StartySplash(initProgress: initProgress),
    onProgress: (progress) {
      l.i('${progress.percent}% | ${progress.message}');
      initProgress.value = progress;
    },
    onSuccess: (dependencies) async {
      await starty_app.loadLibrary();
      runApp(starty_app.StartyApp(dependencies: dependencies));
    },
    onError: (error, stackTrace) async {
      l.e(error, stackTrace);

      await error_app.loadLibrary();
      runApp(error_app.ErrorApp(error: error));
    },
  );
}, name: 'run');
