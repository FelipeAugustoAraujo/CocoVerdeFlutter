part of 'frente_bloc.dart';

abstract class FrenteEvent extends Equatable {
  const FrenteEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitFrenteList extends FrenteEvent {}


  
    class InitFrenteListByProduto extends FrenteEvent {
      final int produtoId;

      const InitFrenteListByProduto({required this.produtoId});

      @override
      List<Object> get props => [produtoId];
    }
  

  
    class InitFrenteListByEntradaFinanceira extends FrenteEvent {
      final int entradaFinanceiraId;

      const InitFrenteListByEntradaFinanceira({required this.entradaFinanceiraId});

      @override
      List<Object> get props => [entradaFinanceiraId];
    }
  

  
    class InitFrenteListBySaidaFinanceira extends FrenteEvent {
      final int saidaFinanceiraId;

      const InitFrenteListBySaidaFinanceira({required this.saidaFinanceiraId});

      @override
      List<Object> get props => [saidaFinanceiraId];
    }
  

class QuantidadeChanged extends FrenteEvent {
  final int quantidade;

  const QuantidadeChanged({required this.quantidade});

  @override
  List<Object> get props => [quantidade];
}
class CriadoEmChanged extends FrenteEvent {
  final Instant criadoEm;

  const CriadoEmChanged({required this.criadoEm});

  @override
  List<Object> get props => [criadoEm];
}
class ModificadoEmChanged extends FrenteEvent {
  final Instant modificadoEm;

  const ModificadoEmChanged({required this.modificadoEm});

  @override
  List<Object> get props => [modificadoEm];
}

class FrenteFormSubmitted extends FrenteEvent {}

class LoadFrenteByIdForEdit extends FrenteEvent {
  final int? id;

  const LoadFrenteByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteFrenteById extends FrenteEvent {
  final int? id;

  const DeleteFrenteById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadFrenteByIdForView extends FrenteEvent {
  final int? id;

  const LoadFrenteByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
