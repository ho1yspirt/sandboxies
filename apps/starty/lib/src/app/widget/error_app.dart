import 'package:flutter/material.dart';
import 'package:starty/src/_internal/constant/constant.dart';

import 'package:starty/src/app/widget/screen/error_screen.dart';

/// {@template error_app}
/// ErrorApp widget.
/// {@endtemplate}
class ErrorApp extends StatelessWidget {
  /// {@macro error_app}
  const ErrorApp({super.key, this.error});

  final Object? error;

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: AppConfig.env.isDevelopment,
    title: 'ErrorApp',
    home: ErrorScreen(error: error),
  );
}
