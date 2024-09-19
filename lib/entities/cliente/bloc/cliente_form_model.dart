import 'package:formz/formz.dart';
import 'package:cocoverde/entities/cliente/cliente_model.dart';
import 'package:time_machine/time_machine.dart';

enum NomeValidationError { invalid }
class NomeInput extends FormzInput<String, NomeValidationError> {
  const NomeInput.pure() : super.pure('');
  const NomeInput.dirty([String value = '']) : super.dirty(value);

  @override
  NomeValidationError? validator(String value) {
    return null;
  }
}

enum DataNascimentoValidationError { invalid }
class DataNascimentoInput extends FormzInput<String, DataNascimentoValidationError> {
  const DataNascimentoInput.pure() : super.pure('');
  const DataNascimentoInput.dirty([String value = '']) : super.dirty(value);

  @override
  DataNascimentoValidationError? validator(String value) {
    return null;
  }
}

enum IdentificadorValidationError { invalid }
class IdentificadorInput extends FormzInput<String, IdentificadorValidationError> {
  const IdentificadorInput.pure() : super.pure('');
  const IdentificadorInput.dirty([String value = '']) : super.dirty(value);

  @override
  IdentificadorValidationError? validator(String value) {
    return null;
  }
}

enum DataCadastroValidationError { invalid }
class DataCadastroInput extends FormzInput<Instant, DataCadastroValidationError> {
  const DataCadastroInput.pure() : super.pure(Instant.unixEpoch);
  const DataCadastroInput.dirty(Instant value) : super.dirty(value);

  @override
  DataCadastroValidationError? validator(Instant value) {
    return null;
  }
}

enum TelefoneValidationError { invalid }
class TelefoneInput extends FormzInput<String, TelefoneValidationError> {
  const TelefoneInput.pure() : super.pure('');
  const TelefoneInput.dirty([String value = '']) : super.dirty(value);

  @override
  TelefoneValidationError? validator(String value) {
    return null;
  }
}

