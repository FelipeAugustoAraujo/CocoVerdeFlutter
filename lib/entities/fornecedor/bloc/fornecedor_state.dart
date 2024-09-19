part of 'fornecedor_bloc.dart';

enum FornecedorStatusUI {init, loading, error, done}
enum FornecedorDeleteStatus {ok, ko, none}

class FornecedorState extends Equatable with FormzMixin {
  final List<Fornecedor> fornecedors;
  final Fornecedor loadedFornecedor;
  final bool editMode;
  final FornecedorDeleteStatus deleteStatus;
  final FornecedorStatusUI fornecedorStatusUI;

  final FormzSubmissionStatus formStatus;
  final String generalNotificationKey;

  final NomeInput nome;
  final IdentificadorInput identificador;
  final TelefoneInput telefone;
  final DataCadastroInput dataCadastro;


  FornecedorState({
    this.fornecedors = const [],
    this.fornecedorStatusUI = FornecedorStatusUI.init,
    this.loadedFornecedor = const Fornecedor(0,'','','',null,null,null,null,),
    this.editMode = false,
    this.formStatus = FormzSubmissionStatus.initial,
    this.generalNotificationKey = '',
    this.deleteStatus = FornecedorDeleteStatus.none,
    this.nome = const NomeInput.pure(),
    this.identificador = const IdentificadorInput.pure(),
    this.telefone = const TelefoneInput.pure(),
    this.dataCadastro = const DataCadastroInput.pure(),
  });

  FornecedorState copyWith({
    List<Fornecedor>? fornecedors,
    FornecedorStatusUI? fornecedorStatusUI,
    bool? editMode,
    FornecedorDeleteStatus? deleteStatus,
    Fornecedor? loadedFornecedor,
    FormzSubmissionStatus? formStatus,
    String? generalNotificationKey,
    NomeInput? nome,
    IdentificadorInput? identificador,
    TelefoneInput? telefone,
    DataCadastroInput? dataCadastro,
  }) {
    return FornecedorState(
      fornecedors: fornecedors ?? this.fornecedors,
      fornecedorStatusUI: fornecedorStatusUI ?? this.fornecedorStatusUI,
      loadedFornecedor: loadedFornecedor ?? this.loadedFornecedor,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      nome: nome ?? this.nome,
      identificador: identificador ?? this.identificador,
      telefone: telefone ?? this.telefone,
      dataCadastro: dataCadastro ?? this.dataCadastro,
    );
  }

  @override
  List<Object> get props => [fornecedors, fornecedorStatusUI,
     loadedFornecedor, editMode, deleteStatus, formStatus, generalNotificationKey,
nome,identificador,telefone,dataCadastro,];

  @override
  bool get stringify => true;

  @override
  List<FormzInput> get inputs => [nome,identificador,telefone,dataCadastro,];
}
