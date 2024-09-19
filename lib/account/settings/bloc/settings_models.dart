import 'package:formz/formz.dart';
import 'package:Cocoverde/generated/l10n.dart';

enum FirstNameValidationError { invalid }

extension FirstnameValidationErrorX on FirstNameValidationError {
String get invalidMessage =>S.current.pageSettingsFirstnameErrorValidation(FirstNameInput.numberMin);
}

class FirstNameInput extends FormzInput<String, FirstNameValidationError> {
  const FirstNameInput.pure() : super.pure('');
  const FirstNameInput.dirty([String value = '']) : super.dirty(value);

  static int numberMin = 3;

  @override
  FirstNameValidationError? validator(String value) {
    if(value.isEmpty == false){
      return value.length >= numberMin ? null : FirstNameValidationError.invalid;
    } else {
      return null;
    }
  }
}

enum LastNameValidationError { invalid }

extension LastnameValidationErrorX on LastNameValidationError {
String get invalidMessage =>S.current.pageSettingsLastnameErrorValidation(LastNameInput.numberMin);
}

class LastNameInput extends FormzInput<String, LastNameValidationError> {
  const LastNameInput.pure() : super.pure('');
  const LastNameInput.dirty([String value = '']) : super.dirty(value);

  static int numberMin = 3;

  @override
  LastNameValidationError? validator(String value) {
    if(value.isEmpty == false){
      return value.length >= numberMin ? null : LastNameValidationError.invalid;
    } else {
      return null;
    }
  }
}

enum EmailValidationError { invalid }

extension EmailValidationErrorX on EmailValidationError {
  String get invalidMessage =>S.current.pageSettingsEmailErrorValidation;
}

class EmailInput extends FormzInput<String, EmailValidationError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String value) {
    return value.contains('@') ? null : EmailValidationError.invalid;
  }
}
