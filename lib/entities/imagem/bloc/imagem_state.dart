part of 'imagem_bloc.dart';

enum ImagemStatusUI {init, loading, error, done}
enum ImagemDeleteStatus {ok, ko, none}

class ImagemState extends Equatable with FormzMixin {
  final List<Imagem> imagems;
  final Imagem loadedImagem;
  final bool editMode;
  final ImagemDeleteStatus deleteStatus;
  final ImagemStatusUI imagemStatusUI;

  final FormzSubmissionStatus formStatus;
  final String generalNotificationKey;

  final NameInput name;
  final ContentTypeInput contentType;
  final DescriptionInput description;


  ImagemState({
    this.imagems = const [],
    this.imagemStatusUI = ImagemStatusUI.init,
    this.loadedImagem = const Imagem(0,'','','',null,null,),
    this.editMode = false,
    this.formStatus = FormzSubmissionStatus.initial,
    this.generalNotificationKey = '',
    this.deleteStatus = ImagemDeleteStatus.none,
    this.name = const NameInput.pure(),
    this.contentType = const ContentTypeInput.pure(),
    this.description = const DescriptionInput.pure(),
  });

  ImagemState copyWith({
    List<Imagem>? imagems,
    ImagemStatusUI? imagemStatusUI,
    bool? editMode,
    ImagemDeleteStatus? deleteStatus,
    Imagem? loadedImagem,
    FormzSubmissionStatus? formStatus,
    String? generalNotificationKey,
    NameInput? name,
    ContentTypeInput? contentType,
    DescriptionInput? description,
  }) {
    return ImagemState(
      imagems: imagems ?? this.imagems,
      imagemStatusUI: imagemStatusUI ?? this.imagemStatusUI,
      loadedImagem: loadedImagem ?? this.loadedImagem,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      name: name ?? this.name,
      contentType: contentType ?? this.contentType,
      description: description ?? this.description,
    );
  }

  @override
  List<Object> get props => [imagems, imagemStatusUI,
     loadedImagem, editMode, deleteStatus, formStatus, generalNotificationKey,
name,contentType,description,];

  @override
  bool get stringify => true;

  @override
  List<FormzInput> get inputs => [name,contentType,description,];
}
