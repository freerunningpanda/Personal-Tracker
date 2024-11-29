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

  /// `Transactions`
  String get transactions {
    return Intl.message(
      'Transactions',
      name: 'transactions',
      desc: 'The title of the transactions page',
      args: [],
    );
  }

  /// `Analytics`
  String get analytics {
    return Intl.message(
      'Analytics',
      name: 'analytics',
      desc: 'The title of the analytics page',
      args: [],
    );
  }

  /// `No transactions yet`
  String get noTransactionsYet {
    return Intl.message(
      'No transactions yet',
      name: 'noTransactionsYet',
      desc: 'The message displayed when there are no transactions',
      args: [],
    );
  }

  /// `Update a transaction`
  String get updateATransaction {
    return Intl.message(
      'Update a transaction',
      name: 'updateATransaction',
      desc: 'The title of the update transaction page',
      args: [],
    );
  }

  /// `Add a transaction`
  String get createATransaction {
    return Intl.message(
      'Add a transaction',
      name: 'createATransaction',
      desc: 'The title of the create transaction page',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: 'The text of the create button',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: 'The text of the update button',
      args: [],
    );
  }

  /// `Value`
  String get value {
    return Intl.message(
      'Value',
      name: 'value',
      desc: 'The label of the value input',
      args: [],
    );
  }

  /// `Please enter a value`
  String get pleaseEnterAValue {
    return Intl.message(
      'Please enter a value',
      name: 'pleaseEnterAValue',
      desc: 'The message displayed when the value input is empty',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: 'The label of the date input',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: 'The label of the title input',
      args: [],
    );
  }

  /// `Please enter a title`
  String get pleaseEnterATitle {
    return Intl.message(
      'Please enter a title',
      name: 'pleaseEnterATitle',
      desc: 'The message displayed when the title input is empty',
      args: [],
    );
  }

  /// `from less`
  String get fromLess {
    return Intl.message(
      'from less',
      name: 'fromLess',
      desc: 'The label of the from less input',
      args: [],
    );
  }

  /// `from more`
  String get fromMore {
    return Intl.message(
      'from more',
      name: 'fromMore',
      desc: 'The label of the from more input',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: 'The text of the apply button',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: 'The text of the search button',
      args: [],
    );
  }

  /// `add some...`
  String get addSome {
    return Intl.message(
      'add some...',
      name: 'addSome',
      desc: 'The text of the add some button',
      args: [],
    );
  }

  /// `Analysis is empty`
  String get analysisIsEmpty {
    return Intl.message(
      'Analysis is empty',
      name: 'analysisIsEmpty',
      desc: 'The message displayed when the analysis is empty',
      args: [],
    );
  }

  /// `Please add some transactions`
  String get pleaseAddSomeTransactions {
    return Intl.message(
      'Please add some transactions',
      name: 'pleaseAddSomeTransactions',
      desc: 'The message displayed when there are no transactions',
      args: [],
    );
  }

  /// `Limit`
  String get limit {
    return Intl.message(
      'Limit',
      name: 'limit',
      desc: 'The label of the limit input',
      args: [],
    );
  }

  /// `Cannot be negative`
  String get cannotBeNegative {
    return Intl.message(
      'Cannot be negative',
      name: 'cannotBeNegative',
      desc: 'The message displayed when the limit input is negative',
      args: [],
    );
  }

  /// `Limit is higher than value in {category} category`
  String exceededTheLimit(Object category) {
    return Intl.message(
      'Limit is higher than value in $category category',
      name: 'exceededTheLimit',
      desc:
          'The message displayed when the limit is higher than the value in a category',
      args: [category],
    );
  }

  /// `Attention!`
  String get attention {
    return Intl.message(
      'Attention!',
      name: 'attention',
      desc: 'The title of the attention message',
      args: [],
    );
  }

  /// `expense`
  String get expense {
    return Intl.message(
      'expense',
      name: 'expense',
      desc: 'The label of the expense radio button',
      args: [],
    );
  }

  /// `income`
  String get income {
    return Intl.message(
      'income',
      name: 'income',
      desc: 'The label of the income radio button',
      args: [],
    );
  }

  /// `context.tr.all`
  String get all {
    return Intl.message(
      'context.tr.all',
      name: 'all',
      desc: 'The label of the all radio button',
      args: [],
    );
  }

  /// `Food`
  String get food {
    return Intl.message(
      'Food',
      name: 'food',
      desc: 'The label of the food category',
      args: [],
    );
  }

  /// `Travelling`
  String get travelling {
    return Intl.message(
      'Travelling',
      name: 'travelling',
      desc: 'The label of the travelling category',
      args: [],
    );
  }

  /// `Transport`
  String get transport {
    return Intl.message(
      'Transport',
      name: 'transport',
      desc: 'The label of the transport category',
      args: [],
    );
  }

  /// `Shopping`
  String get shopping {
    return Intl.message(
      'Shopping',
      name: 'shopping',
      desc: 'The label of the shopping category',
      args: [],
    );
  }

  /// `Health`
  String get health {
    return Intl.message(
      'Health',
      name: 'health',
      desc: 'The label of the health category',
      args: [],
    );
  }

  /// `Entertainment`
  String get entertainment {
    return Intl.message(
      'Entertainment',
      name: 'entertainment',
      desc: 'The label of the entertainment category',
      args: [],
    );
  }

  /// `Education`
  String get education {
    return Intl.message(
      'Education',
      name: 'education',
      desc: 'The label of the education category',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: 'The label of the other category',
      args: [],
    );
  }

  /// `Category:`
  String get category {
    return Intl.message(
      'Category:',
      name: 'category',
      desc: 'The label of the category input',
      args: [],
    );
  }

  /// `Type:`
  String get type {
    return Intl.message(
      'Type:',
      name: 'type',
      desc: 'The label of the type input',
      args: [],
    );
  }

  /// `Amount:`
  String get amount {
    return Intl.message(
      'Amount:',
      name: 'amount',
      desc: 'The label of the amount input',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
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
