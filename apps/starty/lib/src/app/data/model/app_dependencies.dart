import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starty/src/app/widget/dependencies_scope.dart';

/// {@template app_dependencies}
/// AppDependencies.
/// {@endtemplate}
final class AppDependencies {
  /// {@macro app_dependencies}
  AppDependencies();

  /// {@macro app_dependencies}
  factory AppDependencies.of(BuildContext context) =>
      DependenciesScope.appDependenciesOf(context);

  late final String name;
  late final SharedPreferencesAsync sharedPreferencesAsync;
}
