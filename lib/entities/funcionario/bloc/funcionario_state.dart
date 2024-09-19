part of 'funcionario_bloc.dart';

enum FuncionarioStatusUI {init, loading, error, done}
enum FuncionarioDeleteStatus {ok, ko, none}

class FuncionarioState extends Equatable with FormzMixin {
  final List<Funcionario> funcionarios;
  final Funcionario loadedFuncionario;
  final bool editMode;
  final FuncionarioDeleteStatus deleteStatus;
  final FuncionarioStatusUI funcionarioStatusUI;

  final FormzSubmissionStatus formStatus;
  final String generalNotificationKey;

  final NomeInput nome;
  final DataNascimentoInput dataNascimento;
  final IdentificadorInput identificador;
  final TelefoneInput telefone;
  final DataCadastroInput dataCadastro;
  final ValorBaseInput valorBase;


  FuncionarioState({
    this.funcionarios = const [],
    this.funcionarioStatusUI = FuncionarioStatusUI.init,
    this.loadedFuncionario = const Funcionario(0,'','','','',null,'',null,),
    this.editMode = false,
    this.formStatus = FormzSubmissionStatus.initial,
    this.generalNotificationKey = '',
    this.deleteStatus = FuncionarioDeleteStatus.none,
    this.nome = const NomeInput.pure(),
    this.dataNascimento = const DataNascimentoInput.pure(),
    this.identificador = const IdentificadorInput.pure(),
    this.telefone = const TelefoneInput.pure(),
    this.dataCadastro = const DataCadastroInput.pure(),
    this.valorBase = const ValorBaseInput.pure(),
  });

  FuncionarioState copyWith({
    List<Funcionario>? funcionarios,
    FuncionarioStatusUI? funcionarioStatusUI,
    bool? editMode,
    FuncionarioDeleteStatus? deleteStatus,
    Funcionario? loadedFuncionario,
    FormzSubmissionStatus? formStatus,
    String? generalNotificationKey,
    NomeInput? nome,
    DataNascimentoInput? dataNascimento,
    IdentificadorInput? identificador,
    TelefoneInput? telefone,
    DataCadastroInput? dataCadastro,
    ValorBaseInput? valorBase,
  }) {
    return FuncionarioState(
      funcionarios: funcionarios ?? this.funcionarios,
      funcionarioStatusUI: funcionarioStatusUI ?? this.funcionarioStatusUI,
      loadedFuncionario: loadedFuncionario ?? this.loadedFuncionario,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      nome: nome ?? this.nome,
      dataNascimento: dataNascimento ?? this.dataNascimento,
      identificador: identificador ?? this.identificador,
      telefone: telefone ?? this.telefone,
      dataCadastro: dataCadastro ?? this.dataCadastro,
      valorBase: valorBase ?? this.valorBase,
    );
  }

  @override
  List<Object> get props => [funcionarios, funcionarioStatusUI,
     loadedFuncionario, editMode, deleteStatus, formStatus, generalNotificationKey,
nome,dataNascimento,identificador,telefone,dataCadastro,valorBase,];

  @override
  bool get stringify => true;

  @override
  List<FormzInput> get inputs => [nome,dataNascimento,identificador,telefone,dataCadastro,valorBase,];
}
