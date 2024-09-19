part of 'entrada_financeira_bloc.dart';

abstract class EntradaFinanceiraEvent extends Equatable {
  const EntradaFinanceiraEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitEntradaFinanceiraList extends EntradaFinanceiraEvent {}


  
    class InitEntradaFinanceiraListByFornecedor extends EntradaFinanceiraEvent {
      final int fornecedorId;

      const InitEntradaFinanceiraListByFornecedor({required this.fornecedorId});

      @override
      List<Object> get props => [fornecedorId];
    }
  

  
    class InitEntradaFinanceiraListByEstoque extends EntradaFinanceiraEvent {
      final int estoqueId;

      const InitEntradaFinanceiraListByEstoque({required this.estoqueId});

      @override
      List<Object> get props => [estoqueId];
    }
  

  
    class InitEntradaFinanceiraListByFrente extends EntradaFinanceiraEvent {
      final int frenteId;

      const InitEntradaFinanceiraListByFrente({required this.frenteId});

      @override
      List<Object> get props => [frenteId];
    }
  

  
    class InitEntradaFinanceiraListByFechamentoCaixaDetalhes extends EntradaFinanceiraEvent {
      final int fechamentoCaixaDetalhesId;

      const InitEntradaFinanceiraListByFechamentoCaixaDetalhes({required this.fechamentoCaixaDetalhesId});

      @override
      List<Object> get props => [fechamentoCaixaDetalhesId];
    }
  

  
    class InitEntradaFinanceiraListByDetalhesEntradaFinanceira extends EntradaFinanceiraEvent {
      final int detalhesEntradaFinanceiraId;

      const InitEntradaFinanceiraListByDetalhesEntradaFinanceira({required this.detalhesEntradaFinanceiraId});

      @override
      List<Object> get props => [detalhesEntradaFinanceiraId];
    }
  

  
    class InitEntradaFinanceiraListByImagem extends EntradaFinanceiraEvent {
      final int imagemId;

      const InitEntradaFinanceiraListByImagem({required this.imagemId});

      @override
      List<Object> get props => [imagemId];
    }
  

class DataChanged extends EntradaFinanceiraEvent {
  final Instant data;

  const DataChanged({required this.data});

  @override
  List<Object> get props => [data];
}
class ValorTotalChanged extends EntradaFinanceiraEvent {
  final BigDecimal valorTotal;

  const ValorTotalChanged({required this.valorTotal});

  @override
  List<Object> get props => [valorTotal];
}
class DescricaoChanged extends EntradaFinanceiraEvent {
  final String descricao;

  const DescricaoChanged({required this.descricao});

  @override
  List<Object> get props => [descricao];
}
class MetodoPagamentoChanged extends EntradaFinanceiraEvent {
  final MetodoPagamento metodoPagamento;

  const MetodoPagamentoChanged({required this.metodoPagamento});

  @override
  List<Object> get props => [metodoPagamento];
}
class StatusPagamentoChanged extends EntradaFinanceiraEvent {
  final StatusPagamento statusPagamento;

  const StatusPagamentoChanged({required this.statusPagamento});

  @override
  List<Object> get props => [statusPagamento];
}
class ResponsavelPagamentoChanged extends EntradaFinanceiraEvent {
  final ResponsavelPagamento responsavelPagamento;

  const ResponsavelPagamentoChanged({required this.responsavelPagamento});

  @override
  List<Object> get props => [responsavelPagamento];
}

class EntradaFinanceiraFormSubmitted extends EntradaFinanceiraEvent {}

class LoadEntradaFinanceiraByIdForEdit extends EntradaFinanceiraEvent {
  final int? id;

  const LoadEntradaFinanceiraByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteEntradaFinanceiraById extends EntradaFinanceiraEvent {
  final int? id;

  const DeleteEntradaFinanceiraById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadEntradaFinanceiraByIdForView extends EntradaFinanceiraEvent {
  final int? id;

  const LoadEntradaFinanceiraByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
