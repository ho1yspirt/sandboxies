/// {@template app_flavor_type}
/// AppFlavorType enumeration.
/// {@endtemplate}
enum AppFlavorType implements Comparable<AppFlavorType> {
  /// dev.
  dev('dev'),

  /// prod.
  prod('prod'),

  /// unknown.
  unknown('unknown');

  /// {@macro app_flavor_type}
  const AppFlavorType(this.value);

  /// Creates a new instance of [AppFlavorType] from a given string.
  factory AppFlavorType.fromValue(String? value, {AppFlavorType? fallback}) =>
      switch (value?.trim().toLowerCase()) {
        'dev' || 'development' || 'debug' => dev,
        'prod' || 'production' || 'release' => prod,
        '' || 'null' => unknown,
        _ => fallback ?? unknown,
      };

  /// Value of the enum
  final String value;

  /// Pattern matching
  T map<T>({required T Function() dev, required T Function() prod, required T Function() unknown}) {
    switch (this) {
      case AppFlavorType.dev:
        return dev();
      case AppFlavorType.prod:
        return prod();
      case AppFlavorType.unknown:
        return unknown();
    }
  }

  /// Pattern matching
  T maybeMap<T>({
    required T Function() orElse,
    T Function()? dev,
    T Function()? prod,
    T Function()? unknown,
  }) => map<T>(dev: dev ?? orElse, prod: prod ?? orElse, unknown: unknown ?? orElse);

  /// Pattern matching
  T? maybeMapOrNull<T>({T Function()? dev, T Function()? prod, T Function()? unknown}) =>
      maybeMap<T?>(orElse: () => null, dev: dev, prod: prod, unknown: unknown);

  @override
  int compareTo(AppFlavorType other) => index.compareTo(other.index);

  @override
  String toString() => value;
}
