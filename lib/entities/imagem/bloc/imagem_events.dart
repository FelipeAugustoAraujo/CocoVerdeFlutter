part of 'imagem_bloc.dart';

abstract class ImagemEvent extends Equatable {
  const ImagemEvent();

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

class InitImagemList extends ImagemEvent {}


  
    class InitImagemListBySaidaFinanceira extends ImagemEvent {
      final int saidaFinanceiraId;

      const InitImagemListBySaidaFinanceira({required this.saidaFinanceiraId});

      @override
      List<Object> get props => [saidaFinanceiraId];
    }
  

  
    class InitImagemListByEntradaFinanceira extends ImagemEvent {
      final int entradaFinanceiraId;

      const InitImagemListByEntradaFinanceira({required this.entradaFinanceiraId});

      @override
      List<Object> get props => [entradaFinanceiraId];
    }
  

class NameChanged extends ImagemEvent {
  final String name;

  const NameChanged({required this.name});

  @override
  List<Object> get props => [name];
}
class ContentTypeChanged extends ImagemEvent {
  final String contentType;

  const ContentTypeChanged({required this.contentType});

  @override
  List<Object> get props => [contentType];
}
class DescriptionChanged extends ImagemEvent {
  final String description;

  const DescriptionChanged({required this.description});

  @override
  List<Object> get props => [description];
}

class ImagemFormSubmitted extends ImagemEvent {}

class LoadImagemByIdForEdit extends ImagemEvent {
  final int? id;

  const LoadImagemByIdForEdit({required this.id});

  @override
  List<Object> get props => [id as int];
}

class DeleteImagemById extends ImagemEvent {
  final int? id;

  const DeleteImagemById({required this.id});

  @override
  List<Object> get props => [id as int];
}

class LoadImagemByIdForView extends ImagemEvent {
  final int? id;

  const LoadImagemByIdForView({required this.id});

  @override
  List<Object> get props => [id as int];
}
