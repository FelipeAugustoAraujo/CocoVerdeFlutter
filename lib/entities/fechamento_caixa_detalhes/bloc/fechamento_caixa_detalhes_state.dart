part of 'fechamento_caixa_detalhes_bloc.dart';

enum FechamentoCaixaDetalhesStatusUI {init, loading, error, done}
enum FechamentoCaixaDetalhesDeleteStatus {ok, ko, none}

class FechamentoCaixaDetalhesState extends Equatable with FormzMixin {
  final List<FechamentoCaixaDetalhes> fechamentoCaixaDetalhes;
  final FechamentoCaixaDetalhes loadedFechamentoCaixaDetalhes;
  final bool editMode;
  final FechamentoCaixaDetalhesDeleteStatus deleteStatus;
  final FechamentoCaixaDetalhesStatusUI fechamentoCaixaDetalhesStatusUI;

  final FormzSubmissionStatus formStatus;
  final String generalNotificationKey;



  FechamentoCaixaDetalhesState({
    this.fechamentoCaixaDetalhes = const [],
    this.fechamentoCaixaDetalhesStatusUI = FechamentoCaixaDetalhesStatusUI.init,
    this.loadedFechamentoCaixaDetalhes = const FechamentoCaixaDetalhes(0,null,null,null,),
    this.editMode = false,
    this.formStatus = FormzSubmissionStatus.initial,
    this.generalNotificationKey = '',
    this.deleteStatus = FechamentoCaixaDetalhesDeleteStatus.none,
  });

  FechamentoCaixaDetalhesState copyWith({
    List<FechamentoCaixaDetalhes>? fechamentoCaixaDetalhes,
    FechamentoCaixaDetalhesStatusUI? fechamentoCaixaDetalhesStatusUI,
    bool? editMode,
    FechamentoCaixaDetalhesDeleteStatus? deleteStatus,
    FechamentoCaixaDetalhes? loadedFechamentoCaixaDetalhes,
    FormzSubmissionStatus? formStatus,
    String? generalNotificationKey,
  }) {
    return FechamentoCaixaDetalhesState(
      fechamentoCaixaDetalhes: fechamentoCaixaDetalhes ?? this.fechamentoCaixaDetalhes,
      fechamentoCaixaDetalhesStatusUI: fechamentoCaixaDetalhesStatusUI ?? this.fechamentoCaixaDetalhesStatusUI,
      loadedFechamentoCaixaDetalhes: loadedFechamentoCaixaDetalhes ?? this.loadedFechamentoCaixaDetalhes,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
    );
  }

  @override
  List<Object> get props => [fechamentoCaixaDetalhes, fechamentoCaixaDetalhesStatusUI,
     loadedFechamentoCaixaDetalhes, editMode, deleteStatus, formStatus, generalNotificationKey,
];

  @override
  bool get stringify => true;

  @override
  List<FormzInput> get inputs => [];
}
