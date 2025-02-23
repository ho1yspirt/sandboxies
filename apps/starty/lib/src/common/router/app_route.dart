import 'package:flutter/widgets.dart';
import 'package:octopus/octopus.dart';
import 'package:starty/src/feature/home/widget/screen/home_screen.dart';

enum AppRoute with OctopusRoute {
  home(HomeScreen.name, title: HomeScreen.title);

  const AppRoute(this.name, {this.title});

  @override
  final String name;

  @override
  final String? title;

  @override
  Widget builder(BuildContext context, OctopusState state, OctopusNode node) =>
      switch (this) {
        AppRoute.home => const HomeScreen(),
      };

  @override
  // ignore: unnecessary_overrides
  Page<Object?> pageBuilder(
    BuildContext context,
    OctopusState state,
    OctopusNode node,
  ) => super.pageBuilder(context, state, node);
}
