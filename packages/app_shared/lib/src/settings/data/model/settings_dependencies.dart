import 'package:app_shared/src/settings/bloc/settings/settings_bloc.dart';
import 'package:app_shared/src/settings/data/settings_repository.dart';
import 'package:app_shared/src/settings/widget/settings_scope.dart';
import 'package:flutter/material.dart';

/// {@template settings_dependencies}
/// SettingsDependencies.
/// {@endtemplate}
final class SettingsDependencies {
  /// {@macro settings_dependencies}
  SettingsDependencies();

  /// {@macro settings_dependencies}
  factory SettingsDependencies.of(BuildContext context) =>
      SettingsScope.of(context);

  // repositories
  late final SettingsRepository repository;
  // blocs
  late final SettingsBloc settingsBloc;
}
