import 'package:formz/formz.dart';
import 'package:cocoverde/entities/frente/frente_model.dart';
import 'package:time_machine/time_machine.dart';

enum QuantidadeValidationError { invalid }
class QuantidadeInput extends FormzInput<int, QuantidadeValidationError> {
  const QuantidadeInput.pure() : super.pure(0);
  const QuantidadeInput.dirty([int value = 0]) : super.dirty(value);

  @override
  QuantidadeValidationError? validator(int value) {
    return null;
  }
}

enum CriadoEmValidationError { invalid }
class CriadoEmInput extends FormzInput<Instant, CriadoEmValidationError> {
  const CriadoEmInput.pure() : super.pure(Instant.unixEpoch);
  const CriadoEmInput.dirty(Instant value) : super.dirty(value);

  @override
  CriadoEmValidationError? validator(Instant value) {
    return null;
  }
}

enum ModificadoEmValidationError { invalid }
class ModificadoEmInput extends FormzInput<Instant, ModificadoEmValidationError> {
  const ModificadoEmInput.pure() : super.pure(Instant.unixEpoch);
  const ModificadoEmInput.dirty(Instant value) : super.dirty(value);

  @override
  ModificadoEmValidationError? validator(Instant value) {
    return null;
  }
}

