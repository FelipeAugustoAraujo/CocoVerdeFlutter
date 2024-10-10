import 'package:formz/formz.dart';
import 'package:time_machine/time_machine.dart';

enum DataInicialValidationError { invalid }
class DataInicialInput extends FormzInput<Instant, DataInicialValidationError> {
  const DataInicialInput.pure() : super.pure(Instant.unixEpoch);
  const DataInicialInput.dirty(Instant value) : super.dirty(value);

  @override
  DataInicialValidationError? validator(Instant value) {
    return null;
  }
}

enum DataFinalValidationError { invalid }
class DataFinalInput extends FormzInput<Instant, DataFinalValidationError> {
  const DataFinalInput.pure() : super.pure(Instant.unixEpoch);
  const DataFinalInput.dirty(Instant value) : super.dirty(value);

  @override
  DataFinalValidationError? validator(Instant value) {
    return null;
  }
}

enum QuantidadeCocosPerdidosValidationError { invalid }
class QuantidadeCocosPerdidosInput extends FormzInput<int, QuantidadeCocosPerdidosValidationError> {
  const QuantidadeCocosPerdidosInput.pure() : super.pure(0);
  const QuantidadeCocosPerdidosInput.dirty([int value = 0]) : super.dirty(value);

  @override
  QuantidadeCocosPerdidosValidationError? validator(int value) {
    return null;
  }
}

enum QuantidadeCocosVendidosValidationError { invalid }
class QuantidadeCocosVendidosInput extends FormzInput<int, QuantidadeCocosVendidosValidationError> {
  const QuantidadeCocosVendidosInput.pure() : super.pure(0);
  const QuantidadeCocosVendidosInput.dirty([int value = 0]) : super.dirty(value);

  @override
  QuantidadeCocosVendidosValidationError? validator(int value) {
    return null;
  }
}

enum QuantidadeCocoSobrouValidationError { invalid }
class QuantidadeCocoSobrouInput extends FormzInput<int, QuantidadeCocoSobrouValidationError> {
  const QuantidadeCocoSobrouInput.pure() : super.pure(0);
  const QuantidadeCocoSobrouInput.dirty([int value = 0]) : super.dirty(value);

  @override
  QuantidadeCocoSobrouValidationError? validator(int value) {
    return null;
  }
}

enum DivididoPorValidationError { invalid }
class DivididoPorInput extends FormzInput<int, DivididoPorValidationError> {
  const DivididoPorInput.pure() : super.pure(0);
  const DivididoPorInput.dirty([int value = 0]) : super.dirty(value);

  @override
  DivididoPorValidationError? validator(int value) {
    return null;
  }
}

enum ValorTotalCocoValidationError { invalid }
class ValorTotalCocoInput extends FormzInput<BigDecimal, ValorTotalCocoValidationError> {
  const ValorTotalCocoInput.pure() : super.pure('');
  const ValorTotalCocoInput.dirty([BigDecimal value = '']) : super.dirty(value);

  @override
  ValorTotalCocoValidationError? validator(BigDecimal value) {
    return null;
  }
}

enum ValorTotalCocoPerdidoValidationError { invalid }
class ValorTotalCocoPerdidoInput extends FormzInput<BigDecimal, ValorTotalCocoPerdidoValidationError> {
  const ValorTotalCocoPerdidoInput.pure() : super.pure('');
  const ValorTotalCocoPerdidoInput.dirty([BigDecimal value = '']) : super.dirty(value);

  @override
  ValorTotalCocoPerdidoValidationError? validator(BigDecimal value) {
    return null;
  }
}

enum ValorPorPessoaValidationError { invalid }
class ValorPorPessoaInput extends FormzInput<BigDecimal, ValorPorPessoaValidationError> {
  const ValorPorPessoaInput.pure() : super.pure('');
  const ValorPorPessoaInput.dirty([BigDecimal value = '']) : super.dirty(value);

  @override
  ValorPorPessoaValidationError? validator(BigDecimal value) {
    return null;
  }
}

enum ValorDespesasValidationError { invalid }
class ValorDespesasInput extends FormzInput<BigDecimal, ValorDespesasValidationError> {
  const ValorDespesasInput.pure() : super.pure('');
  const ValorDespesasInput.dirty([BigDecimal value = '']) : super.dirty(value);

  @override
  ValorDespesasValidationError? validator(BigDecimal value) {
    return null;
  }
}

enum ValorDinheiroValidationError { invalid }
class ValorDinheiroInput extends FormzInput<BigDecimal, ValorDinheiroValidationError> {
  const ValorDinheiroInput.pure() : super.pure('');
  const ValorDinheiroInput.dirty([BigDecimal value = '']) : super.dirty(value);

  @override
  ValorDinheiroValidationError? validator(BigDecimal value) {
    return null;
  }
}

enum ValorCartaoValidationError { invalid }
class ValorCartaoInput extends FormzInput<BigDecimal, ValorCartaoValidationError> {
  const ValorCartaoInput.pure() : super.pure('');
  const ValorCartaoInput.dirty([BigDecimal value = '']) : super.dirty(value);

  @override
  ValorCartaoValidationError? validator(BigDecimal value) {
    return null;
  }
}

enum ValorTotalValidationError { invalid }
class ValorTotalInput extends FormzInput<BigDecimal, ValorTotalValidationError> {
  const ValorTotalInput.pure() : super.pure('');
  const ValorTotalInput.dirty([BigDecimal value = '']) : super.dirty(value);

  @override
  ValorTotalValidationError? validator(BigDecimal value) {
    return null;
  }
}

