import 'package:formz/formz.dart';

enum NomeValidationError { invalid }
class NomeInput extends FormzInput<String, NomeValidationError> {
  const NomeInput.pure() : super.pure('');
  const NomeInput.dirty([String value = '']) : super.dirty(value);

  @override
  NomeValidationError? validator(String value) {
    return null;
  }
}

enum DescricaoValidationError { invalid }
class DescricaoInput extends FormzInput<String, DescricaoValidationError> {
  const DescricaoInput.pure() : super.pure('');
  const DescricaoInput.dirty([String value = '']) : super.dirty(value);

  @override
  DescricaoValidationError? validator(String value) {
    return null;
  }
}

enum ValorBaseValidationError { invalid }
class ValorBaseInput extends FormzInput<String, ValorBaseValidationError> {
  const ValorBaseInput.pure() : super.pure('');
  const ValorBaseInput.dirty([String value = '']) : super.dirty(value);

  @override
  ValorBaseValidationError? validator(String value) {
    return null;
  }
}

