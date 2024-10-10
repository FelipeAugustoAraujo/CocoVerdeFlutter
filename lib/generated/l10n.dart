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

  /// `Coconut Water Store`
  String get appTitle {
    return Intl.message(
      'Coconut Water Store',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to our store!`
  String get welcomeMessage {
    return Intl.message(
      'Welcome to our store!',
      name: 'welcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `The name must be at least {min} characters long.`
  String pageRegisterLoginValidationError(Object min) {
    return Intl.message(
      'The name must be at least $min characters long.',
      name: 'pageRegisterLoginValidationError',
      desc: '',
      args: [min],
    );
  }

  /// `The last name must be at least {min} characters long.`
  String pageRegisterLastNameValidationError(Object min) {
    return Intl.message(
      'The last name must be at least $min characters long.',
      name: 'pageRegisterLastNameValidationError',
      desc: '',
      args: [min],
    );
  }

  /// `Please enter a valid email address.`
  String get pageRegisterMailValidationError {
    return Intl.message(
      'Please enter a valid email address.',
      name: 'pageRegisterMailValidationError',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least {min} characters long and include letters and numbers.`
  String pageRegisterPasswordValidationError(Object min) {
    return Intl.message(
      'Password must be at least $min characters long and include letters and numbers.',
      name: 'pageRegisterPasswordValidationError',
      desc: '',
      args: [min],
    );
  }

  /// `Confirmation password must match the password and be at least {min} characters long.`
  String pageRegisterConfirmationPasswordValidationError(Object min) {
    return Intl.message(
      'Confirmation password must match the password and be at least $min characters long.',
      name: 'pageRegisterConfirmationPasswordValidationError',
      desc: '',
      args: [min],
    );
  }

  /// `You must accept the terms and conditions.`
  String get pageRegisterTermsAndConditionsValidationError {
    return Intl.message(
      'You must accept the terms and conditions.',
      name: 'pageRegisterTermsAndConditionsValidationError',
      desc: '',
      args: [],
    );
  }

  /// `The first name must be at least {min} characters long.`
  String pageSettingsFirstnameErrorValidation(Object min) {
    return Intl.message(
      'The first name must be at least $min characters long.',
      name: 'pageSettingsFirstnameErrorValidation',
      desc: '',
      args: [min],
    );
  }

  /// `The last name must be at least {min} characters long.`
  String pageSettingsLastnameErrorValidation(Object min) {
    return Intl.message(
      'The last name must be at least $min characters long.',
      name: 'pageSettingsLastnameErrorValidation',
      desc: '',
      args: [min],
    );
  }

  /// `Please enter a valid email address.`
  String get pageSettingsEmailErrorValidation {
    return Intl.message(
      'Please enter a valid email address.',
      name: 'pageSettingsEmailErrorValidation',
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
      Locale.fromSubtags(languageCode: 'pt'),
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
