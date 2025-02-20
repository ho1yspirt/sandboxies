import 'package:flutter/material.dart';
import 'package:starty/src/feature/app/data/model/app_dependencies.dart';

/// {@template home_screen}
/// HomeScreen widget.
/// {@endtemplate}
class HomeScreen extends StatelessWidget {
  /// {@macro home_screen}
  const HomeScreen({
    super.key, // ignore: unused_element
  });

  /// Screen route name
  static const name = 'HomeScreen';

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.home_outlined),
          Text(AppDependencies.of(context).name),
        ],
      ),
    ),
  );
}
