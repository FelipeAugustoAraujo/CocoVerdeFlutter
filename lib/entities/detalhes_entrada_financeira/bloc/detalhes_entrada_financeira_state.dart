part of 'detalhes_entrada_financeira_bloc.dart';

enum DetalhesEntradaFinanceiraStatusUI {init, loading, error, done}
enum DetalhesEntradaFinanceiraDeleteStatus {ok, ko, none}

class DetalhesEntradaFinanceiraState extends Equatable with FormzMixin {
  final List<DetalhesEntradaFinanceira> detalhesEntradaFinanceiras;
  final DetalhesEntradaFinanceira loadedDetalhesEntradaFinanceira;
  final bool editMode;
  final DetalhesEntradaFinanceiraDeleteStatus deleteStatus;
  final DetalhesEntradaFinanceiraStatusUI detalhesEntradaFinanceiraStatusUI;

  final FormzSubmissionStatus formStatus;
  final String generalNotificationKey;

  final QuantidadeItemInput quantidadeItem;
  final ValorInput valor;


  DetalhesEntradaFinanceiraState({
    this.detalhesEntradaFinanceiras = const [],
    this.detalhesEntradaFinanceiraStatusUI = DetalhesEntradaFinanceiraStatusUI.init,
    this.loadedDetalhesEntradaFinanceira = const DetalhesEntradaFinanceira(0,0,'',null,null,),
    this.editMode = false,
    this.formStatus = FormzSubmissionStatus.initial,
    this.generalNotificationKey = '',
    this.deleteStatus = DetalhesEntradaFinanceiraDeleteStatus.none,
    this.quantidadeItem = const QuantidadeItemInput.pure(),
    this.valor = const ValorInput.pure(),
  });

  DetalhesEntradaFinanceiraState copyWith({
    List<DetalhesEntradaFinanceira>? detalhesEntradaFinanceiras,
    DetalhesEntradaFinanceiraStatusUI? detalhesEntradaFinanceiraStatusUI,
    bool? editMode,
    DetalhesEntradaFinanceiraDeleteStatus? deleteStatus,
    DetalhesEntradaFinanceira? loadedDetalhesEntradaFinanceira,
    FormzSubmissionStatus? formStatus,
    String? generalNotificationKey,
    QuantidadeItemInput? quantidadeItem,
    ValorInput? valor,
  }) {
    return DetalhesEntradaFinanceiraState(
      detalhesEntradaFinanceiras: detalhesEntradaFinanceiras ?? this.detalhesEntradaFinanceiras,
      detalhesEntradaFinanceiraStatusUI: detalhesEntradaFinanceiraStatusUI ?? this.detalhesEntradaFinanceiraStatusUI,
      loadedDetalhesEntradaFinanceira: loadedDetalhesEntradaFinanceira ?? this.loadedDetalhesEntradaFinanceira,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      quantidadeItem: quantidadeItem ?? this.quantidadeItem,
      valor: valor ?? this.valor,
    );
  }

  @override
  List<Object> get props => [detalhesEntradaFinanceiras, detalhesEntradaFinanceiraStatusUI,
     loadedDetalhesEntradaFinanceira, editMode, deleteStatus, formStatus, generalNotificationKey,
quantidadeItem,valor,];

  @override
  bool get stringify => true;

  @override
  List<FormzInput> get inputs => [quantidadeItem,valor,];
}
