import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:Cocoverde/entities/imagem/imagem_model.dart';
import 'package:Cocoverde/entities/imagem/imagem_repository.dart';
import 'package:Cocoverde/entities/imagem/bloc/imagem_form_model.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';

part 'imagem_events.dart';
part 'imagem_state.dart';

class ImagemBloc extends Bloc<ImagemEvent, ImagemState> {
  final ImagemRepository _imagemRepository;

  final nameController = TextEditingController();
  final contentTypeController = TextEditingController();
  final descriptionController = TextEditingController();

  ImagemBloc({required ImagemRepository imagemRepository}) :
        _imagemRepository = imagemRepository,
  super(ImagemState());

  @override
  void onTransition(Transition<ImagemEvent, ImagemState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<ImagemState> mapEventToState(ImagemEvent event) async* {
    if (event is InitImagemList) {
      yield* onInitList(event);

        } else if (event is InitImagemListBySaidaFinanceira) {
        yield* onInitImagemListBySaidaFinanceira(event);

        } else if (event is InitImagemListByEntradaFinanceira) {
        yield* onInitImagemListByEntradaFinanceira(event);
    } else if (event is ImagemFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadImagemByIdForEdit) {
      yield* onLoadImagemIdForEdit(event);
    } else if (event is DeleteImagemById) {
      yield* onDeleteImagemId(event);
    } else if (event is LoadImagemByIdForView) {
      yield* onLoadImagemIdForView(event);
    }else if (event is NameChanged){
      yield* onNameChange(event);
    }else if (event is ContentTypeChanged){
      yield* onContentTypeChange(event);
    }else if (event is DescriptionChanged){
      yield* onDescriptionChange(event);
    }  }

  Stream<ImagemState> onInitList(InitImagemList event) async* {
    yield this.state.copyWith(imagemStatusUI: ImagemStatusUI.loading);
    List<Imagem> imagems = await _imagemRepository.getAllImagems();
    yield this.state.copyWith(imagems: imagems, imagemStatusUI: ImagemStatusUI.done);
  }


  Stream<ImagemState> onInitImagemListBySaidaFinanceira(InitImagemListBySaidaFinanceira event) async* {
    yield this.state.copyWith(imagemStatusUI: ImagemStatusUI.loading);
    List<Imagem> imagems = await _imagemRepository.getAllImagemListBySaidaFinanceira(event.saidaFinanceiraId);
    yield this.state.copyWith(imagems: imagems, imagemStatusUI: ImagemStatusUI.done);
  }

  Stream<ImagemState> onInitImagemListByEntradaFinanceira(InitImagemListByEntradaFinanceira event) async* {
    yield this.state.copyWith(imagemStatusUI: ImagemStatusUI.loading);
    List<Imagem> imagems = await _imagemRepository.getAllImagemListByEntradaFinanceira(event.entradaFinanceiraId);
    yield this.state.copyWith(imagems: imagems, imagemStatusUI: ImagemStatusUI.done);
  }

  Stream<ImagemState> onSubmit() async* {
    if (this.state.isValid) {
      yield this.state.copyWith(formStatus: FormzSubmissionStatus.inProgress);
      try {
        Imagem? result;
        if(this.state.editMode) {
          Imagem newImagem = Imagem(state.loadedImagem.id,
            this.state.name.value,
            this.state.contentType.value,
            this.state.description.value,
            null,
            null,
          );

          result = await _imagemRepository.update(newImagem);
        } else {
          Imagem newImagem = Imagem(null,
            this.state.name.value,
            this.state.contentType.value,
            this.state.description.value,
            null,
            null,
          );

          result = await _imagemRepository.create(newImagem);
        }

        yield this.state.copyWith(formStatus: FormzSubmissionStatus.success,
            generalNotificationKey: HttpUtils.successResult);
            } catch (e) {
        yield this.state.copyWith(formStatus: FormzSubmissionStatus.failure,
            generalNotificationKey: HttpUtils.errorServerKey);
      }
    }
  }

  Stream<ImagemState> onLoadImagemIdForEdit(LoadImagemByIdForEdit? event) async* {
    yield this.state.copyWith(imagemStatusUI: ImagemStatusUI.loading);
    Imagem loadedImagem = await _imagemRepository.getImagem(event?.id);

    final name = NameInput.dirty((loadedImagem.name != null ? loadedImagem.name: '')!);
    final contentType = ContentTypeInput.dirty((loadedImagem.contentType != null ? loadedImagem.contentType: '')!);
    final description = DescriptionInput.dirty((loadedImagem.description != null ? loadedImagem.description: '')!);

    yield this.state.copyWith(loadedImagem: loadedImagem, editMode: true,
      name: name,
      contentType: contentType,
      description: description,
    imagemStatusUI: ImagemStatusUI.done);

    nameController.text = loadedImagem.name!;
    contentTypeController.text = loadedImagem.contentType!;
    descriptionController.text = loadedImagem.description!;
  }

  Stream<ImagemState> onDeleteImagemId(DeleteImagemById event) async* {
    try {
      await _imagemRepository.delete(event.id!);
      this.add(InitImagemList());
      yield this.state.copyWith(deleteStatus: ImagemDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: ImagemDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: ImagemDeleteStatus.none);
  }

  Stream<ImagemState> onLoadImagemIdForView(LoadImagemByIdForView event) async* {
    yield this.state.copyWith(imagemStatusUI: ImagemStatusUI.loading);
    try {
      Imagem loadedImagem = await _imagemRepository.getImagem(event.id);
      yield this.state.copyWith(loadedImagem: loadedImagem, imagemStatusUI: ImagemStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedImagem: null, imagemStatusUI: ImagemStatusUI.error);
    }
  }


  Stream<ImagemState> onNameChange(NameChanged event) async* {
    final name = NameInput.dirty(event.name);
    yield this.state.copyWith(
      name: name,
    );
  }
  Stream<ImagemState> onContentTypeChange(ContentTypeChanged event) async* {
    final contentType = ContentTypeInput.dirty(event.contentType);
    yield this.state.copyWith(
      contentType: contentType,
    );
  }
  Stream<ImagemState> onDescriptionChange(DescriptionChanged event) async* {
    final description = DescriptionInput.dirty(event.description);
    yield this.state.copyWith(
      description: description,
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    contentTypeController.dispose();
    descriptionController.dispose();
    return super.close();
  }

}
