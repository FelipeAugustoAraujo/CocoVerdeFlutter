part of 'funcionario_bloc.dart';

abstract class FuncionarioEvent extends Equatable {
  const FuncionarioEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitFuncionarioList extends FuncionarioEvent {}


  
    class InitFuncionarioListByEndereco extends FuncionarioEvent {
      final int enderecoId;

      const InitFuncionarioListByEndereco({required this.enderecoId});

      @override
      List<Object> get props => [enderecoId];
    }
  

class NomeChanged extends FuncionarioEvent {
  final String nome;

  const NomeChanged({required this.nome});

  @override
  List<Object> get props => [nome];
}
class DataNascimentoChanged extends FuncionarioEvent {
  final String dataNascimento;

  const DataNascimentoChanged({required this.dataNascimento});

  @override
  List<Object> get props => [dataNascimento];
}
class IdentificadorChanged extends FuncionarioEvent {
  final String identificador;

  const IdentificadorChanged({required this.identificador});

  @override
  List<Object> get props => [identificador];
}
class TelefoneChanged extends FuncionarioEvent {
  final String telefone;

  const TelefoneChanged({required this.telefone});

  @override
  List<Object> get props => [telefone];
}
class DataCadastroChanged extends FuncionarioEvent {
  final Instant dataCadastro;

  const DataCadastroChanged({required this.dataCadastro});

  @override
  List<Object> get props => [dataCadastro];
}
class ValorBaseChanged extends FuncionarioEvent {
  final BigDecimal valorBase;

  const ValorBaseChanged({required this.valorBase});

  @override
  List<Object> get props => [valorBase];
}

class FuncionarioFormSubmitted extends FuncionarioEvent {}

class LoadFuncionarioByIdForEdit extends FuncionarioEvent {
  final int? id;

  const LoadFuncionarioByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteFuncionarioById extends FuncionarioEvent {
  final int? id;

  const DeleteFuncionarioById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadFuncionarioByIdForView extends FuncionarioEvent {
  final int? id;

  const LoadFuncionarioByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
