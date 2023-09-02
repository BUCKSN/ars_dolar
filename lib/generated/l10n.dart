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

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Error, server or data not found!`
  String get error_message {
    return Intl.message(
      'Error, server or data not found!',
      name: 'error_message',
      desc: '',
      args: [],
    );
  }

  /// `Something worng!`
  String get unknown_error {
    return Intl.message(
      'Something worng!',
      name: 'unknown_error',
      desc: '',
      args: [],
    );
  }

  /// `Receivable:`
  String get amount_receivable {
    return Intl.message(
      'Receivable:',
      name: 'amount_receivable',
      desc: '',
      args: [],
    );
  }

  /// `Dollar blue`
  String get dollar_blue {
    return Intl.message(
      'Dollar blue',
      name: 'dollar_blue',
      desc: '',
      args: [],
    );
  }

  /// `Dollar oficial`
  String get dollar_oficial {
    return Intl.message(
      'Dollar oficial',
      name: 'dollar_oficial',
      desc: '',
      args: [],
    );
  }

  /// `Dollar purse`
  String get dollar_purse {
    return Intl.message(
      'Dollar purse',
      name: 'dollar_purse',
      desc: '',
      args: [],
    );
  }

  /// `Counted with liquid`
  String get counted_with_liquid {
    return Intl.message(
      'Counted with liquid',
      name: 'counted_with_liquid',
      desc: '',
      args: [],
    );
  }

  /// `Crypto dollar`
  String get crypto_dollar {
    return Intl.message(
      'Crypto dollar',
      name: 'crypto_dollar',
      desc: '',
      args: [],
    );
  }

  /// `Tourist Dollar`
  String get tourist_dollar {
    return Intl.message(
      'Tourist Dollar',
      name: 'tourist_dollar',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
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
