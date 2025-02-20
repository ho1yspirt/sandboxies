import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:initialization/src/common/type.dart';
import 'package:initialization/src/data/initialize_dependencies.dart';

Future<void> initializeApp<T>({
  required T Function() container,
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
