import 'package:flutter/material.dart';

/// {@template error_screen}
/// ErrorScreen widget.
/// {@endtemplate}
class ErrorScreen extends StatelessWidget {
  /// {@macro error_screen}
  const ErrorScreen({
    super.key, // ignore: unused_element
  });

  /// Screen route name
  static const name = 'ErrorScreen';

  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: Icon(Icons.error_outline_outlined)));
}
