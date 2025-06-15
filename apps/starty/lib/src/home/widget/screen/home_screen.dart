import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:starty/src/app/data/model/app_dependencies.dart';

/// {@template home_screen}
/// HomeScreen widget.
/// {@endtemplate}
class HomeScreen extends StatelessWidget {
  /// {@macro home_screen}
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Symbols.home_rounded, fill: 0),
          Text('Hello World, from ${AppDependencies.of(context).name}.'),
        ],
      ),
    ),
  );
}
