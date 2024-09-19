part of 'detalhes_saida_financeira_bloc.dart';

enum DetalhesSaidaFinanceiraStatusUI {init, loading, error, done}
enum DetalhesSaidaFinanceiraDeleteStatus {ok, ko, none}

class DetalhesSaidaFinanceiraState extends Equatable with FormzMixin {
  final List<DetalhesSaidaFinanceira> detalhesSaidaFinanceiras;
  final DetalhesSaidaFinanceira loadedDetalhesSaidaFinanceira;
  final bool editMode;
  final DetalhesSaidaFinanceiraDeleteStatus deleteStatus;
  final DetalhesSaidaFinanceiraStatusUI detalhesSaidaFinanceiraStatusUI;

  final FormzSubmissionStatus formStatus;
  final String generalNotificationKey;

  final QuantidadeItemInput quantidadeItem;
  final ValorInput valor;


  DetalhesSaidaFinanceiraState({
    this.detalhesSaidaFinanceiras = const [],
    this.detalhesSaidaFinanceiraStatusUI = DetalhesSaidaFinanceiraStatusUI.init,
    this.loadedDetalhesSaidaFinanceira = const DetalhesSaidaFinanceira(0,0,'',),
    this.editMode = false,
    this.formStatus = FormzSubmissionStatus.initial,
    this.generalNotificationKey = '',
    this.deleteStatus = DetalhesSaidaFinanceiraDeleteStatus.none,
    this.quantidadeItem = const QuantidadeItemInput.pure(),
    this.valor = const ValorInput.pure(),
  });

  DetalhesSaidaFinanceiraState copyWith({
    List<DetalhesSaidaFinanceira>? detalhesSaidaFinanceiras,
    DetalhesSaidaFinanceiraStatusUI? detalhesSaidaFinanceiraStatusUI,
    bool? editMode,
    DetalhesSaidaFinanceiraDeleteStatus? deleteStatus,
    DetalhesSaidaFinanceira? loadedDetalhesSaidaFinanceira,
    FormzSubmissionStatus? formStatus,
    String? generalNotificationKey,
    QuantidadeItemInput? quantidadeItem,
    ValorInput? valor,
  }) {
    return DetalhesSaidaFinanceiraState(
      detalhesSaidaFinanceiras: detalhesSaidaFinanceiras ?? this.detalhesSaidaFinanceiras,
      detalhesSaidaFinanceiraStatusUI: detalhesSaidaFinanceiraStatusUI ?? this.detalhesSaidaFinanceiraStatusUI,
      loadedDetalhesSaidaFinanceira: loadedDetalhesSaidaFinanceira ?? this.loadedDetalhesSaidaFinanceira,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      quantidadeItem: quantidadeItem ?? this.quantidadeItem,
      valor: valor ?? this.valor,
    );
  }

  @override
  List<Object> get props => [detalhesSaidaFinanceiras, detalhesSaidaFinanceiraStatusUI,
     loadedDetalhesSaidaFinanceira, editMode, deleteStatus, formStatus, generalNotificationKey,
quantidadeItem,valor,];

  @override
  bool get stringify => true;

  @override
  List<FormzInput> get inputs => [quantidadeItem,valor,];
}
