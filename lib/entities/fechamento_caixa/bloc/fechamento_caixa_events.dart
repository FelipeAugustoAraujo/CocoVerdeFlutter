part of 'fechamento_caixa_bloc.dart';

abstract class FechamentoCaixaEvent extends Equatable {
  const FechamentoCaixaEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitFechamentoCaixaList extends FechamentoCaixaEvent {}


  
    class InitFechamentoCaixaListByFechamentoCaixaDetalhes extends FechamentoCaixaEvent {
      final int fechamentoCaixaDetalhesId;

      const InitFechamentoCaixaListByFechamentoCaixaDetalhes({required this.fechamentoCaixaDetalhesId});

      @override
      List<Object> get props => [fechamentoCaixaDetalhesId];
    }
  

class DataInicialChanged extends FechamentoCaixaEvent {
  final Instant dataInicial;

  const DataInicialChanged({required this.dataInicial});

  @override
  List<Object> get props => [dataInicial];
}
class DataFinalChanged extends FechamentoCaixaEvent {
  final Instant dataFinal;

  const DataFinalChanged({required this.dataFinal});

  @override
  List<Object> get props => [dataFinal];
}
class QuantidadeCocosPerdidosChanged extends FechamentoCaixaEvent {
  final int quantidadeCocosPerdidos;

  const QuantidadeCocosPerdidosChanged({required this.quantidadeCocosPerdidos});

  @override
  List<Object> get props => [quantidadeCocosPerdidos];
}
class QuantidadeCocosVendidosChanged extends FechamentoCaixaEvent {
  final int quantidadeCocosVendidos;

  const QuantidadeCocosVendidosChanged({required this.quantidadeCocosVendidos});

  @override
  List<Object> get props => [quantidadeCocosVendidos];
}
class QuantidadeCocoSobrouChanged extends FechamentoCaixaEvent {
  final int quantidadeCocoSobrou;

  const QuantidadeCocoSobrouChanged({required this.quantidadeCocoSobrou});

  @override
  List<Object> get props => [quantidadeCocoSobrou];
}
class DivididoPorChanged extends FechamentoCaixaEvent {
  final int divididoPor;

  const DivididoPorChanged({required this.divididoPor});

  @override
  List<Object> get props => [divididoPor];
}
class ValorTotalCocoChanged extends FechamentoCaixaEvent {
  final BigDecimal valorTotalCoco;

  const ValorTotalCocoChanged({required this.valorTotalCoco});

  @override
  List<Object> get props => [valorTotalCoco];
}
class ValorTotalCocoPerdidoChanged extends FechamentoCaixaEvent {
  final BigDecimal valorTotalCocoPerdido;

  const ValorTotalCocoPerdidoChanged({required this.valorTotalCocoPerdido});

  @override
  List<Object> get props => [valorTotalCocoPerdido];
}
class ValorPorPessoaChanged extends FechamentoCaixaEvent {
  final BigDecimal valorPorPessoa;

  const ValorPorPessoaChanged({required this.valorPorPessoa});

  @override
  List<Object> get props => [valorPorPessoa];
}
class ValorDespesasChanged extends FechamentoCaixaEvent {
  final BigDecimal valorDespesas;

  const ValorDespesasChanged({required this.valorDespesas});

  @override
  List<Object> get props => [valorDespesas];
}
class ValorDinheiroChanged extends FechamentoCaixaEvent {
  final BigDecimal valorDinheiro;

  const ValorDinheiroChanged({required this.valorDinheiro});

  @override
  List<Object> get props => [valorDinheiro];
}
class ValorCartaoChanged extends FechamentoCaixaEvent {
  final BigDecimal valorCartao;

  const ValorCartaoChanged({required this.valorCartao});

  @override
  List<Object> get props => [valorCartao];
}
class ValorTotalChanged extends FechamentoCaixaEvent {
  final BigDecimal valorTotal;

  const ValorTotalChanged({required this.valorTotal});

  @override
  List<Object> get props => [valorTotal];
}

class FechamentoCaixaFormSubmitted extends FechamentoCaixaEvent {}

class LoadFechamentoCaixaByIdForEdit extends FechamentoCaixaEvent {
  final int? id;

  const LoadFechamentoCaixaByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteFechamentoCaixaById extends FechamentoCaixaEvent {
  final int? id;

  const DeleteFechamentoCaixaById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadFechamentoCaixaByIdForView extends FechamentoCaixaEvent {
  final int? id;

  const LoadFechamentoCaixaByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
