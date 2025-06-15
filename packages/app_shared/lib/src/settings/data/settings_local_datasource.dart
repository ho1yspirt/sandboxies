import 'package:app_shared/src/settings/data/model/theme_settings_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// {@template settings_local_datasource}
/// SettingsLocalDatasource.
/// {@endtemplate}
abstract interface class SettingsLocalDatasource {
  Future<Locale?> fetchLocale();

  Future<ThemeSettingsModel?> fetchThemeSettings();

  Future<void> updateLocale(Locale value);

  Future<void> updateThemeSettings(ThemeSettingsModel value);
}

/// {@macro settings_local_datasource}
final class SettingsLocalDatasourceImpl implements SettingsLocalDatasource {
  /// {@macro settings_local_datasource}
  const SettingsLocalDatasourceImpl(
    SharedPreferencesAsync sharedPreferencesAsync,
  ) : _sharedPreferencesAsync = sharedPreferencesAsync;

  final SharedPreferencesAsync _sharedPreferencesAsync;

  static const countryCodeKey = 'countryCode';
  static const languageCodeKey = 'languageCode';
  static const themeSettingsKey = 'themeSettings';

  @override
  Future<Locale?> fetchLocale() async {
    final languageCode = await _sharedPreferencesAsync.getString(
      languageCodeKey,
    );
    final countryCode = await _sharedPreferencesAsync.getString(countryCodeKey);
    if (languageCode != null) {
      return Locale(languageCode, countryCode);
    } else {
      return null;
    }
  }

  @override
  Future<ThemeSettingsModel?> fetchThemeSettings() async {
    final themeSettings = await _sharedPreferencesAsync.getString(
      themeSettingsKey,
    );
    if (themeSettings != null) {
      return ThemeSettingsModel.fromJson(themeSettings);
    } else {
      return null;
    }
  }

  @override
  Future<void> updateLocale(Locale value) async {
    await _sharedPreferencesAsync.setString(
      languageCodeKey,
      value.languageCode,
    );
    final countryCode = value.countryCode;
    if (countryCode != null) {
      await _sharedPreferencesAsync.setString(countryCodeKey, countryCode);
    }
  }

  @override
  Future<void> updateThemeSettings(ThemeSettingsModel value) =>
      _sharedPreferencesAsync.setString(themeSettingsKey, value.toJson());
}
