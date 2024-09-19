part of 'fechamento_caixa_bloc.dart';

enum FechamentoCaixaStatusUI {init, loading, error, done}
enum FechamentoCaixaDeleteStatus {ok, ko, none}

class FechamentoCaixaState extends Equatable with FormzMixin {
  final List<FechamentoCaixa> fechamentoCaixas;
  final FechamentoCaixa loadedFechamentoCaixa;
  final bool editMode;
  final FechamentoCaixaDeleteStatus deleteStatus;
  final FechamentoCaixaStatusUI fechamentoCaixaStatusUI;

  final FormzSubmissionStatus formStatus;
  final String generalNotificationKey;

  final DataInicialInput dataInicial;
  final DataFinalInput dataFinal;
  final QuantidadeCocosPerdidosInput quantidadeCocosPerdidos;
  final QuantidadeCocosVendidosInput quantidadeCocosVendidos;
  final QuantidadeCocoSobrouInput quantidadeCocoSobrou;
  final DivididoPorInput divididoPor;
  final ValorTotalCocoInput valorTotalCoco;
  final ValorTotalCocoPerdidoInput valorTotalCocoPerdido;
  final ValorPorPessoaInput valorPorPessoa;
  final ValorDespesasInput valorDespesas;
  final ValorDinheiroInput valorDinheiro;
  final ValorCartaoInput valorCartao;
  final ValorTotalInput valorTotal;


  FechamentoCaixaState({
    this.fechamentoCaixas = const [],
    this.fechamentoCaixaStatusUI = FechamentoCaixaStatusUI.init,
    this.loadedFechamentoCaixa = const FechamentoCaixa(0,null,null,0,0,0,0,'','','','','','','',null,),
    this.editMode = false,
    this.formStatus = FormzSubmissionStatus.initial,
    this.generalNotificationKey = '',
    this.deleteStatus = FechamentoCaixaDeleteStatus.none,
    this.dataInicial = const DataInicialInput.pure(),
    this.dataFinal = const DataFinalInput.pure(),
    this.quantidadeCocosPerdidos = const QuantidadeCocosPerdidosInput.pure(),
    this.quantidadeCocosVendidos = const QuantidadeCocosVendidosInput.pure(),
    this.quantidadeCocoSobrou = const QuantidadeCocoSobrouInput.pure(),
    this.divididoPor = const DivididoPorInput.pure(),
    this.valorTotalCoco = const ValorTotalCocoInput.pure(),
    this.valorTotalCocoPerdido = const ValorTotalCocoPerdidoInput.pure(),
    this.valorPorPessoa = const ValorPorPessoaInput.pure(),
    this.valorDespesas = const ValorDespesasInput.pure(),
    this.valorDinheiro = const ValorDinheiroInput.pure(),
    this.valorCartao = const ValorCartaoInput.pure(),
    this.valorTotal = const ValorTotalInput.pure(),
  });

  FechamentoCaixaState copyWith({
    List<FechamentoCaixa>? fechamentoCaixas,
    FechamentoCaixaStatusUI? fechamentoCaixaStatusUI,
    bool? editMode,
    FechamentoCaixaDeleteStatus? deleteStatus,
    FechamentoCaixa? loadedFechamentoCaixa,
    FormzSubmissionStatus? formStatus,
    String? generalNotificationKey,
    DataInicialInput? dataInicial,
    DataFinalInput? dataFinal,
    QuantidadeCocosPerdidosInput? quantidadeCocosPerdidos,
    QuantidadeCocosVendidosInput? quantidadeCocosVendidos,
    QuantidadeCocoSobrouInput? quantidadeCocoSobrou,
    DivididoPorInput? divididoPor,
    ValorTotalCocoInput? valorTotalCoco,
    ValorTotalCocoPerdidoInput? valorTotalCocoPerdido,
    ValorPorPessoaInput? valorPorPessoa,
    ValorDespesasInput? valorDespesas,
    ValorDinheiroInput? valorDinheiro,
    ValorCartaoInput? valorCartao,
    ValorTotalInput? valorTotal,
  }) {
    return FechamentoCaixaState(
      fechamentoCaixas: fechamentoCaixas ?? this.fechamentoCaixas,
      fechamentoCaixaStatusUI: fechamentoCaixaStatusUI ?? this.fechamentoCaixaStatusUI,
      loadedFechamentoCaixa: loadedFechamentoCaixa ?? this.loadedFechamentoCaixa,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      dataInicial: dataInicial ?? this.dataInicial,
      dataFinal: dataFinal ?? this.dataFinal,
      quantidadeCocosPerdidos: quantidadeCocosPerdidos ?? this.quantidadeCocosPerdidos,
      quantidadeCocosVendidos: quantidadeCocosVendidos ?? this.quantidadeCocosVendidos,
      quantidadeCocoSobrou: quantidadeCocoSobrou ?? this.quantidadeCocoSobrou,
      divididoPor: divididoPor ?? this.divididoPor,
      valorTotalCoco: valorTotalCoco ?? this.valorTotalCoco,
      valorTotalCocoPerdido: valorTotalCocoPerdido ?? this.valorTotalCocoPerdido,
      valorPorPessoa: valorPorPessoa ?? this.valorPorPessoa,
      valorDespesas: valorDespesas ?? this.valorDespesas,
      valorDinheiro: valorDinheiro ?? this.valorDinheiro,
      valorCartao: valorCartao ?? this.valorCartao,
      valorTotal: valorTotal ?? this.valorTotal,
    );
  }

  @override
  List<Object> get props => [fechamentoCaixas, fechamentoCaixaStatusUI,
     loadedFechamentoCaixa, editMode, deleteStatus, formStatus, generalNotificationKey,
dataInicial,dataFinal,quantidadeCocosPerdidos,quantidadeCocosVendidos,quantidadeCocoSobrou,divididoPor,valorTotalCoco,valorTotalCocoPerdido,valorPorPessoa,valorDespesas,valorDinheiro,valorCartao,valorTotal,];

  @override
  bool get stringify => true;

  @override
  List<FormzInput> get inputs => [dataInicial,dataFinal,quantidadeCocosPerdidos,quantidadeCocosVendidos,quantidadeCocoSobrou,divididoPor,valorTotalCoco,valorTotalCocoPerdido,valorPorPessoa,valorDespesas,valorDinheiro,valorCartao,valorTotal,];
}
