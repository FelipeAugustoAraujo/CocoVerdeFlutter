import 'package:formz/formz.dart';
import 'package:Cocoverde/generated/l10n.dart';


enum NamevalidationError { invalid }

extension NamevalidationErrorX on NamevalidationError {
String get invalidMessage =>S.current.pageRegisterLoginValidationError(NameInput.numberMin);
}

class NameInput extends FormzInput<String, NamevalidationError> {
  const NameInput.pure() : super.pure('');
  const NameInput.dirty([String value = '']) : super.dirty(value);

  static final int numberMin = 3;

  @override
  NamevalidationError? validator(String value) {
    return value.length >= 3 ? null : NamevalidationError.invalid;
  }
}

enum FirstNamevalidationError { invalid }

extension FirstNamevalidationErrorX on FirstNamevalidationError {
  String get invalidMessage =>S.current.pageRegisterLoginValidationError(FirstNameInput.numberMin);
}

class FirstNameInput extends FormzInput<String, FirstNamevalidationError> {
  const FirstNameInput.pure() : super.pure('');
  const FirstNameInput.dirty([String value = '']) : super.dirty(value);

  static final int numberMin = 3;

  @override
  FirstNamevalidationError? validator(String value) {
    return value.length >= 3 ? null : FirstNamevalidationError.invalid;
  }
}

enum LastNamevalidationError { invalid }

extension LastNamevalidationErrorX on LastNamevalidationError {
 
}

class LastNameInput extends FormzInput<String, LastNamevalidationError> {
  const LastNameInput.pure() : super.pure('');
  const LastNameInput.dirty([String value = '']) : super.dirty(value);

  static final int numberMin = 3;

  @override
  LastNamevalidationError? validator(String value) {
    return value.length >= 3 ? null : LastNamevalidationError.invalid;
  }
}

enum EmailValidationError { invalid }

extension EmailValidationErrorX on EmailValidationError {
String get invalidMessage =>S.current.pageRegisterMailValidationError;
}

class EmailInput extends FormzInput<String, EmailValidationError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([String value = '']) : super.dirty(value);

  @override
  EmailValidationError? validator(String value) {
    return value.contains('@') ? null : EmailValidationError.invalid;
  }
}

enum PasswordValidationError { invalid }

extension PasswordValidationErrorX on PasswordValidationError {
String get invalidMessage =>S.current.pageRegisterPasswordValidationError(PasswordInput.numberMin);
}

class PasswordInput extends FormzInput<String, PasswordValidationError> {
  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  static final int numberMin = 8;

  @override
  PasswordValidationError? validator(String value) {
    return _passwordRegex.hasMatch(value) ? null : PasswordValidationError.invalid;
  }
}

enum ConfirmPasswordValidationError { invalid }

extension ConfirmPasswordValidationErrorX on ConfirmPasswordValidationError {
String get invalidMessage =>S.current.pageRegisterConfirmationPasswordValidationError(ConfirmPasswordInput.numberMin);
}

class ConfirmPasswordInput extends FormzInput<String, ConfirmPasswordValidationError> {
  const ConfirmPasswordInput.pure() : super.pure('');
  const ConfirmPasswordInput.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  static final int numberMin = 8;

  @override
  ConfirmPasswordValidationError? validator(String value) {
    return _passwordRegex.hasMatch(value) ? null : ConfirmPasswordValidationError.invalid;
  }
}

enum TermsAndConditionsValidationError { invalid }

class TermsAndConditionsInput extends FormzInput<bool, TermsAndConditionsValidationError> {
  const TermsAndConditionsInput.pure() : super.pure(false);
  const TermsAndConditionsInput.dirty([bool value = false]) : super.dirty(value);

  @override
  TermsAndConditionsValidationError? validator(bool value) {
    return value ? null : TermsAndConditionsValidationError.invalid;
  }
}
