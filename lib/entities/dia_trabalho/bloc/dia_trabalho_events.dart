part of 'dia_trabalho_bloc.dart';

abstract class DiaTrabalhoEvent extends Equatable {
  const DiaTrabalhoEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitDiaTrabalhoList extends DiaTrabalhoEvent {}


class DataChanged extends DiaTrabalhoEvent {
  final Instant data;

  const DataChanged({required this.data});

  @override
  List<Object> get props => [data];
}

class DiaTrabalhoFormSubmitted extends DiaTrabalhoEvent {}

class LoadDiaTrabalhoByIdForEdit extends DiaTrabalhoEvent {
  final int? id;

  const LoadDiaTrabalhoByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteDiaTrabalhoById extends DiaTrabalhoEvent {
  final int? id;

  const DeleteDiaTrabalhoById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadDiaTrabalhoByIdForView extends DiaTrabalhoEvent {
  final int? id;

  const LoadDiaTrabalhoByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
