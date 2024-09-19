part of 'dia_trabalho_bloc.dart';

enum DiaTrabalhoStatusUI {init, loading, error, done}
enum DiaTrabalhoDeleteStatus {ok, ko, none}

class DiaTrabalhoState extends Equatable with FormzMixin {
  final List<DiaTrabalho> diaTrabalhos;
  final DiaTrabalho loadedDiaTrabalho;
  final bool editMode;
  final DiaTrabalhoDeleteStatus deleteStatus;
  final DiaTrabalhoStatusUI diaTrabalhoStatusUI;

  final FormzSubmissionStatus formStatus;
  final String generalNotificationKey;

  final DataInput data;


  DiaTrabalhoState({
    this.diaTrabalhos = const [],
    this.diaTrabalhoStatusUI = DiaTrabalhoStatusUI.init,
    this.loadedDiaTrabalho = const DiaTrabalho(0,null,),
    this.editMode = false,
    this.formStatus = FormzSubmissionStatus.initial,
    this.generalNotificationKey = '',
    this.deleteStatus = DiaTrabalhoDeleteStatus.none,
    this.data = const DataInput.pure(),
  });

  DiaTrabalhoState copyWith({
    List<DiaTrabalho>? diaTrabalhos,
    DiaTrabalhoStatusUI? diaTrabalhoStatusUI,
    bool? editMode,
    DiaTrabalhoDeleteStatus? deleteStatus,
    DiaTrabalho? loadedDiaTrabalho,
    FormzSubmissionStatus? formStatus,
    String? generalNotificationKey,
    DataInput? data,
  }) {
    return DiaTrabalhoState(
      diaTrabalhos: diaTrabalhos ?? this.diaTrabalhos,
      diaTrabalhoStatusUI: diaTrabalhoStatusUI ?? this.diaTrabalhoStatusUI,
      loadedDiaTrabalho: loadedDiaTrabalho ?? this.loadedDiaTrabalho,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      data: data ?? this.data,
    );
  }

  @override
  List<Object> get props => [diaTrabalhos, diaTrabalhoStatusUI,
     loadedDiaTrabalho, editMode, deleteStatus, formStatus, generalNotificationKey,
data,];

  @override
  bool get stringify => true;

  @override
  List<FormzInput> get inputs => [data,];
}
