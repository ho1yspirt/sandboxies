// ignore_for_file: sort_constructors_first

import 'dart:convert';

import 'package:flutter/material.dart';

/// {@template theme_settings_model}
/// ThemeSettingsModel.
/// {@endtemplate}
final class ThemeSettingsModel {
  /// {@macro theme_settings_model}
  const ThemeSettingsModel({
    required this.colorSeed,
    required this.themeMode,
    required this.dynamicSchemeVariant,
    required this.contrastLevel,
    required this.iconIsFilled,
    required this.iconWeight,
    required this.buttonRadius,
  });

  /// {@macro theme_settings_model.fallback}
  const ThemeSettingsModel.fallback()
    : colorSeed = Colors.blue,
      themeMode = ThemeMode.system,
      dynamicSchemeVariant = DynamicSchemeVariant.vibrant,
      contrastLevel = 0,
      iconIsFilled = true,
      iconWeight = 300,
      buttonRadius = 20;

  final Color colorSeed;
  // enum
  final ThemeMode themeMode;
  // enum
  final DynamicSchemeVariant dynamicSchemeVariant;
  final double contrastLevel;
  final bool iconIsFilled;
  final double iconWeight;
  final double buttonRadius;

  ThemeSettingsModel copyWith({
    Color? colorSeed,
    ThemeMode? themeMode,
    DynamicSchemeVariant? dynamicSchemeVariant,
    double? contrastLevel,
    bool? iconIsFilled,
    double? iconWeight,
    double? buttonRadius,
  }) {
    return ThemeSettingsModel(
      colorSeed: colorSeed ?? this.colorSeed,
      themeMode: themeMode ?? this.themeMode,
      dynamicSchemeVariant: dynamicSchemeVariant ?? this.dynamicSchemeVariant,
      contrastLevel: contrastLevel ?? this.contrastLevel,
      iconIsFilled: iconIsFilled ?? this.iconIsFilled,
      iconWeight: iconWeight ?? this.iconWeight,
      buttonRadius: buttonRadius ?? this.buttonRadius,
    );
  }

  Map<String, Object?> toMap() => {
    'colorSeed': colorSeed.toARGB32(),
    'themeMode': themeMode.index,
    'dynamicSchemeVariant': dynamicSchemeVariant.index,
    'contrastLevel': contrastLevel,
    'iconIsFilled': iconIsFilled,
    'iconWeight': iconWeight,
    'buttonRadius': buttonRadius,
  };

  factory ThemeSettingsModel.fromMap(Map<String, Object?> map) {
    const fallback = ThemeSettingsModel.fallback();
    return ThemeSettingsModel(
      colorSeed: Color(
        map['colorSeed'] as int? ?? fallback.colorSeed.toARGB32(),
      ),
      themeMode: ThemeMode
          .values[map['themeMode'] as int? ?? fallback.themeMode.index],
      dynamicSchemeVariant:
          DynamicSchemeVariant.values[map['dynamicSchemeVariant'] as int? ??
              fallback.dynamicSchemeVariant.index],
      contrastLevel: map['contrastLevel'] as double? ?? fallback.contrastLevel,
      iconIsFilled: map['iconIsFilled'] as bool? ?? fallback.iconIsFilled,
      iconWeight: map['iconWeight'] as double? ?? fallback.iconWeight,
      buttonRadius: map['buttonRadius'] as double? ?? fallback.buttonRadius,
    );
  }

  String toJson() => json.encode(toMap());

  factory ThemeSettingsModel.fromJson(String source) =>
      ThemeSettingsModel.fromMap(json.decode(source) as Map<String, Object?>);

  @override
  String toString() =>
      '''ThemeSettingsModel(
  colorSeed: $colorSeed, 
  themeMode: $themeMode, 
  dynamicSchemeVariant: $dynamicSchemeVariant, 
  contrastLevel: $contrastLevel, 
  iconIsFilled: $iconIsFilled, 
  iconWeight: $iconWeight,
  buttonRadius: $buttonRadius,
)''';

  @override
  bool operator ==(covariant ThemeSettingsModel other) {
    if (identical(this, other)) return true;

    return other.colorSeed == colorSeed &&
        other.themeMode == themeMode &&
        other.dynamicSchemeVariant == dynamicSchemeVariant &&
        other.contrastLevel == contrastLevel &&
        other.iconIsFilled == iconIsFilled &&
        other.iconWeight == iconWeight &&
        other.buttonRadius == buttonRadius;
  }

  @override
  int get hashCode => Object.hashAll([
    colorSeed.hashCode,
    themeMode.hashCode,
    dynamicSchemeVariant.hashCode,
    contrastLevel.hashCode,
    iconIsFilled.hashCode,
    iconWeight.hashCode,
    buttonRadius.hashCode,
  ]);
}
