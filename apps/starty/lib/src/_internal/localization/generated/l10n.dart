// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class StartyL10n {
  StartyL10n();

  static StartyL10n? _current;

  static StartyL10n get current {
    assert(
      _current != null,
      'No instance of StartyL10n was loaded. Try to initialize the StartyL10n delegate before accessing StartyL10n.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<StartyL10n> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = StartyL10n();
      StartyL10n._current = instance;

      return instance;
    });
  }

  static StartyL10n of(BuildContext context) {
    final instance = StartyL10n.maybeOf(context);
    assert(
      instance != null,
      'No instance of StartyL10n present in the widget tree. Did you add StartyL10n.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static StartyL10n? maybeOf(BuildContext context) {
    return Localizations.of<StartyL10n>(context, StartyL10n);
  }

  /// `GN`
  String get gn {
    return Intl.message('GN', name: 'gn', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<StartyL10n> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[Locale.fromSubtags(languageCode: 'en')];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<StartyL10n> load(Locale locale) => StartyL10n.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
