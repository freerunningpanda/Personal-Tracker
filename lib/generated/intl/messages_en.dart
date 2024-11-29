// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(category) =>
      "Limit is higher than value in ${category} category";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addSome": MessageLookupByLibrary.simpleMessage("add some..."),
        "all": MessageLookupByLibrary.simpleMessage("context.tr.all"),
        "amount": MessageLookupByLibrary.simpleMessage("Amount:"),
        "analysisIsEmpty":
            MessageLookupByLibrary.simpleMessage("Analysis is empty"),
        "analytics": MessageLookupByLibrary.simpleMessage("Analytics"),
        "apply": MessageLookupByLibrary.simpleMessage("Apply"),
        "attention": MessageLookupByLibrary.simpleMessage("Attention!"),
        "cannotBeNegative":
            MessageLookupByLibrary.simpleMessage("Cannot be negative"),
        "category": MessageLookupByLibrary.simpleMessage("Category:"),
        "create": MessageLookupByLibrary.simpleMessage("Create"),
        "createATransaction":
            MessageLookupByLibrary.simpleMessage("Add a transaction"),
        "date": MessageLookupByLibrary.simpleMessage("Date"),
        "education": MessageLookupByLibrary.simpleMessage("Education"),
        "entertainment": MessageLookupByLibrary.simpleMessage("Entertainment"),
        "exceededTheLimit": m0,
        "expense": MessageLookupByLibrary.simpleMessage("expense"),
        "food": MessageLookupByLibrary.simpleMessage("Food"),
        "fromLess": MessageLookupByLibrary.simpleMessage("from less"),
        "fromMore": MessageLookupByLibrary.simpleMessage("from more"),
        "health": MessageLookupByLibrary.simpleMessage("Health"),
        "income": MessageLookupByLibrary.simpleMessage("income"),
        "limit": MessageLookupByLibrary.simpleMessage("Limit"),
        "noTransactionsYet":
            MessageLookupByLibrary.simpleMessage("No transactions yet"),
        "other": MessageLookupByLibrary.simpleMessage("Other"),
        "pleaseAddSomeTransactions": MessageLookupByLibrary.simpleMessage(
            "Please add some transactions"),
        "pleaseEnterATitle":
            MessageLookupByLibrary.simpleMessage("Please enter a title"),
        "pleaseEnterAValue":
            MessageLookupByLibrary.simpleMessage("Please enter a value"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "shopping": MessageLookupByLibrary.simpleMessage("Shopping"),
        "title": MessageLookupByLibrary.simpleMessage("Title"),
        "transactions": MessageLookupByLibrary.simpleMessage("Transactions"),
        "transport": MessageLookupByLibrary.simpleMessage("Transport"),
        "travelling": MessageLookupByLibrary.simpleMessage("Travelling"),
        "type": MessageLookupByLibrary.simpleMessage("Type:"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "updateATransaction":
            MessageLookupByLibrary.simpleMessage("Update a transaction"),
        "value": MessageLookupByLibrary.simpleMessage("Value")
      };
}
