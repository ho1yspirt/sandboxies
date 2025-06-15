import 'dart:ui';

import 'package:app_shared/src/settings/data/model/theme_settings_model.dart';

/// {@template settings_model}
/// SettingsModel.
/// {@endtemplate}
final class SettingsModel {
  /// {@macro settings_model}
  const SettingsModel({required this.locale, required this.themeSettings});

  /// {@macro settings_model.fallback}
  factory SettingsModel.fallback() => SettingsModel(
    locale: PlatformDispatcher.instance.locale,
    themeSettings: const ThemeSettingsModel.fallback(),
  );

  final Locale locale;
  final ThemeSettingsModel themeSettings;

  SettingsModel copyWith({Locale? locale, ThemeSettingsModel? themeSettings}) =>
      SettingsModel(
        locale: locale ?? this.locale,
        themeSettings: themeSettings ?? this.themeSettings,
      );

  Map<String, Object?> toMap() => <String, Object?>{
    'locale': locale.toLanguageTag(),
    'themeSettings': themeSettings.toMap(),
  };

  @override
  String toString() =>
      '''SettingsModel(
  locale: $locale, 
  themeSettings: $themeSettings,
)''';

  @override
  bool operator ==(covariant SettingsModel other) {
    if (identical(this, other)) return true;

    return other.locale == locale && other.themeSettings == themeSettings;
  }

  @override
  int get hashCode => locale.hashCode ^ themeSettings.hashCode;
}
