import 'package:flutter/material.dart';
import 'package:starty/src/feature/app/data/model/app_dependencies.dart';
import 'package:starty/src/feature/app/data/model/dependencies.dart';

/// {@template inherited_composite_dependencies}
/// InheritedCompositeDependencies widget.
/// {@endtemplate}
class InheritedDependencies extends InheritedWidget {
  /// {@macro inherited_composite_dependencies}
  const InheritedDependencies({
    super.key, // ignore: unused_element
    required this.dependencies,
    required super.child,
  });

  final Dependencies dependencies;

  static InheritedDependencies? _maybeOf(BuildContext context) =>
      (context
              .getElementForInheritedWidgetOfExactType<InheritedDependencies>()
              ?.widget
          as InheritedDependencies?);

  static Never _notFoundInheritedWidgetOfExactType() =>
      throw ArgumentError('Out of scope');

  static InheritedDependencies _of(BuildContext context) =>
      _maybeOf(context) ?? _notFoundInheritedWidgetOfExactType();

  static AppDependencies appDependenciesOf(BuildContext context) =>
      _of(context).dependencies.app;

  @override
  bool updateShouldNotify(InheritedDependencies oldWidget) => false;
}
