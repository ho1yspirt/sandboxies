import 'package:app_shared/src/settings/data/model/settings_model.dart';
import 'package:app_shared/src/settings/data/model/theme_settings_model.dart';
import 'package:app_shared/src/settings/data/settings_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc(
    SettingsRepository settingsRepository, {
    required SettingsModel initialData,
  }) : _settingsRepository = settingsRepository,
       super(Settings$Idle(initialData)) {
    on<SettingsEvent>(
      (event, emit) => switch (event) {
        SettingsLocaleChanged() => _localeChanged(event, emit),
        SettingsThemeChanged() => _themeChanged(event, emit),
      },
    );
  }

  final SettingsRepository _settingsRepository;

  Future<void> _localeChanged(
    SettingsLocaleChanged event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(Settings$Processing(state.data));
      final locale = event.value;
      await _settingsRepository.updateLocale(locale);
      emit(Settings$Idle(state.data.copyWith(locale: locale)));
    } catch (error) {
      emit(Settings$Failure(state.data));

      rethrow;
    } finally {
      emit(Settings$Idle(state.data));
    }
  }

  Future<void> _themeChanged(
    SettingsThemeChanged event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      emit(Settings$Processing(state.data));
      final themeSettings = event.value;
      await _settingsRepository.updateThemeSettings(themeSettings);
      emit(Settings$Idle(state.data.copyWith(themeSettings: themeSettings)));
    } catch (error) {
      emit(Settings$Failure(state.data));

      rethrow;
    } finally {
      emit(Settings$Idle(state.data));
    }
  }
}
