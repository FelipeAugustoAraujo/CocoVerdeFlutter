part of 'fornecedor_bloc.dart';

abstract class FornecedorEvent extends Equatable {
  const FornecedorEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitFornecedorList extends FornecedorEvent {}


  
    class InitFornecedorListByProduto extends FornecedorEvent {
      final int produtoId;

      const InitFornecedorListByProduto({required this.produtoId});

      @override
      List<Object> get props => [produtoId];
    }
  

  
    class InitFornecedorListByEndereco extends FornecedorEvent {
      final int enderecoId;

      const InitFornecedorListByEndereco({required this.enderecoId});

      @override
      List<Object> get props => [enderecoId];
    }
  

  
    class InitFornecedorListByEntradaFinanceira extends FornecedorEvent {
      final int entradaFinanceiraId;

      const InitFornecedorListByEntradaFinanceira({required this.entradaFinanceiraId});

      @override
      List<Object> get props => [entradaFinanceiraId];
    }
  

class NomeChanged extends FornecedorEvent {
  final String nome;

  const NomeChanged({required this.nome});

  @override
  List<Object> get props => [nome];
}
class IdentificadorChanged extends FornecedorEvent {
  final String identificador;

  const IdentificadorChanged({required this.identificador});

  @override
  List<Object> get props => [identificador];
}
class TelefoneChanged extends FornecedorEvent {
  final String telefone;

  const TelefoneChanged({required this.telefone});

  @override
  List<Object> get props => [telefone];
}
class DataCadastroChanged extends FornecedorEvent {
  final Instant dataCadastro;

  const DataCadastroChanged({required this.dataCadastro});

  @override
  List<Object> get props => [dataCadastro];
}

class FornecedorFormSubmitted extends FornecedorEvent {}

class LoadFornecedorByIdForEdit extends FornecedorEvent {
  final int? id;

  const LoadFornecedorByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteFornecedorById extends FornecedorEvent {
  final int? id;

  const DeleteFornecedorById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadFornecedorByIdForView extends FornecedorEvent {
  final int? id;

  const LoadFornecedorByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
