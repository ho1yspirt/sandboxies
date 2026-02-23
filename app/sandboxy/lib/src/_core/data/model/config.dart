import 'package:flutter/services.dart';
import 'package:sandboxy/src/_core/data/model/app_flavor_type.dart';
import 'package:sandboxy/src/_core/data/model/env_flavor_type.dart';

/// {@template config}
/// SandboxyConfig.
/// {@endtemplate}
abstract final class SandboxyConfig {
  /// Environment flavor.
  ///
  /// e.g. development, staging, production.
  static final env = EnvFlavorType.fromValue(
    const String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev'),
  );

  /// Flavor configuration, which defined with `--flavor`, value of Flutter's [appFlavor].
  ///
  /// Do not misslead with [env].
  static final flavor = AppFlavorType.fromValue(appFlavor);

  /// Base url for api.
  ///
  /// e.g. https://api.domain.tld.
  static const baseUrl = String.fromEnvironment('BASE_URL', defaultValue: '');

  /// Enable or disable page transitions in web platform.
  static const enableWebPageTransitions = bool.fromEnvironment(
    'ENABLE_WEB_PAGE_TRANSITIONS',
    defaultValue: true,
  );
}
