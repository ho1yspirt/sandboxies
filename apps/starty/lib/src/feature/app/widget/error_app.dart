import 'package:flutter/material.dart';

/// {@template error_app}
/// ErrorApp widget.
/// {@endtemplate}
class ErrorApp extends StatelessWidget {
  /// {@macro error_app}
  const ErrorApp({
    super.key, // ignore: unused_element
    this.error,
  });

  final Object? error;

  @override
  Widget build(BuildContext context) => const MaterialApp();
}
