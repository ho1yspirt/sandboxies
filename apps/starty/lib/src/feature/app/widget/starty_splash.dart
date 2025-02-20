import 'package:flutter/material.dart';
import 'package:initialization/initialization.dart';

/// {@template starty_splash}
/// StartySplash widget.
/// {@endtemplate}
class StartySplash extends StatefulWidget {
  /// {@macro starty_splash}
  const StartySplash({
    super.key, // ignore: unused_element
    required this.initProgress,
  });

  final InitializationProgressNotifier initProgress;

  @override
  State<StartySplash> createState() => _StartySplashState();
}

/// State for widget StartySplash.
class _StartySplashState extends State<StartySplash> {
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
  void dispose() {
    // Permanent removal of a tree stent
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.ltr,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // TODO (Amir Asake): Add logo widget for Starty app's splash
        ValueListenableBuilder(
          valueListenable: widget.initProgress,
          builder:
              (context, progress, _) =>
                  Text('${progress.percent}% | ${progress.message}'),
        ),
      ],
    ),
  );
}
