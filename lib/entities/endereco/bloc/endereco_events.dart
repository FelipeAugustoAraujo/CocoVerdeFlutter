part of 'endereco_bloc.dart';

abstract class EnderecoEvent extends Equatable {
  const EnderecoEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitEnderecoList extends EnderecoEvent {}


  
    class InitEnderecoListByFornecedor extends EnderecoEvent {
      final int fornecedorId;

      const InitEnderecoListByFornecedor({required this.fornecedorId});

      @override
      List<Object> get props => [fornecedorId];
    }
  

  
    class InitEnderecoListByFuncionario extends EnderecoEvent {
      final int funcionarioId;

      const InitEnderecoListByFuncionario({required this.funcionarioId});

      @override
      List<Object> get props => [funcionarioId];
    }
  

  
    class InitEnderecoListByCliente extends EnderecoEvent {
      final int clienteId;

      const InitEnderecoListByCliente({required this.clienteId});

      @override
      List<Object> get props => [clienteId];
    }
  

  
    class InitEnderecoListByCidade extends EnderecoEvent {
      final int cidadeId;

      const InitEnderecoListByCidade({required this.cidadeId});

      @override
      List<Object> get props => [cidadeId];
    }
  

class CepChanged extends EnderecoEvent {
  final String cep;

  const CepChanged({required this.cep});

  @override
  List<Object> get props => [cep];
}
class LogradouroChanged extends EnderecoEvent {
  final String logradouro;

  const LogradouroChanged({required this.logradouro});

  @override
  List<Object> get props => [logradouro];
}
class NumeroChanged extends EnderecoEvent {
  final int numero;

  const NumeroChanged({required this.numero});

  @override
  List<Object> get props => [numero];
}
class ComplementoChanged extends EnderecoEvent {
  final String complemento;

  const ComplementoChanged({required this.complemento});

  @override
  List<Object> get props => [complemento];
}
class BairroChanged extends EnderecoEvent {
  final String bairro;

  const BairroChanged({required this.bairro});

  @override
  List<Object> get props => [bairro];
}

class EnderecoFormSubmitted extends EnderecoEvent {}

class LoadEnderecoByIdForEdit extends EnderecoEvent {
  final int? id;

  const LoadEnderecoByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteEnderecoById extends EnderecoEvent {
  final int? id;

  const DeleteEnderecoById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadEnderecoByIdForView extends EnderecoEvent {
  final int? id;

  const LoadEnderecoByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
