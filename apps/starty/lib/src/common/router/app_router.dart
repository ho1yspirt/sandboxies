import 'package:flutter/cupertino.dart';
import 'package:octopus/octopus.dart';
import 'package:starty/src/common/router/app_route.dart';

/// {@template app_routing}
/// AppRouting.
/// {@endtemplate}
final class AppRouting {
  /// {@macro app_routing}
  AppRouting() {
    router = Octopus(
      routes: AppRoute.values,
      defaultRoute: AppRoute.home,
      transitionDelegate: const DefaultTransitionDelegate(),
      guards: [],
      onError: (error, stackTrace) {},
    );
  }

  late final Octopus router;
}
