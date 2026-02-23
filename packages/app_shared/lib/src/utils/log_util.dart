import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:l/l.dart';

String? Function(LogMessage event)? get _overrideOutput {
  if (kIsWeb) return null;

  if (Platform.isIOS) {
    return (LogMessage event) {
      const reset = '\x1B[0m';
      final ansiiColor = switch (event.level.toString()) {
        'E' => '\x1B[31m', // red
        'W' => '\x1B[33m', // yellow
        'I' => '\x1B[32m', // green
        'D' => '\x1B[36m', // cyan
        _ => reset, // reset
      };

      final StackTrace? stackTrace;
      if (event is LogMessageError) {
        stackTrace = event.stackTrace;
      } else {
        stackTrace = null;
      }

      developer.log(
        '$ansiiColor${event.message}',
        stackTrace: stackTrace,
        time: event.timestamp,
        level: event.level.level,
        name: '$ansiiColor${event.level.prefix}$reset',
      );
      return null;
    };
  }
  return null;
}

final _options = LogOptions(outputInRelease: false, overrideOutput: _overrideOutput);

/// {@template log_util.log_run_zoned_guarded}
/// Method that execute given [function] inside [runZonedGuarded],
/// which wrapped with custom log options from [_options] from [l] package
/// {@endtemplate}
void logRunZonedGuarded(FutureOr<void> Function() function) =>
    // ignore: experimental_member_use
    l.capture<void>(() => runZonedGuarded<void>(function, l.e), _options);

/// {@template logger_util.run_time_logged_sync}
/// Synchronous function for logging in debug mode execution time in μs.
///
/// Uses [kDebugMode] from foundation package, and [l] from l package.
/// {@endtemplate}
T runTimeLoggedSync<T>(T Function() body, {String? name}) {
  if (kDebugMode) {
    final stopwatch = Stopwatch()..start();
    try {
      return body();
    } catch (error) {
      rethrow;
    } finally {
      l.i('${name ?? ''}: ${(stopwatch..stop()).elapsedMicroseconds} μs');
    }
  } else {
    return body();
  }
}

/// {@template logger_util.run_time_logged_sync}
/// Asynchronous function for logging in debug mode execution time in μs.
///
/// Uses [kDebugMode] from foundation package, and [l] from l package.
/// {@endtemplate}
Future<T> runTimeLoggedAsync<T>(Future<T> Function() body, {String? name}) async {
  if (kDebugMode) {
    final stopwatch = Stopwatch()..start();
    try {
      return await body();
    } catch (error) {
      rethrow;
    } finally {
      final title = switch (name) {
        null => '',
        _ => '$name: ',
      };
      l.i('$title${(stopwatch..stop()).elapsedMicroseconds} μs');
    }
  } else {
    return await body();
  }
}
