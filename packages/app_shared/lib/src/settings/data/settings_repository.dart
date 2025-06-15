import 'package:app_shared/src/settings/data/settings_local_datasource.dart';
import 'package:app_shared/src/settings/data/model/settings_model.dart';
import 'package:app_shared/src/settings/data/model/theme_settings_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// {@template settings_repository}
/// SettingsRepository.
/// {@endtemplate}
abstract interface class SettingsRepository {
  Future<Locale> fetchLocale();

  Future<SettingsModel> fetchSettings();

  Future<ThemeSettingsModel> fetchThemeSettings();

  Future<void> updateLocale(Locale value);

  Future<void> updateThemeSettings(ThemeSettingsModel value);
}

/// {@macro settings_repository}
final class SettingsRepositoryImpl implements SettingsRepository {
  /// {@macro settings_repository}
  const SettingsRepositoryImpl(SettingsLocalDatasource localDatasource)
    : _localDatasource = localDatasource;

  final SettingsLocalDatasource _localDatasource;

  @override
  Future<Locale> fetchLocale() async {
    final locale = await _localDatasource.fetchLocale();
    if (locale != null) {
      return locale;
    } else {
      // Return current platform's locale if program's is null.
      return PlatformDispatcher.instance.locale;
    }
  }

  @override
  Future<SettingsModel> fetchSettings() async => SettingsModel(
    locale: await fetchLocale(),
    themeSettings: await fetchThemeSettings(),
  );

  @override
  Future<ThemeSettingsModel> fetchThemeSettings() async {
    final themeSettings = await _localDatasource.fetchThemeSettings();
    if (themeSettings != null) {
      return themeSettings;
    } else {
      // Return fallback if something isn't right.
      return const ThemeSettingsModel.fallback();
    }
  }

  @override
  Future<void> updateLocale(Locale value) =>
      _localDatasource.updateLocale(value);

  @override
  Future<void> updateThemeSettings(ThemeSettingsModel value) =>
      _localDatasource.updateThemeSettings(value);
}
