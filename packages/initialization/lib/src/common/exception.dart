/// {@template dependency_initialization_exception}
/// DependencyInitializationException.
/// {@endtemplate}
final class DependencyInitializationException implements Exception {
  /// {@macro dependency_initialization_exception}
  const DependencyInitializationException(this.message);

  final String message;

  @override
  String toString() => 'DependencyInitializationException: $message';
}
