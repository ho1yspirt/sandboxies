import 'package:flutter/material.dart';

/// {@template no_animation_page_transitions_builder}
/// NoAnimationPageTransitionsBuilder.
/// {@endtemplate}
class NoAnimationPageTransitionsBuilder extends PageTransitionsBuilder {
  /// {@macro no_animation_page_transitions_builder}
  const NoAnimationPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) => child;
}
