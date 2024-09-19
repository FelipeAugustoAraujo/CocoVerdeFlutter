import 'package:formz/formz.dart';
import 'package:cocoverde/entities/endereco/endereco_model.dart';
import 'package:time_machine/time_machine.dart';

enum CepValidationError { invalid }
class CepInput extends FormzInput<String, CepValidationError> {
  const CepInput.pure() : super.pure('');
  const CepInput.dirty([String value = '']) : super.dirty(value);

  @override
  CepValidationError? validator(String value) {
    return null;
  }
}

enum LogradouroValidationError { invalid }
class LogradouroInput extends FormzInput<String, LogradouroValidationError> {
  const LogradouroInput.pure() : super.pure('');
  const LogradouroInput.dirty([String value = '']) : super.dirty(value);

  @override
  LogradouroValidationError? validator(String value) {
    return null;
  }
}

enum NumeroValidationError { invalid }
class NumeroInput extends FormzInput<int, NumeroValidationError> {
  const NumeroInput.pure() : super.pure(0);
  const NumeroInput.dirty([int value = 0]) : super.dirty(value);

  @override
  NumeroValidationError? validator(int value) {
    return null;
  }
}

enum ComplementoValidationError { invalid }
class ComplementoInput extends FormzInput<String, ComplementoValidationError> {
  const ComplementoInput.pure() : super.pure('');
  const ComplementoInput.dirty([String value = '']) : super.dirty(value);

  @override
  ComplementoValidationError? validator(String value) {
    return null;
  }
}

enum BairroValidationError { invalid }
class BairroInput extends FormzInput<String, BairroValidationError> {
  const BairroInput.pure() : super.pure('');
  const BairroInput.dirty([String value = '']) : super.dirty(value);

  @override
  BairroValidationError? validator(String value) {
    return null;
  }
}

