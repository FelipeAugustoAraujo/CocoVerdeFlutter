part of 'detalhes_saida_financeira_bloc.dart';

abstract class DetalhesSaidaFinanceiraEvent extends Equatable {
  const DetalhesSaidaFinanceiraEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitDetalhesSaidaFinanceiraList extends DetalhesSaidaFinanceiraEvent {}


class QuantidadeItemChanged extends DetalhesSaidaFinanceiraEvent {
  final int quantidadeItem;

  const QuantidadeItemChanged({required this.quantidadeItem});

  @override
  List<Object> get props => [quantidadeItem];
}
class ValorChanged extends DetalhesSaidaFinanceiraEvent {
  final BigDecimal valor;

  const ValorChanged({required this.valor});

  @override
  List<Object> get props => [valor];
}

class DetalhesSaidaFinanceiraFormSubmitted extends DetalhesSaidaFinanceiraEvent {}

class LoadDetalhesSaidaFinanceiraByIdForEdit extends DetalhesSaidaFinanceiraEvent {
  final int? id;

  const LoadDetalhesSaidaFinanceiraByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteDetalhesSaidaFinanceiraById extends DetalhesSaidaFinanceiraEvent {
  final int? id;

  const DeleteDetalhesSaidaFinanceiraById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadDetalhesSaidaFinanceiraByIdForView extends DetalhesSaidaFinanceiraEvent {
  final int? id;

  const LoadDetalhesSaidaFinanceiraByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
