import 'package:flutter/material.dart';
import 'package:starty/src/app/data/model/app_dependencies.dart';
import 'package:starty/src/app/data/model/dependencies.dart';

/// {@template dependencies_scope}
/// DependenciesScope widget.
/// {@endtemplate}
class DependenciesScope extends InheritedWidget {
  /// {@macro dependencies_scope}
  const DependenciesScope({
    super.key,
    required this.dependencies,
    required super.child,
  });

  final Dependencies dependencies;

  // dart format off
  static DependenciesScope? _maybeOf(BuildContext context) =>
    context.getElementForInheritedWidgetOfExactType<DependenciesScope>()
      ?.widget as DependenciesScope?;
  // dart format on

  static Never _notFoundInheritedWidgetOfExactType() =>
      throw ArgumentError('Out of scope');

  static DependenciesScope _of(BuildContext context) =>
      _maybeOf(context) ?? _notFoundInheritedWidgetOfExactType();

  static AppDependencies appDependenciesOf(BuildContext context) =>
      _of(context).dependencies.app;

  @override
  bool updateShouldNotify(DependenciesScope oldWidget) => false;
}
