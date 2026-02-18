import 'dart:async';

import 'package:app_shared/src/initialization/common/type.dart';
import 'package:app_shared/src/initialization/data/initialize_dependencies.dart';
import 'package:flutter/widgets.dart';

Future<void> initializeApp<T>({
  required T container,
  required InitializationProcess<T> initializationProcess,
  required FutureOr<void> Function(T dependencies) onSuccess,
  Future<void> Function()? configuration,
  Widget? splash,
  void Function(InitializationProgress progress)? onProgress,
  FutureOr<void> Function(Object error, StackTrace stactTrace)? onError,
}) async {
  await configuration?.call();

  if (splash != null) runApp(splash);

  final dependencies = await initializeDependencies(
    container: container,
    initializationProcess: initializationProcess,
    onProgress: onProgress,
    onError: onError,
  );
  await onSuccess(dependencies);
}
