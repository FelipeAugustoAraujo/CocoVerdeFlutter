// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt locale. All the
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
  String get localeName => 'pt';

  static String m0(min) =>
      "A senha de confirmação deve corresponder à senha e ter pelo menos ${min} caracteres.";

  static String m1(min) => "O sobrenome deve ter pelo menos ${min} caracteres.";

  static String m2(min) => "O nome deve ter pelo menos ${min} caracteres.";

  static String m3(min) =>
      "A senha deve ter pelo menos ${min} caracteres e incluir letras e números.";

  static String m4(min) =>
      "O primeiro nome deve ter pelo menos ${min} caracteres.";

  static String m5(min) => "O sobrenome deve ter pelo menos ${min} caracteres.";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appTitle":
            MessageLookupByLibrary.simpleMessage("Loja de Água de Coco"),
        "pageRegisterConfirmationPasswordValidationError": m0,
        "pageRegisterLastNameValidationError": m1,
        "pageRegisterLoginValidationError": m2,
        "pageRegisterMailValidationError": MessageLookupByLibrary.simpleMessage(
            "Por favor, insira um endereço de e-mail válido."),
        "pageRegisterPasswordValidationError": m3,
        "pageRegisterTermsAndConditionsValidationError":
            MessageLookupByLibrary.simpleMessage(
                "Você deve aceitar os termos e condições."),
        "pageSettingsEmailErrorValidation":
            MessageLookupByLibrary.simpleMessage(
                "Por favor, insira um endereço de e-mail válido."),
        "pageSettingsFirstnameErrorValidation": m4,
        "pageSettingsLastnameErrorValidation": m5,
        "welcomeMessage":
            MessageLookupByLibrary.simpleMessage("Bem-vindo à nossa loja!")
      };
}
