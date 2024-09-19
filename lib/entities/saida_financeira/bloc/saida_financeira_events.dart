part of 'saida_financeira_bloc.dart';

abstract class SaidaFinanceiraEvent extends Equatable {
  const SaidaFinanceiraEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitSaidaFinanceiraList extends SaidaFinanceiraEvent {}


  
    class InitSaidaFinanceiraListByEstoque extends SaidaFinanceiraEvent {
      final int estoqueId;

      const InitSaidaFinanceiraListByEstoque({required this.estoqueId});

      @override
      List<Object> get props => [estoqueId];
    }
  

  
    class InitSaidaFinanceiraListByFrente extends SaidaFinanceiraEvent {
      final int frenteId;

      const InitSaidaFinanceiraListByFrente({required this.frenteId});

      @override
      List<Object> get props => [frenteId];
    }
  

  
    class InitSaidaFinanceiraListByFechamentoCaixaDetalhes extends SaidaFinanceiraEvent {
      final int fechamentoCaixaDetalhesId;

      const InitSaidaFinanceiraListByFechamentoCaixaDetalhes({required this.fechamentoCaixaDetalhesId});

      @override
      List<Object> get props => [fechamentoCaixaDetalhesId];
    }
  

  
    class InitSaidaFinanceiraListByImagem extends SaidaFinanceiraEvent {
      final int imagemId;

      const InitSaidaFinanceiraListByImagem({required this.imagemId});

      @override
      List<Object> get props => [imagemId];
    }
  

class DataChanged extends SaidaFinanceiraEvent {
  final Instant data;

  const DataChanged({required this.data});

  @override
  List<Object> get props => [data];
}
class ValorTotalChanged extends SaidaFinanceiraEvent {
  final BigDecimal valorTotal;

  const ValorTotalChanged({required this.valorTotal});

  @override
  List<Object> get props => [valorTotal];
}
class DescricaoChanged extends SaidaFinanceiraEvent {
  final String descricao;

  const DescricaoChanged({required this.descricao});

  @override
  List<Object> get props => [descricao];
}
class MetodoPagamentoChanged extends SaidaFinanceiraEvent {
  final MetodoPagamento metodoPagamento;

  const MetodoPagamentoChanged({required this.metodoPagamento});

  @override
  List<Object> get props => [metodoPagamento];
}
class StatusPagamentoChanged extends SaidaFinanceiraEvent {
  final StatusPagamento statusPagamento;

  const StatusPagamentoChanged({required this.statusPagamento});

  @override
  List<Object> get props => [statusPagamento];
}
class ResponsavelPagamentoChanged extends SaidaFinanceiraEvent {
  final ResponsavelPagamento responsavelPagamento;

  const ResponsavelPagamentoChanged({required this.responsavelPagamento});

  @override
  List<Object> get props => [responsavelPagamento];
}

class SaidaFinanceiraFormSubmitted extends SaidaFinanceiraEvent {}

class LoadSaidaFinanceiraByIdForEdit extends SaidaFinanceiraEvent {
  final int? id;

  const LoadSaidaFinanceiraByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteSaidaFinanceiraById extends SaidaFinanceiraEvent {
  final int? id;

  const DeleteSaidaFinanceiraById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadSaidaFinanceiraByIdForView extends SaidaFinanceiraEvent {
  final int? id;

  const LoadSaidaFinanceiraByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
