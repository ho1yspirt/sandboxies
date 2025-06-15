import 'package:flutter/widgets.dart';
import 'package:starty/src/feature/app/widget/inherited_dependencies.dart';

/// {@template app_dependencies}
/// AppDependencies.
/// {@endtemplate}
final class AppDependencies {
  /// {@macro app_dependencies}
  AppDependencies();

  /// {@macro app_dependencies}
  factory AppDependencies.of(BuildContext context) =>
      InheritedDependencies.appDependenciesOf(context);

  late final String name;
}
