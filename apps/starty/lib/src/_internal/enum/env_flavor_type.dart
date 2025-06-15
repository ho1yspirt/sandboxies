/// {@template env_flavor}
/// Environment flavor enumration
/// {@endtemplate}
enum EnvFlavorType {
  /// Development
  dev('dev'),

  /// Production
  prod('prod'),

  /// Test
  test('test');

  /// {@macro env_flavor}
  const EnvFlavorType(this.value);

  /// {@macro env_flavor}
  factory EnvFlavorType.fromValue(String? value) =>
      switch (value?.trim().toLowerCase()) {
        'development' || 'debug' || 'dev' => dev,
        'production' || 'release' || 'prod' => dev,
        'test' => test,
        _ => const bool.fromEnvironment('dart.vm.product') ? prod : dev,
      };

  /// development, staging, production
  final String value;

  /// Whether the environment is development.
  bool get isDevelopment => this == dev;

  /// Whether the environment is production.
  bool get isProduction => this == prod;

  /// Whether the environment is test.
  bool get isTest => this == test;
}
