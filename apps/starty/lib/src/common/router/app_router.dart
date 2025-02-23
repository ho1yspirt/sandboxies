import 'package:flutter/cupertino.dart';
import 'package:octopus/octopus.dart';
import 'package:starty/src/common/router/app_route.dart';

/// {@template app_router}
/// AppRouter.
/// {@endtemplate}
final class AppRouter {
  /// {@macro app_router}
  AppRouter() {
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
