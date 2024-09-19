part of 'cidade_bloc.dart';

abstract class CidadeEvent extends Equatable {
  const CidadeEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitCidadeList extends CidadeEvent {}


  
    class InitCidadeListByEndereco extends CidadeEvent {
      final int enderecoId;

      const InitCidadeListByEndereco({required this.enderecoId});

      @override
      List<Object> get props => [enderecoId];
    }
  

class NomeChanged extends CidadeEvent {
  final String nome;

  const NomeChanged({required this.nome});

  @override
  List<Object> get props => [nome];
}
class EstadoChanged extends CidadeEvent {
  final Estado estado;

  const EstadoChanged({required this.estado});

  @override
  List<Object> get props => [estado];
}

class CidadeFormSubmitted extends CidadeEvent {}

class LoadCidadeByIdForEdit extends CidadeEvent {
  final int? id;

  const LoadCidadeByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteCidadeById extends CidadeEvent {
  final int? id;

  const DeleteCidadeById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadCidadeByIdForView extends CidadeEvent {
  final int? id;

  const LoadCidadeByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
