import 'package:flutter/material.dart';
import 'package:starty/src/feature/app/data/model/app_dependencies.dart';
import 'package:starty/src/feature/app/data/model/dependencies.dart';
import 'package:starty/src/feature/app/widget/inherited_dependencies.dart';
import 'package:starty/src/feature/app/widget/screen/error_screen.dart';
import 'package:starty/src/feature/home/widget/screen/home_screen.dart';

/// {@template starty_app}
/// StartyApp widget.
/// {@endtemplate}
class StartyApp extends StatelessWidget {
  /// {@macro starty_app}
  const StartyApp({super.key, required this.dependencies});

  final Dependencies dependencies;

  @override
  Widget build(BuildContext context) =>
      InheritedDependencies(dependencies: dependencies, child: const _App());
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
    title: AppDependencies.of(context).name,
    builder: (context, child) => MediaQuery(
      key: builderKey,
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: child ?? const ErrorScreen(),
    ),
    home: const HomeScreen(),
  );
}
