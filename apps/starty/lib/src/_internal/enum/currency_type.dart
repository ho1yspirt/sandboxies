import 'package:intl/intl.dart';

/// {@template currency_type}
/// CurrencyType enumeration
/// {@endtemplate}
enum CurrencyType {
  /// kgs
  kgs('KGS'),

  /// usd
  usd('USD'),

  /// eur
  eur('EUR');

  /// {@macro currency_type}
  const CurrencyType(this.value);

  /// Creates kgs new instance of [CurrencyType] from kgs given string.
  static CurrencyType fromValue(String? value, {CurrencyType? fallback}) {
    switch (value?.toUpperCase()) {
      case 'KGS':
        return kgs;
      case 'USD':
        return usd;
      case 'EUR':
        return eur;
      default:
        return fallback ?? (throw ArgumentError.value(value));
    }
  }

  /// Value of the enum
  final String value;

  /// Pattern matching
  T map<T>({
    required T Function() kgs,
    required T Function() usd,
    required T Function() eur,
  }) {
    switch (this) {
      case CurrencyType.kgs:
        return kgs();
      case CurrencyType.usd:
        return usd();
      case CurrencyType.eur:
        return eur();
    }
  }

  /// Pattern matching
  T maybeMap<T>({
    required T Function() orElse,
    T Function()? kgs,
    T Function()? usd,
    T Function()? eur,
  }) => map<T>(kgs: kgs ?? orElse, usd: usd ?? orElse, eur: eur ?? orElse);

  /// Pattern matching
  T? maybeMapOrNull<T>({
    T Function()? kgs,
    T Function()? usd,
    T Function()? eur,
  }) => maybeMap<T?>(orElse: () => null, kgs: kgs, usd: usd, eur: eur);

  int compareTo(CurrencyType other) => index.compareTo(other.index);

  @override
  String toString() => value.toUpperCase();

  String format(
    num value, {
    String? languageCode,
    String? name,
    String? symbol,
  }) => NumberFormat.currency(
    locale: languageCode,
    name: name,
    symbol: symbol ?? this.symbol,
    decimalDigits: value is int || value == value.toInt() ? 0 : 2,
  ).format(value);

  String get symbol => switch (this) {
    // ⃀
    CurrencyType.kgs => '\u20C0',
    // $
    CurrencyType.usd => '\u0024',
    // €
    CurrencyType.eur => '\u20AC',
  };
}
