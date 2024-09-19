part of 'saida_financeira_bloc.dart';

enum SaidaFinanceiraStatusUI {init, loading, error, done}
enum SaidaFinanceiraDeleteStatus {ok, ko, none}

class SaidaFinanceiraState extends Equatable with FormzMixin {
  final List<SaidaFinanceira> saidaFinanceiras;
  final SaidaFinanceira loadedSaidaFinanceira;
  final bool editMode;
  final SaidaFinanceiraDeleteStatus deleteStatus;
  final SaidaFinanceiraStatusUI saidaFinanceiraStatusUI;

  final FormzSubmissionStatus formStatus;
  final String generalNotificationKey;

  final DataInput data;
  final ValorTotalInput valorTotal;
  final DescricaoInput descricao;
  final MetodoPagamentoInput metodoPagamento;
  final StatusPagamentoInput statusPagamento;
  final ResponsavelPagamentoInput responsavelPagamento;


  SaidaFinanceiraState({
    this.saidaFinanceiras = const [],
    this.saidaFinanceiraStatusUI = SaidaFinanceiraStatusUI.init,
    this.loadedSaidaFinanceira = const SaidaFinanceira(0,null,'','',null,null,null,null,null,null,null,),
    this.editMode = false,
    this.formStatus = FormzSubmissionStatus.initial,
    this.generalNotificationKey = '',
    this.deleteStatus = SaidaFinanceiraDeleteStatus.none,
    this.data = const DataInput.pure(),
    this.valorTotal = const ValorTotalInput.pure(),
    this.descricao = const DescricaoInput.pure(),
    this.metodoPagamento = const MetodoPagamentoInput.pure(),
    this.statusPagamento = const StatusPagamentoInput.pure(),
    this.responsavelPagamento = const ResponsavelPagamentoInput.pure(),
  });

  SaidaFinanceiraState copyWith({
    List<SaidaFinanceira>? saidaFinanceiras,
    SaidaFinanceiraStatusUI? saidaFinanceiraStatusUI,
    bool? editMode,
    SaidaFinanceiraDeleteStatus? deleteStatus,
    SaidaFinanceira? loadedSaidaFinanceira,
    FormzSubmissionStatus? formStatus,
    String? generalNotificationKey,
    DataInput? data,
    ValorTotalInput? valorTotal,
    DescricaoInput? descricao,
    MetodoPagamentoInput? metodoPagamento,
    StatusPagamentoInput? statusPagamento,
    ResponsavelPagamentoInput? responsavelPagamento,
  }) {
    return SaidaFinanceiraState(
      saidaFinanceiras: saidaFinanceiras ?? this.saidaFinanceiras,
      saidaFinanceiraStatusUI: saidaFinanceiraStatusUI ?? this.saidaFinanceiraStatusUI,
      loadedSaidaFinanceira: loadedSaidaFinanceira ?? this.loadedSaidaFinanceira,
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
  List<Object> get props => [saidaFinanceiras, saidaFinanceiraStatusUI,
     loadedSaidaFinanceira, editMode, deleteStatus, formStatus, generalNotificationKey,
data,valorTotal,descricao,metodoPagamento,statusPagamento,responsavelPagamento,];

  @override
  bool get stringify => true;

  @override
  List<FormzInput> get inputs => [data,valorTotal,descricao,metodoPagamento,statusPagamento,responsavelPagamento,];
}
