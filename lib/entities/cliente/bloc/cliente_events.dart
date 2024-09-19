part of 'cliente_bloc.dart';

abstract class ClienteEvent extends Equatable {
  const ClienteEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitClienteList extends ClienteEvent {}


  
    class InitClienteListByEndereco extends ClienteEvent {
      final int enderecoId;

      const InitClienteListByEndereco({required this.enderecoId});

      @override
      List<Object> get props => [enderecoId];
    }
  

class NomeChanged extends ClienteEvent {
  final String nome;

  const NomeChanged({required this.nome});

  @override
  List<Object> get props => [nome];
}
class DataNascimentoChanged extends ClienteEvent {
  final String dataNascimento;

  const DataNascimentoChanged({required this.dataNascimento});

  @override
  List<Object> get props => [dataNascimento];
}
class IdentificadorChanged extends ClienteEvent {
  final String identificador;

  const IdentificadorChanged({required this.identificador});

  @override
  List<Object> get props => [identificador];
}
class DataCadastroChanged extends ClienteEvent {
  final Instant dataCadastro;

  const DataCadastroChanged({required this.dataCadastro});

  @override
  List<Object> get props => [dataCadastro];
}
class TelefoneChanged extends ClienteEvent {
  final String telefone;

  const TelefoneChanged({required this.telefone});

  @override
  List<Object> get props => [telefone];
}

class ClienteFormSubmitted extends ClienteEvent {}

class LoadClienteByIdForEdit extends ClienteEvent {
  final int? id;

  const LoadClienteByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteClienteById extends ClienteEvent {
  final int? id;

  const DeleteClienteById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadClienteByIdForView extends ClienteEvent {
  final int? id;

  const LoadClienteByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
