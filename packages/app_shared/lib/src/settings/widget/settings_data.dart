import 'package:app_shared/src/settings/data/model/settings_model.dart';
import 'package:app_shared/src/settings/data/model/theme_settings_model.dart';
import 'package:flutter/material.dart';

enum _SettingsDataAspect { locale, theme }

/// {@template settings_scope}
/// SettingsScope widget.
/// {@endtemplate}
class SettingsData extends InheritedModel<_SettingsDataAspect> {
  /// {@macro settings_scope}
  const SettingsData({super.key, required this.data, required super.child});

  final SettingsModel data;

  static SettingsModel? _maybeOf(
    BuildContext context, [
    _SettingsDataAspect? aspect,
  ]) => InheritedModel.inheritFrom<SettingsData>(context, aspect: aspect)?.data;

  static Never _notFoundInheritedWidgetOfExactType() =>
      throw ArgumentError('Out of scope');

  static SettingsModel _of(
    BuildContext context, [
    _SettingsDataAspect? aspect,
  ]) => _maybeOf(context, aspect) ?? _notFoundInheritedWidgetOfExactType();

  static SettingsModel of(BuildContext context) => _of(context);

  static Locale localeOf(BuildContext context) =>
      _of(context, _SettingsDataAspect.locale).locale;

  static ThemeSettingsModel themeOf(BuildContext context) =>
      _of(context, _SettingsDataAspect.theme).themeSettings;

  @override
  bool updateShouldNotify(SettingsData oldWidget) => data != oldWidget.data;

  @override
  bool updateShouldNotifyDependent(
    SettingsData oldWidget,
    Set<Object> dependencies,
  ) => dependencies.any(
    (dependency) =>
        dependency is _SettingsDataAspect &&
        switch (dependency) {
          _SettingsDataAspect.locale => data.locale != oldWidget.data.locale,
          _SettingsDataAspect.theme =>
            data.themeSettings != oldWidget.data.themeSettings,
        },
  );
}
