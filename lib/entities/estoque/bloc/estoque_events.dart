part of 'estoque_bloc.dart';

abstract class EstoqueEvent extends Equatable {
  const EstoqueEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitEstoqueList extends EstoqueEvent {}


  
    class InitEstoqueListByProduto extends EstoqueEvent {
      final int produtoId;

      const InitEstoqueListByProduto({required this.produtoId});

      @override
      List<Object> get props => [produtoId];
    }
  

  
    class InitEstoqueListByEntradaFinanceira extends EstoqueEvent {
      final int entradaFinanceiraId;

      const InitEstoqueListByEntradaFinanceira({required this.entradaFinanceiraId});

      @override
      List<Object> get props => [entradaFinanceiraId];
    }
  

  
    class InitEstoqueListBySaidaFinanceira extends EstoqueEvent {
      final int saidaFinanceiraId;

      const InitEstoqueListBySaidaFinanceira({required this.saidaFinanceiraId});

      @override
      List<Object> get props => [saidaFinanceiraId];
    }
  

class QuantidadeChanged extends EstoqueEvent {
  final int quantidade;

  const QuantidadeChanged({required this.quantidade});

  @override
  List<Object> get props => [quantidade];
}
class CriadoEmChanged extends EstoqueEvent {
  final Instant criadoEm;

  const CriadoEmChanged({required this.criadoEm});

  @override
  List<Object> get props => [criadoEm];
}
class ModificadoEmChanged extends EstoqueEvent {
  final Instant modificadoEm;

  const ModificadoEmChanged({required this.modificadoEm});

  @override
  List<Object> get props => [modificadoEm];
}

class EstoqueFormSubmitted extends EstoqueEvent {}

class LoadEstoqueByIdForEdit extends EstoqueEvent {
  final int? id;

  const LoadEstoqueByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteEstoqueById extends EstoqueEvent {
  final int? id;

  const DeleteEstoqueById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadEstoqueByIdForView extends EstoqueEvent {
  final int? id;

  const LoadEstoqueByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
