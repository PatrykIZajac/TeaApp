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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome to`
  String get WelcomeText {
    return Intl.message(
      'Welcome to',
      name: 'WelcomeText',
      desc: '',
      args: [],
    );
  }

  /// `Tea Shop`
  String get ShopNameText {
    return Intl.message(
      'Tea Shop',
      name: 'ShopNameText',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get SearchText {
    return Intl.message(
      'Search',
      name: 'SearchText',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get LanguageText {
    return Intl.message(
      'Language',
      name: 'LanguageText',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get PopularText {
    return Intl.message(
      'Popular',
      name: 'PopularText',
      desc: '',
      args: [],
    );
  }

  /// `China`
  String get ChinaText {
    return Intl.message(
      'China',
      name: 'ChinaText',
      desc: '',
      args: [],
    );
  }

  /// `India`
  String get IndiaText {
    return Intl.message(
      'India',
      name: 'IndiaText',
      desc: '',
      args: [],
    );
  }

  /// `Sri Lanka`
  String get SriLankaText {
    return Intl.message(
      'Sri Lanka',
      name: 'SriLankaText',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get CurrencyText {
    return Intl.message(
      'Currency',
      name: 'CurrencyText',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get FavoriteText {
    return Intl.message(
      'Favorites',
      name: 'FavoriteText',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get SettingsText {
    return Intl.message(
      'Settings',
      name: 'SettingsText',
      desc: '',
      args: [],
    );
  }

  /// `Continue payment`
  String get ContinuePaymentText {
    return Intl.message(
      'Continue payment',
      name: 'ContinuePaymentText',
      desc: '',
      args: [],
    );
  }

  /// `Shopping cart`
  String get ShoppingCartText {
    return Intl.message(
      'Shopping cart',
      name: 'ShoppingCartText',
      desc: '',
      args: [],
    );
  }

  /// `qty.`
  String get QuantityCartItem {
    return Intl.message(
      'qty.',
      name: 'QuantityCartItem',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get AddToCartText {
    return Intl.message(
      'Add to cart',
      name: 'AddToCartText',
      desc: '',
      args: [],
    );
  }

  /// `Amount of`
  String get AmountInAlertDialogText {
    return Intl.message(
      'Amount of',
      name: 'AmountInAlertDialogText',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get AcceptButtonInAlertDialogText {
    return Intl.message(
      'Accept',
      name: 'AcceptButtonInAlertDialogText',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get CancelButtonInAlertDialogText {
    return Intl.message(
      'Cancel',
      name: 'CancelButtonInAlertDialogText',
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
      Locale.fromSubtags(languageCode: 'pl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}