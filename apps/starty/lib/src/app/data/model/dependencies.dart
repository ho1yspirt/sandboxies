import 'package:app_shared/settings.dart';
import 'package:starty/src/app/data/model/app_dependencies.dart';

/// {@template dependencies}
/// Dependencies.
/// {@endtemplate}
final class Dependencies {
  /// {@macro dependencies}
  Dependencies();

  late final AppDependencies app;

  late final SettingsDependencies settings;
}
