part of 'detalhes_entrada_financeira_bloc.dart';

abstract class DetalhesEntradaFinanceiraEvent extends Equatable {
  const DetalhesEntradaFinanceiraEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitDetalhesEntradaFinanceiraList extends DetalhesEntradaFinanceiraEvent {}


  
    class InitDetalhesEntradaFinanceiraListByProduto extends DetalhesEntradaFinanceiraEvent {
      final int produtoId;

      const InitDetalhesEntradaFinanceiraListByProduto({required this.produtoId});

      @override
      List<Object> get props => [produtoId];
    }
  

  
    class InitDetalhesEntradaFinanceiraListByEntradaFinanceira extends DetalhesEntradaFinanceiraEvent {
      final int entradaFinanceiraId;

      const InitDetalhesEntradaFinanceiraListByEntradaFinanceira({required this.entradaFinanceiraId});

      @override
      List<Object> get props => [entradaFinanceiraId];
    }
  

class QuantidadeItemChanged extends DetalhesEntradaFinanceiraEvent {
  final int quantidadeItem;

  const QuantidadeItemChanged({required this.quantidadeItem});

  @override
  List<Object> get props => [quantidadeItem];
}
class ValorChanged extends DetalhesEntradaFinanceiraEvent {
  final BigDecimal valor;

  const ValorChanged({required this.valor});

  @override
  List<Object> get props => [valor];
}

class DetalhesEntradaFinanceiraFormSubmitted extends DetalhesEntradaFinanceiraEvent {}

class LoadDetalhesEntradaFinanceiraByIdForEdit extends DetalhesEntradaFinanceiraEvent {
  final int? id;

  const LoadDetalhesEntradaFinanceiraByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteDetalhesEntradaFinanceiraById extends DetalhesEntradaFinanceiraEvent {
  final int? id;

  const DeleteDetalhesEntradaFinanceiraById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadDetalhesEntradaFinanceiraByIdForView extends DetalhesEntradaFinanceiraEvent {
  final int? id;

  const LoadDetalhesEntradaFinanceiraByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
