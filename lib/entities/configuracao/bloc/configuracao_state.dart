part of 'configuracao_bloc.dart';

enum ConfiguracaoStatusUI {init, loading, error, done}
enum ConfiguracaoDeleteStatus {ok, ko, none}

class ConfiguracaoState extends Equatable with FormzMixin {
  final List<Configuracao> configuracaos;
  final Configuracao loadedConfiguracao;
  final bool editMode;
  final ConfiguracaoDeleteStatus deleteStatus;
  final ConfiguracaoStatusUI configuracaoStatusUI;

  final FormzSubmissionStatus formStatus;
  final String generalNotificationKey;



  ConfiguracaoState({
    this.configuracaos = const [],
    this.configuracaoStatusUI = ConfiguracaoStatusUI.init,
    this.loadedConfiguracao = const Configuracao(0,),
    this.editMode = false,
    this.formStatus = FormzSubmissionStatus.initial,
    this.generalNotificationKey = '',
    this.deleteStatus = ConfiguracaoDeleteStatus.none,
  });

  ConfiguracaoState copyWith({
    List<Configuracao>? configuracaos,
    ConfiguracaoStatusUI? configuracaoStatusUI,
    bool? editMode,
    ConfiguracaoDeleteStatus? deleteStatus,
    Configuracao? loadedConfiguracao,
    FormzSubmissionStatus? formStatus,
    String? generalNotificationKey,
  }) {
    return ConfiguracaoState(
      configuracaos: configuracaos ?? this.configuracaos,
      configuracaoStatusUI: configuracaoStatusUI ?? this.configuracaoStatusUI,
      loadedConfiguracao: loadedConfiguracao ?? this.loadedConfiguracao,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
    );
  }

  @override
  List<Object> get props => [configuracaos, configuracaoStatusUI,
     loadedConfiguracao, editMode, deleteStatus, formStatus, generalNotificationKey,
];

  @override
  bool get stringify => true;

  @override
  List<FormzInput> get inputs => [];
}
