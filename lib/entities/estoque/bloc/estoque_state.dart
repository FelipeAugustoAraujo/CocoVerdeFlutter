part of 'estoque_bloc.dart';

enum EstoqueStatusUI {init, loading, error, done}
enum EstoqueDeleteStatus {ok, ko, none}

class EstoqueState extends Equatable with FormzMixin {
  final List<Estoque> estoques;
  final Estoque loadedEstoque;
  final bool editMode;
  final EstoqueDeleteStatus deleteStatus;
  final EstoqueStatusUI estoqueStatusUI;

  final FormzSubmissionStatus formStatus;
  final String generalNotificationKey;

  final QuantidadeInput quantidade;
  final CriadoEmInput criadoEm;
  final ModificadoEmInput modificadoEm;


  EstoqueState({
    this.estoques = const [],
    this.estoqueStatusUI = EstoqueStatusUI.init,
    this.loadedEstoque = const Estoque(0,0,null,null,null,null,null,),
    this.editMode = false,
    this.formStatus = FormzSubmissionStatus.initial,
    this.generalNotificationKey = '',
    this.deleteStatus = EstoqueDeleteStatus.none,
    this.quantidade = const QuantidadeInput.pure(),
    this.criadoEm = const CriadoEmInput.pure(),
    this.modificadoEm = const ModificadoEmInput.pure(),
  });

  EstoqueState copyWith({
    List<Estoque>? estoques,
    EstoqueStatusUI? estoqueStatusUI,
    bool? editMode,
    EstoqueDeleteStatus? deleteStatus,
    Estoque? loadedEstoque,
    FormzSubmissionStatus? formStatus,
    String? generalNotificationKey,
    QuantidadeInput? quantidade,
    CriadoEmInput? criadoEm,
    ModificadoEmInput? modificadoEm,
  }) {
    return EstoqueState(
      estoques: estoques ?? this.estoques,
      estoqueStatusUI: estoqueStatusUI ?? this.estoqueStatusUI,
      loadedEstoque: loadedEstoque ?? this.loadedEstoque,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      quantidade: quantidade ?? this.quantidade,
      criadoEm: criadoEm ?? this.criadoEm,
      modificadoEm: modificadoEm ?? this.modificadoEm,
    );
  }

  @override
  List<Object> get props => [estoques, estoqueStatusUI,
     loadedEstoque, editMode, deleteStatus, formStatus, generalNotificationKey,
quantidade,criadoEm,modificadoEm,];

  @override
  bool get stringify => true;

  @override
  List<FormzInput> get inputs => [quantidade,criadoEm,modificadoEm,];
}
