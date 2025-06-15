import 'package:app_shared/settings.dart';
import 'package:app_shared/widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:starty/src/_internal/constant/constant.dart';

/// {@template app_theme}
/// AppTheme.
/// {@endtemplate}
final class AppTheme {
  /// Base [PageTransitionsBuilder] transitions.
  ///
  /// Sets [FadeForwardsPageTransitionsBuilder] if runs on web,
  /// if on native platform uses default platform's transition.
  static Map<TargetPlatform, PageTransitionsBuilder> get _builders {
    if (!kIsWeb || AppConfig.enableWebPageTransitions) {
      return {
        TargetPlatform.android: const PredictiveBackPageTransitionsBuilder(),
        TargetPlatform.iOS: const CupertinoPageTransitionsBuilder(),
        TargetPlatform.macOS: const CupertinoPageTransitionsBuilder(),
      };
    } else {
      return {
        for (final platform in TargetPlatform.values)
          platform: const NoAnimationPageTransitionsBuilder(),
      };
    }
  }

  static ThemeData baseOf(
    BuildContext context, {
    Brightness brightness = Brightness.light,
  }) {
    final themeSettings = SettingsData.themeOf(context);
    final colorScheme = ColorScheme.fromSeed(
      brightness: brightness,
      seedColor: themeSettings.colorSeed,
      dynamicSchemeVariant: themeSettings.dynamicSchemeVariant,
      contrastLevel: themeSettings.contrastLevel,
    );
    return ThemeData(
      //* --- Typography --- *//
      fontFamily: AppFonts.primary,
      fontFamilyFallback: AppFonts.fallback,
      //* --- Interactions --- *//
      splashFactory: InkSparkle.splashFactory,
      pageTransitionsTheme: PageTransitionsTheme(builders: _builders),
      //* --- Colors --- *//
      brightness: brightness,
      colorScheme: colorScheme,
      //* --- Components --- *//
      appBarTheme: const AppBarTheme(centerTitle: false),
      searchBarTheme: const SearchBarThemeData(
        elevation: WidgetStatePropertyAll(0),
      ),
      searchViewTheme: const SearchViewThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      menuTheme: const MenuThemeData(style: MenuStyle()),
      iconTheme: IconThemeData(
        color: colorScheme.onSurfaceVariant,
        fill: themeSettings.iconIsFilled ? 1 : 0,
        weight: themeSettings.iconWeight,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        year2023: false, // ignore: deprecated_member_use
      ),
      listTileTheme: ListTileThemeData(
        selectedTileColor: colorScheme.secondaryContainer,
      ),
      scrollbarTheme: const ScrollbarThemeData(
        interactive: true,
        thumbVisibility: WidgetStatePropertyAll(true),
      ),
      //* --- Interactive components --- *//
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (_) => const Icon(Symbols.arrow_back_rounded),
        closeButtonIconBuilder: (_) => const Icon(Symbols.close_rounded),
        drawerButtonIconBuilder: (_) => const Icon(Symbols.menu_rounded),
        endDrawerButtonIconBuilder: (_) => const Icon(Symbols.menu_rounded),
      ),
      sliderTheme: const SliderThemeData(
        year2023: false, // ignore: deprecated_member_use
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(visualDensity: VisualDensity.standard),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          visualDensity: VisualDensity.standard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(themeSettings.buttonRadius),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          visualDensity: VisualDensity.standard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(themeSettings.buttonRadius),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          visualDensity: VisualDensity.standard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(themeSettings.buttonRadius),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          visualDensity: VisualDensity.standard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(themeSettings.buttonRadius),
          ),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(
          visualDensity: VisualDensity.standard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(themeSettings.buttonRadius),
          ),
        ),
      ),
      chipTheme: const ChipThemeData(),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );
  }

  static ThemeData lightOf(BuildContext context) =>
      baseOf(context, brightness: Brightness.light).copyWith();

  static ThemeData darkOf(BuildContext context) =>
      baseOf(context, brightness: Brightness.dark).copyWith();
}
