import 'package:flutter/foundation.dart';
import 'package:l/l.dart';

/// Log error, and:
/// - return in debug console;
/// - collect to log service provider;
///
/// {@template error_util.serviceProvider}
/// Currently collecting to - `Firebase Crashlytics`.
/// If service provider is changed, refactor this documentation.
/// {@endtemplate}
Future<void> logError(
  Object error,
  StackTrace stackTrace, {
  String? clue,
  bool fatal = false,
}) async {
  try {
    l.e(error, stackTrace);

    if (error is String) {
      return await _collectMessage(
        error,
        stackTrace: stackTrace,
        warning: fatal,
        clue: clue,
      );
    }
    return _collectError(
      error,
      stackTrace: stackTrace,
      fatal: fatal,
      clue: clue,
    ).ignore();
  } catch (error, stackTrace) {
    l.e('Error during log of error: $error', stackTrace);
  }
}

Future<void> logFlutterError(
  FlutterErrorDetails details, {
  String? clue,
}) async {
  l.e('${details.exceptionAsString()} clue: $clue', details.stack);

  // FirebaseCrashlytics.instance.recordFlutterFatalError(details).ignore();
}

/// Collect Error to the respected source.
///
/// {@macro error_util.serviceProvider}
Future<void> _collectError(
  Object error, {
  StackTrace? stackTrace,
  String? clue,
  bool fatal = false,
}) async {
  // FirebaseCrashlytics.instance.recordError(
  //   error,
  //   stackTrace,
  //   fatal: fatal,
  //   reason: clue,
  // );
}

/// Collect log's message to the respected source.
/// In case if [fatal] is `true`, then collect as error-like log.
///
/// {@macro error_util.serviceProvider}
Future<void> _collectMessage(
  String message, {
  String? clue,
  StackTrace? stackTrace,
  bool warning = false,
}) async {
  final isWarning = warning || stackTrace != null;
  if (isWarning) {
    // FirebaseCrashlytics.instance.recordError(
    //   message,
    //   stackTrace,
    //   reason: clue,
    // );
  } else {
    // FirebaseCrashlytics.instance.log('message: $message, reason: $clue');
  }
}
