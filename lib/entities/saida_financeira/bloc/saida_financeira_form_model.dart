import 'package:formz/formz.dart';
import 'package:cocoverde/entities/saida_financeira/saida_financeira_model.dart';
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

enum ValorTotalValidationError { invalid }
class ValorTotalInput extends FormzInput<BigDecimal, ValorTotalValidationError> {
  const ValorTotalInput.pure() : super.pure('');
  const ValorTotalInput.dirty([BigDecimal value = '']) : super.dirty(value);

  @override
  ValorTotalValidationError? validator(BigDecimal value) {
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

enum MetodoPagamentoValidationError { invalid }
class MetodoPagamentoInput extends FormzInput<MetodoPagamento, MetodoPagamentoValidationError> {
  const MetodoPagamentoInput.pure() : super.pure(MetodoPagamento.DINHEIRO);
  const MetodoPagamentoInput.dirty(MetodoPagamento value) : super.dirty(value);

  @override
  MetodoPagamentoValidationError? validator(MetodoPagamento value) {
    return null;
  }
}

enum StatusPagamentoValidationError { invalid }
class StatusPagamentoInput extends FormzInput<StatusPagamento, StatusPagamentoValidationError> {
  const StatusPagamentoInput.pure() : super.pure(StatusPagamento.PAGO);
  const StatusPagamentoInput.dirty(StatusPagamento value) : super.dirty(value);

  @override
  StatusPagamentoValidationError? validator(StatusPagamento value) {
    return null;
  }
}

enum ResponsavelPagamentoValidationError { invalid }
class ResponsavelPagamentoInput extends FormzInput<ResponsavelPagamento, ResponsavelPagamentoValidationError> {
  const ResponsavelPagamentoInput.pure() : super.pure(ResponsavelPagamento.BARRACA);
  const ResponsavelPagamentoInput.dirty(ResponsavelPagamento value) : super.dirty(value);

  @override
  ResponsavelPagamentoValidationError? validator(ResponsavelPagamento value) {
    return null;
  }
}

