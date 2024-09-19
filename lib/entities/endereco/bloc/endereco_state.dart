part of 'endereco_bloc.dart';

enum EnderecoStatusUI {init, loading, error, done}
enum EnderecoDeleteStatus {ok, ko, none}

class EnderecoState extends Equatable with FormzMixin {
  final List<Endereco> enderecos;
  final Endereco loadedEndereco;
  final bool editMode;
  final EnderecoDeleteStatus deleteStatus;
  final EnderecoStatusUI enderecoStatusUI;

  final FormzSubmissionStatus formStatus;
  final String generalNotificationKey;

  final CepInput cep;
  final LogradouroInput logradouro;
  final NumeroInput numero;
  final ComplementoInput complemento;
  final BairroInput bairro;


  EnderecoState({
    this.enderecos = const [],
    this.enderecoStatusUI = EnderecoStatusUI.init,
    this.loadedEndereco = const Endereco(0,'','',0,'','',null,null,null,null,),
    this.editMode = false,
    this.formStatus = FormzSubmissionStatus.initial,
    this.generalNotificationKey = '',
    this.deleteStatus = EnderecoDeleteStatus.none,
    this.cep = const CepInput.pure(),
    this.logradouro = const LogradouroInput.pure(),
    this.numero = const NumeroInput.pure(),
    this.complemento = const ComplementoInput.pure(),
    this.bairro = const BairroInput.pure(),
  });

  EnderecoState copyWith({
    List<Endereco>? enderecos,
    EnderecoStatusUI? enderecoStatusUI,
    bool? editMode,
    EnderecoDeleteStatus? deleteStatus,
    Endereco? loadedEndereco,
    FormzSubmissionStatus? formStatus,
    String? generalNotificationKey,
    CepInput? cep,
    LogradouroInput? logradouro,
    NumeroInput? numero,
    ComplementoInput? complemento,
    BairroInput? bairro,
  }) {
    return EnderecoState(
      enderecos: enderecos ?? this.enderecos,
      enderecoStatusUI: enderecoStatusUI ?? this.enderecoStatusUI,
      loadedEndereco: loadedEndereco ?? this.loadedEndereco,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      cep: cep ?? this.cep,
      logradouro: logradouro ?? this.logradouro,
      numero: numero ?? this.numero,
      complemento: complemento ?? this.complemento,
      bairro: bairro ?? this.bairro,
    );
  }

  @override
  List<Object> get props => [enderecos, enderecoStatusUI,
     loadedEndereco, editMode, deleteStatus, formStatus, generalNotificationKey,
cep,logradouro,numero,complemento,bairro,];

  @override
  bool get stringify => true;

  @override
  List<FormzInput> get inputs => [cep,logradouro,numero,complemento,bairro,];
}
