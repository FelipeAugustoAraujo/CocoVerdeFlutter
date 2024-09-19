part of 'frente_bloc.dart';

enum FrenteStatusUI {init, loading, error, done}
enum FrenteDeleteStatus {ok, ko, none}

class FrenteState extends Equatable with FormzMixin {
  final List<Frente> frentes;
  final Frente loadedFrente;
  final bool editMode;
  final FrenteDeleteStatus deleteStatus;
  final FrenteStatusUI frenteStatusUI;

  final FormzSubmissionStatus formStatus;
  final String generalNotificationKey;

  final QuantidadeInput quantidade;
  final CriadoEmInput criadoEm;
  final ModificadoEmInput modificadoEm;


  FrenteState({
    this.frentes = const [],
    this.frenteStatusUI = FrenteStatusUI.init,
    this.loadedFrente = const Frente(0,0,null,null,null,null,null,),
    this.editMode = false,
    this.formStatus = FormzSubmissionStatus.initial,
    this.generalNotificationKey = '',
    this.deleteStatus = FrenteDeleteStatus.none,
    this.quantidade = const QuantidadeInput.pure(),
    this.criadoEm = const CriadoEmInput.pure(),
    this.modificadoEm = const ModificadoEmInput.pure(),
  });

  FrenteState copyWith({
    List<Frente>? frentes,
    FrenteStatusUI? frenteStatusUI,
    bool? editMode,
    FrenteDeleteStatus? deleteStatus,
    Frente? loadedFrente,
    FormzSubmissionStatus? formStatus,
    String? generalNotificationKey,
    QuantidadeInput? quantidade,
    CriadoEmInput? criadoEm,
    ModificadoEmInput? modificadoEm,
  }) {
    return FrenteState(
      frentes: frentes ?? this.frentes,
      frenteStatusUI: frenteStatusUI ?? this.frenteStatusUI,
      loadedFrente: loadedFrente ?? this.loadedFrente,
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
  List<Object> get props => [frentes, frenteStatusUI,
     loadedFrente, editMode, deleteStatus, formStatus, generalNotificationKey,
quantidade,criadoEm,modificadoEm,];

  @override
  bool get stringify => true;

  @override
  List<FormzInput> get inputs => [quantidade,criadoEm,modificadoEm,];
}
