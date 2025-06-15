import 'package:app_shared/src/settings/bloc/settings/settings_bloc.dart';
import 'package:app_shared/src/settings/data/model/settings_dependencies.dart';
import 'package:app_shared/src/settings/widget/settings_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template settings_scope}
/// SettingsScope widget.
/// {@endtemplate}
class SettingsScope extends StatelessWidget {
  /// {@macro settings_scope}
  const SettingsScope({
    super.key,
    required this.dependencies,
    required this.child,
  });

  final SettingsDependencies dependencies;
  final Widget child;

  static SettingsDependencies of(BuildContext context) =>
      _SettingsScope.of(context);

  @override
  Widget build(BuildContext context) => _SettingsScope(
    dependencies: dependencies,
    child: BlocBuilder<SettingsBloc, SettingsState>(
      bloc: dependencies.settingsBloc,
      builder: (context, state) => SettingsData(data: state.data, child: child),
    ),
  );
}

/// {@template settings_scope}
/// _SettingsScope widget.
/// {@endtemplate}
class _SettingsScope extends InheritedWidget {
  /// {@macro settings_scope}
  const _SettingsScope({
    super.key, // ignore: unused_element_parameter
    required this.dependencies,
    required super.child,
  });

  final SettingsDependencies dependencies;

  // dart format off
  static _SettingsScope? _maybeOf(BuildContext context) =>
    context.getElementForInheritedWidgetOfExactType<_SettingsScope>()
      ?.widget as _SettingsScope?;
  // dart format on

  static Never _notFoundInheritedWidgetOfExactType() =>
      throw ArgumentError('Out of scope');

  static _SettingsScope _of(BuildContext context) =>
      _maybeOf(context) ?? _notFoundInheritedWidgetOfExactType();

  static SettingsDependencies of(BuildContext context) =>
      _of(context).dependencies;

  @override
  bool updateShouldNotify(_SettingsScope oldWidget) => false;
}
