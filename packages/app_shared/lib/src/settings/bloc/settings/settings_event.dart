part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent {
  const SettingsEvent();
}

final class SettingsLocaleChanged extends SettingsEvent {
  const SettingsLocaleChanged(this.value);

  final Locale value;
}

final class SettingsThemeChanged extends SettingsEvent {
  const SettingsThemeChanged(this.value);

  final ThemeSettingsModel value;
}
