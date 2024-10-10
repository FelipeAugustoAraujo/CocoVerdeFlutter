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

  static String m0(min) =>
      "Confirmation password must match the password and be at least ${min} characters long.";

  static String m1(min) =>
      "The last name must be at least ${min} characters long.";

  static String m2(min) => "The name must be at least ${min} characters long.";

  static String m3(min) =>
      "Password must be at least ${min} characters long and include letters and numbers.";

  static String m4(min) =>
      "The first name must be at least ${min} characters long.";

  static String m5(min) =>
      "The last name must be at least ${min} characters long.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appTitle": MessageLookupByLibrary.simpleMessage("Coconut Water Store"),
        "pageRegisterConfirmationPasswordValidationError": m0,
        "pageRegisterLastNameValidationError": m1,
        "pageRegisterLoginValidationError": m2,
        "pageRegisterMailValidationError": MessageLookupByLibrary.simpleMessage(
            "Please enter a valid email address."),
        "pageRegisterPasswordValidationError": m3,
        "pageRegisterTermsAndConditionsValidationError":
            MessageLookupByLibrary.simpleMessage(
                "You must accept the terms and conditions."),
        "pageSettingsEmailErrorValidation":
            MessageLookupByLibrary.simpleMessage(
                "Please enter a valid email address."),
        "pageSettingsFirstnameErrorValidation": m4,
        "pageSettingsLastnameErrorValidation": m5,
        "welcomeMessage":
            MessageLookupByLibrary.simpleMessage("Welcome to our store!")
      };
}
