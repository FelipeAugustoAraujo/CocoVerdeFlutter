part of 'cidade_bloc.dart';

enum CidadeStatusUI {init, loading, error, done}
enum CidadeDeleteStatus {ok, ko, none}

class CidadeState extends Equatable with FormzMixin {
  final List<Cidade> cidades;
  final Cidade loadedCidade;
  final bool editMode;
  final CidadeDeleteStatus deleteStatus;
  final CidadeStatusUI cidadeStatusUI;

  final FormzSubmissionStatus formStatus;
  final String generalNotificationKey;

  final NomeInput nome;
  final EstadoInput estado;


  CidadeState({
    this.cidades = const [],
    this.cidadeStatusUI = CidadeStatusUI.init,
    this.loadedCidade = const Cidade(0,'',null,null,),
    this.editMode = false,
    this.formStatus = FormzSubmissionStatus.initial,
    this.generalNotificationKey = '',
    this.deleteStatus = CidadeDeleteStatus.none,
    this.nome = const NomeInput.pure(),
    this.estado = const EstadoInput.pure(),
  });

  CidadeState copyWith({
    List<Cidade>? cidades,
    CidadeStatusUI? cidadeStatusUI,
    bool? editMode,
    CidadeDeleteStatus? deleteStatus,
    Cidade? loadedCidade,
    FormzSubmissionStatus? formStatus,
    String? generalNotificationKey,
    NomeInput? nome,
    EstadoInput? estado,
  }) {
    return CidadeState(
      cidades: cidades ?? this.cidades,
      cidadeStatusUI: cidadeStatusUI ?? this.cidadeStatusUI,
      loadedCidade: loadedCidade ?? this.loadedCidade,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      nome: nome ?? this.nome,
      estado: estado ?? this.estado,
    );
  }

  @override
  List<Object> get props => [cidades, cidadeStatusUI,
     loadedCidade, editMode, deleteStatus, formStatus, generalNotificationKey,
nome,estado,];

  @override
  bool get stringify => true;

  @override
  List<FormzInput> get inputs => [nome,estado,];
}
