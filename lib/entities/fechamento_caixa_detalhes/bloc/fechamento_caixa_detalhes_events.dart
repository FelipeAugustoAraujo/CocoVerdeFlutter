part of 'fechamento_caixa_detalhes_bloc.dart';

abstract class FechamentoCaixaDetalhesEvent extends Equatable {
  const FechamentoCaixaDetalhesEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitFechamentoCaixaDetalhesList extends FechamentoCaixaDetalhesEvent {}


  
    class InitFechamentoCaixaDetalhesListByFechamentoCaixa extends FechamentoCaixaDetalhesEvent {
      final int fechamentoCaixaId;

      const InitFechamentoCaixaDetalhesListByFechamentoCaixa({required this.fechamentoCaixaId});

      @override
      List<Object> get props => [fechamentoCaixaId];
    }
  

  
    class InitFechamentoCaixaDetalhesListByEntradaFinanceira extends FechamentoCaixaDetalhesEvent {
      final int entradaFinanceiraId;

      const InitFechamentoCaixaDetalhesListByEntradaFinanceira({required this.entradaFinanceiraId});

      @override
      List<Object> get props => [entradaFinanceiraId];
    }
  

  
    class InitFechamentoCaixaDetalhesListBySaidaFinanceira extends FechamentoCaixaDetalhesEvent {
      final int saidaFinanceiraId;

      const InitFechamentoCaixaDetalhesListBySaidaFinanceira({required this.saidaFinanceiraId});

      @override
      List<Object> get props => [saidaFinanceiraId];
    }
  


class FechamentoCaixaDetalhesFormSubmitted extends FechamentoCaixaDetalhesEvent {}

class LoadFechamentoCaixaDetalhesByIdForEdit extends FechamentoCaixaDetalhesEvent {
  final int? id;

  const LoadFechamentoCaixaDetalhesByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteFechamentoCaixaDetalhesById extends FechamentoCaixaDetalhesEvent {
  final int? id;

  const DeleteFechamentoCaixaDetalhesById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadFechamentoCaixaDetalhesByIdForView extends FechamentoCaixaDetalhesEvent {
  final int? id;

  const LoadFechamentoCaixaDetalhesByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
