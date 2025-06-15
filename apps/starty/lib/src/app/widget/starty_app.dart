import 'package:app_shared/settings.dart';
import 'package:app_shared/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:starty/src/_internal/constant/constant.dart';
import 'package:starty/src/_internal/localization/generated/l10n.dart';
import 'package:starty/src/_internal/theme/app_theme.dart';
import 'package:starty/src/app/data/model/app_dependencies.dart';
import 'package:starty/src/app/data/model/dependencies.dart';
import 'package:starty/src/app/widget/dependencies_scope.dart';
import 'package:starty/src/app/widget/screen/error_screen.dart';
import 'package:starty/src/home/widget/screen/home_screen.dart';

/// {@template starty_app}
/// StartyApp widget.
/// {@endtemplate}
class StartyApp extends StatelessWidget {
  /// {@macro starty_app}
  const StartyApp({super.key, required this.dependencies});

  final Dependencies dependencies;

  @override
  Widget build(BuildContext context) => DependenciesScope(
    dependencies: dependencies,
    child: SettingsScope(
      dependencies: dependencies.settings,
      child: const _App(),
    ),
  );
}

class _App extends StatefulWidget {
  // ignore: unused_element_parameter
  const _App({super.key});

  @override
  State<_App> createState() => __AppState();
}

class __AppState extends State<_App> {
  final Key builderKey = GlobalKey();

  @override
  Widget build(BuildContext context) => MaterialApp(
    //* --- Internal --- *//
    debugShowCheckedModeBanner: AppConfig.env.isDevelopment,
    title: AppDependencies.of(context).name,
    //* --- Localization --- *//
    supportedLocales: StartyL10n.delegate.supportedLocales,
    localizationsDelegates: const [
      StartyL10n.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    //* --- Theme --- *//
    theme: AppTheme.lightOf(context),
    darkTheme: AppTheme.darkOf(context),
    themeMode: SettingsData.themeOf(context).themeMode,
    scrollBehavior: const MaterialScrollBehavior(),
    //* --- Navigation and Routing --- *//
    builder: (context, child) => MediaQuery(
      key: builderKey,
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: WindowScope(
        child: child ?? const ErrorScreen(error: 'No screen in the tree.'),
      ),
    ),
    home: const HomeScreen(),
  );
}
