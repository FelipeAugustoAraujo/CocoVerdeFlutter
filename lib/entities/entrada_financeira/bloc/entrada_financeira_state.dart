part of 'entrada_financeira_bloc.dart';

enum EntradaFinanceiraStatusUI {init, loading, error, done}
enum EntradaFinanceiraDeleteStatus {ok, ko, none}

class EntradaFinanceiraState extends Equatable with FormzMixin {
  final List<EntradaFinanceira> entradaFinanceiras;
  final EntradaFinanceira loadedEntradaFinanceira;
  final bool editMode;
  final EntradaFinanceiraDeleteStatus deleteStatus;
  final EntradaFinanceiraStatusUI entradaFinanceiraStatusUI;

  final FormzSubmissionStatus formStatus;
  final String generalNotificationKey;

  final DataInput data;
  final ValorTotalInput valorTotal;
  final DescricaoInput descricao;
  final MetodoPagamentoInput metodoPagamento;
  final StatusPagamentoInput statusPagamento;
  final ResponsavelPagamentoInput responsavelPagamento;


  EntradaFinanceiraState({
    this.entradaFinanceiras = const [],
    this.entradaFinanceiraStatusUI = EntradaFinanceiraStatusUI.init,
    this.loadedEntradaFinanceira = const EntradaFinanceira(0,null,'','',null,null,null,null,null,null,null,null,null,),
    this.editMode = false,
    this.formStatus = FormzSubmissionStatus.initial,
    this.generalNotificationKey = '',
    this.deleteStatus = EntradaFinanceiraDeleteStatus.none,
    this.data = const DataInput.pure(),
    this.valorTotal = const ValorTotalInput.pure(),
    this.descricao = const DescricaoInput.pure(),
    this.metodoPagamento = const MetodoPagamentoInput.pure(),
    this.statusPagamento = const StatusPagamentoInput.pure(),
    this.responsavelPagamento = const ResponsavelPagamentoInput.pure(),
  });

  EntradaFinanceiraState copyWith({
    List<EntradaFinanceira>? entradaFinanceiras,
    EntradaFinanceiraStatusUI? entradaFinanceiraStatusUI,
    bool? editMode,
    EntradaFinanceiraDeleteStatus? deleteStatus,
    EntradaFinanceira? loadedEntradaFinanceira,
    FormzSubmissionStatus? formStatus,
    String? generalNotificationKey,
    DataInput? data,
    ValorTotalInput? valorTotal,
    DescricaoInput? descricao,
    MetodoPagamentoInput? metodoPagamento,
    StatusPagamentoInput? statusPagamento,
    ResponsavelPagamentoInput? responsavelPagamento,
  }) {
    return EntradaFinanceiraState(
      entradaFinanceiras: entradaFinanceiras ?? this.entradaFinanceiras,
      entradaFinanceiraStatusUI: entradaFinanceiraStatusUI ?? this.entradaFinanceiraStatusUI,
      loadedEntradaFinanceira: loadedEntradaFinanceira ?? this.loadedEntradaFinanceira,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      data: data ?? this.data,
      valorTotal: valorTotal ?? this.valorTotal,
      descricao: descricao ?? this.descricao,
      metodoPagamento: metodoPagamento ?? this.metodoPagamento,
      statusPagamento: statusPagamento ?? this.statusPagamento,
      responsavelPagamento: responsavelPagamento ?? this.responsavelPagamento,
    );
  }

  @override
  List<Object> get props => [entradaFinanceiras, entradaFinanceiraStatusUI,
     loadedEntradaFinanceira, editMode, deleteStatus, formStatus, generalNotificationKey,
data,valorTotal,descricao,metodoPagamento,statusPagamento,responsavelPagamento,];

  @override
  bool get stringify => true;

  @override
  List<FormzInput> get inputs => [data,valorTotal,descricao,metodoPagamento,statusPagamento,responsavelPagamento,];
}
