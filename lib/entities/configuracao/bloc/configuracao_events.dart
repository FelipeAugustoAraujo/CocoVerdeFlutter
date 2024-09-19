part of 'configuracao_bloc.dart';

abstract class ConfiguracaoEvent extends Equatable {
  const ConfiguracaoEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitConfiguracaoList extends ConfiguracaoEvent {}



class ConfiguracaoFormSubmitted extends ConfiguracaoEvent {}

class LoadConfiguracaoByIdForEdit extends ConfiguracaoEvent {
  final int? id;

  const LoadConfiguracaoByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteConfiguracaoById extends ConfiguracaoEvent {
  final int? id;

  const DeleteConfiguracaoById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadConfiguracaoByIdForView extends ConfiguracaoEvent {
  final int? id;

  const LoadConfiguracaoByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
