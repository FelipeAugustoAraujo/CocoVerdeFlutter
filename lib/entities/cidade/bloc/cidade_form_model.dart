import 'package:formz/formz.dart';
import 'package:Cocoverde/entities/cidade/cidade_model.dart';

enum NomeValidationError { invalid }
class NomeInput extends FormzInput<String, NomeValidationError> {
  const NomeInput.pure() : super.pure('');
  const NomeInput.dirty([String value = '']) : super.dirty(value);

  @override
  NomeValidationError? validator(String value) {
    return null;
  }
}

enum EstadoValidationError { invalid }
class EstadoInput extends FormzInput<Estado, EstadoValidationError> {
  const EstadoInput.pure() : super.pure(Estado.ACRE (Acre));
  const EstadoInput.dirty(Estado value) : super.dirty(value);

  @override
  EstadoValidationError? validator(Estado value) {
    return null;
  }
}

