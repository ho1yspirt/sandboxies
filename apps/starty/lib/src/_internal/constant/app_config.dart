import 'package:flutter/services.dart';
import 'package:starty/src/_internal/enum/enum.dart';

/// {@template app_config}
/// AppConfig.
/// {@endtemplate}
abstract final class AppConfig {
  /// Environment flavor.
  /// e.g. development, staging, production
  static final env = EnvFlavorType.fromValue(
    const String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev'),
  );

  /// Flavor configuration, which defined with `--flavor`, value of Flutter's [appFlavor].
  ///
  /// Do not misslead with [env].
  static final flavor = AppFlavorType.fromValue(appFlavor);

  /// Base url for api.
  /// e.g. https://api.domain.tld
  static const baseUrl = String.fromEnvironment('BASE_URL', defaultValue: '');

  /// Enable or disable page transitions in web platform
  static const enableWebPageTransitions = bool.fromEnvironment(
    'ENABLE_WEB_PAGE_TRANSITIONS',
    defaultValue: true,
  );
}
