import 'package:formz/formz.dart';
import 'package:cocoverde/entities/dia_trabalho/dia_trabalho_model.dart';
import 'package:time_machine/time_machine.dart';

enum DataValidationError { invalid }
class DataInput extends FormzInput<Instant, DataValidationError> {
  const DataInput.pure() : super.pure(Instant.unixEpoch);
  const DataInput.dirty(Instant value) : super.dirty(value);

  @override
  DataValidationError? validator(Instant value) {
    return null;
  }
}

