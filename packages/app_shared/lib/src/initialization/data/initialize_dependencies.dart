import 'package:app_shared/src/initialization/core/exception.dart';
import 'package:app_shared/src/initialization/core/type.dart';

Future<T> initializeDependencies<T>({
  required T container,
  required InitializationProcess<T> initializationProcess,
  void Function(InitializationProgress step)? onProgress,
  void Function(Object error, StackTrace stackTrace)? onError,
}) async {
  final dependencies = container;

  int stepIndex = 0;
  final totalSteps = initializationProcess.length;
  for (final stepEntry in initializationProcess.entries) {
    try {
      stepIndex++;
      final stepPercent = (stepIndex * 100 ~/ totalSteps).clamp(0, 100);

      onProgress?.call((percent: stepPercent, message: stepEntry.key));

      await stepEntry.value(dependencies);
    } catch (error, stackTrace) {
      onError?.call(error, stackTrace);

      Error.throwWithStackTrace(
        DependencyInitializationException(Error.safeToString(error)),
        stackTrace,
      );
    }
  }
  return dependencies;
}
