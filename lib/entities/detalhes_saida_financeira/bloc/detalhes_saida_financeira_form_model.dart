import 'package:formz/formz.dart';

enum QuantidadeItemValidationError { invalid }
class QuantidadeItemInput extends FormzInput<int, QuantidadeItemValidationError> {
  const QuantidadeItemInput.pure() : super.pure(0);
  const QuantidadeItemInput.dirty([int value = 0]) : super.dirty(value);

  @override
  QuantidadeItemValidationError? validator(int value) {
    return null;
  }
}

enum ValorValidationError { invalid }
class ValorInput extends FormzInput<BigDecimal, ValorValidationError> {
  const ValorInput.pure() : super.pure('');
  const ValorInput.dirty([BigDecimal value = '']) : super.dirty(value);

  @override
  ValorValidationError? validator(BigDecimal value) {
    return null;
  }
}

