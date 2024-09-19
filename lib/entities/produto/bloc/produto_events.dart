part of 'produto_bloc.dart';

abstract class ProdutoEvent extends Equatable {
  const ProdutoEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitProdutoList extends ProdutoEvent {}


  
    class InitProdutoListByEstoque extends ProdutoEvent {
      final int estoqueId;

      const InitProdutoListByEstoque({required this.estoqueId});

      @override
      List<Object> get props => [estoqueId];
    }
  

  
    class InitProdutoListByFrente extends ProdutoEvent {
      final int frenteId;

      const InitProdutoListByFrente({required this.frenteId});

      @override
      List<Object> get props => [frenteId];
    }
  

  
    class InitProdutoListByDetalhesEntradaFinanceira extends ProdutoEvent {
      final int detalhesEntradaFinanceiraId;

      const InitProdutoListByDetalhesEntradaFinanceira({required this.detalhesEntradaFinanceiraId});

      @override
      List<Object> get props => [detalhesEntradaFinanceiraId];
    }
  

  
    class InitProdutoListByFornecedor extends ProdutoEvent {
      final int fornecedorId;

      const InitProdutoListByFornecedor({required this.fornecedorId});

      @override
      List<Object> get props => [fornecedorId];
    }
  

class NomeChanged extends ProdutoEvent {
  final String nome;

  const NomeChanged({required this.nome});

  @override
  List<Object> get props => [nome];
}
class DescricaoChanged extends ProdutoEvent {
  final String descricao;

  const DescricaoChanged({required this.descricao});

  @override
  List<Object> get props => [descricao];
}
class ValorBaseChanged extends ProdutoEvent {
  final String valorBase;

  const ValorBaseChanged({required this.valorBase});

  @override
  List<Object> get props => [valorBase];
}

class ProdutoFormSubmitted extends ProdutoEvent {}

class LoadProdutoByIdForEdit extends ProdutoEvent {
  final int? id;

  const LoadProdutoByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteProdutoById extends ProdutoEvent {
  final int? id;

  const DeleteProdutoById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadProdutoByIdForView extends ProdutoEvent {
  final int? id;

  const LoadProdutoByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
