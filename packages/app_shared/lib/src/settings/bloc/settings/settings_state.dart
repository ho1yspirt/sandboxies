part of 'settings_bloc.dart';

typedef SettingsStateData = SettingsModel;

/// {@template settings_state}
/// SettingsState.
/// {@endtemplate}
@immutable
sealed class SettingsState {
  /// {@macro settings_state}
  const SettingsState(this.data);

  final SettingsStateData data;

  bool get isProcessing => this is Settings$Processing;

  bool get isIdle => !isProcessing;

  bool get isFailure => this is Settings$Failure;
}

final class Settings$Idle extends SettingsState {
  const Settings$Idle(super.data);
}

final class Settings$Processing extends SettingsState {
  const Settings$Processing(super.data);
}

final class Settings$Failure extends SettingsState {
  const Settings$Failure(super.data);
}
