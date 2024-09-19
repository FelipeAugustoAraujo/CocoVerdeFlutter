part of 'cliente_bloc.dart';

enum ClienteStatusUI {init, loading, error, done}
enum ClienteDeleteStatus {ok, ko, none}

class ClienteState extends Equatable with FormzMixin {
  final List<Cliente> clientes;
  final Cliente loadedCliente;
  final bool editMode;
  final ClienteDeleteStatus deleteStatus;
  final ClienteStatusUI clienteStatusUI;

  final FormzSubmissionStatus formStatus;
  final String generalNotificationKey;

  final NomeInput nome;
  final DataNascimentoInput dataNascimento;
  final IdentificadorInput identificador;
  final DataCadastroInput dataCadastro;
  final TelefoneInput telefone;


  ClienteState({
    this.clientes = const [],
    this.clienteStatusUI = ClienteStatusUI.init,
    this.loadedCliente = const Cliente(0,'','','',null,'',null,),
    this.editMode = false,
    this.formStatus = FormzSubmissionStatus.initial,
    this.generalNotificationKey = '',
    this.deleteStatus = ClienteDeleteStatus.none,
    this.nome = const NomeInput.pure(),
    this.dataNascimento = const DataNascimentoInput.pure(),
    this.identificador = const IdentificadorInput.pure(),
    this.dataCadastro = const DataCadastroInput.pure(),
    this.telefone = const TelefoneInput.pure(),
  });

  ClienteState copyWith({
    List<Cliente>? clientes,
    ClienteStatusUI? clienteStatusUI,
    bool? editMode,
    ClienteDeleteStatus? deleteStatus,
    Cliente? loadedCliente,
    FormzSubmissionStatus? formStatus,
    String? generalNotificationKey,
    NomeInput? nome,
    DataNascimentoInput? dataNascimento,
    IdentificadorInput? identificador,
    DataCadastroInput? dataCadastro,
    TelefoneInput? telefone,
  }) {
    return ClienteState(
      clientes: clientes ?? this.clientes,
      clienteStatusUI: clienteStatusUI ?? this.clienteStatusUI,
      loadedCliente: loadedCliente ?? this.loadedCliente,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      nome: nome ?? this.nome,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      identificador: identificador ?? this.identificador,
      dataCadastro: dataCadastro ?? this.dataCadastro,
      telefone: telefone ?? this.telefone,
    );
  }

  @override
  List<Object> get props => [clientes, clienteStatusUI,
     loadedCliente, editMode, deleteStatus, formStatus, generalNotificationKey,
nome,dataNascimento,identificador,dataCadastro,telefone,];

  @override
  bool get stringify => true;

  @override
  List<FormzInput> get inputs => [nome,dataNascimento,identificador,dataCadastro,telefone,];
}
