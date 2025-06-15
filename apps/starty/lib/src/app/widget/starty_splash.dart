import 'package:app_shared/initialization.dart';
import 'package:app_shared/settings.dart';
import 'package:app_shared/widgets.dart';
import 'package:flutter/material.dart';
import 'package:starty/src/_internal/constant/app_config.dart';
import 'package:starty/src/_internal/theme/app_theme.dart';
import 'package:starty/src/app/widget/screen/error_screen.dart';

/// {@template starty_splash}
/// StartySplash widget.
/// {@endtemplate}
class StartySplash extends StatelessWidget {
  /// {@macro starty_splash}
  const StartySplash({super.key, required this.initProgress});

  final InitializationProgressNotifier initProgress;

  @override
  Widget build(BuildContext context) => SettingsData(
    data: SettingsModel.fallback(),
    child: Builder(
      builder: (context) => MaterialApp(
        //* --- Internal --- *//
        debugShowCheckedModeBanner: AppConfig.env.isDevelopment,
        title: 'StartySplash',
        //* --- Theme --- *//
        theme: AppTheme.lightOf(context),
        darkTheme: AppTheme.darkOf(context),
        themeMode: SettingsData.themeOf(context).themeMode,
        scrollBehavior: const MaterialScrollBehavior(),
        //* --- Navigation and Routing --- *//
        builder: (context, child) => MediaQuery(
          key: GlobalKey(),
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.noScaling),
          child: WindowScope(
            child: child ?? const ErrorScreen(error: 'No screen in the tree.'),
          ),
        ),
        home: _StartySplash(initProgress: initProgress),
      ),
    ),
  );
}

/// {@template starty_splash}
/// _StartySplash widget.
/// {@endtemplate}
class _StartySplash extends StatefulWidget {
  /// {@macro starty_splash}
  // ignore: unused_element_parameter
  const _StartySplash({super.key, required this.initProgress});

  final InitializationProgressNotifier initProgress;

  @override
  State<_StartySplash> createState() => __StartySplashState();
}

/// State for widget _StartySplash.
class __StartySplashState extends State<_StartySplash> {
  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();

    // Initial state initialization
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The configuration of InheritedWidgets has changed
    // Also called after initState but before build
  }

  @override
  void didUpdateWidget(covariant _StartySplash oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget configuration changed
  }

  @override
  void dispose() {
    // Permanent removal of a tree stent
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) => Material(
    color: ColorScheme.of(context).surface,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ValueListenableBuilder(
          valueListenable: widget.initProgress,
          builder: (_, progress, _) => Text(
            '${progress.percent}% | ${progress.message}',
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: TextTheme.of(context).titleSmall,
          ),
        ),
      ],
    ),
  );
}
