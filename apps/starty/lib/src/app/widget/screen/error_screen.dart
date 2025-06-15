import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

/// {@template error_screen}
/// ErrorScreen widget.
/// {@endtemplate}
class ErrorScreen extends StatelessWidget {
  /// {@macro error_screen}
  const ErrorScreen({super.key, required this.error});

  final Object? error;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [const Icon(Symbols.warning_rounded), Text(error.toString())],
      ),
    ),
  );
}
