import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:Cocoverde/entities/cidade/cidade_model.dart';
import 'package:Cocoverde/entities/cidade/cidade_repository.dart';
import 'package:Cocoverde/entities/cidade/bloc/cidade_form_model.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';

part 'cidade_events.dart';
part 'cidade_state.dart';

class CidadeBloc extends Bloc<CidadeEvent, CidadeState> {
  final CidadeRepository _cidadeRepository;

  final nomeController = TextEditingController();

  CidadeBloc({required CidadeRepository cidadeRepository}) :
        _cidadeRepository = cidadeRepository,
  super(CidadeState());

  @override
  void onTransition(Transition<CidadeEvent, CidadeState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<CidadeState> mapEventToState(CidadeEvent event) async* {
    if (event is InitCidadeList) {
      yield* onInitList(event);

        } else if (event is InitCidadeListByEndereco) {
        yield* onInitCidadeListByEndereco(event);
    } else if (event is CidadeFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadCidadeByIdForEdit) {
      yield* onLoadCidadeIdForEdit(event);
    } else if (event is DeleteCidadeById) {
      yield* onDeleteCidadeId(event);
    } else if (event is LoadCidadeByIdForView) {
      yield* onLoadCidadeIdForView(event);
    }else if (event is NomeChanged){
      yield* onNomeChange(event);
    }else if (event is EstadoChanged){
      yield* onEstadoChange(event);
    }  }

  Stream<CidadeState> onInitList(InitCidadeList event) async* {
    yield this.state.copyWith(cidadeStatusUI: CidadeStatusUI.loading);
    List<Cidade> cidades = await _cidadeRepository.getAllCidades();
    yield this.state.copyWith(cidades: cidades, cidadeStatusUI: CidadeStatusUI.done);
  }


  Stream<CidadeState> onInitCidadeListByEndereco(InitCidadeListByEndereco event) async* {
    yield this.state.copyWith(cidadeStatusUI: CidadeStatusUI.loading);
    List<Cidade> cidades = await _cidadeRepository.getAllCidadeListByEndereco(event.enderecoId);
    yield this.state.copyWith(cidades: cidades, cidadeStatusUI: CidadeStatusUI.done);
  }

  Stream<CidadeState> onSubmit() async* {
    if (this.state.isValid) {
      yield this.state.copyWith(formStatus: FormzSubmissionStatus.inProgress);
      try {
        Cidade? result;
        if(this.state.editMode) {
          Cidade newCidade = Cidade(state.loadedCidade.id,
            this.state.nome.value,
            this.state.estado.value,
            null,
          );

          result = await _cidadeRepository.update(newCidade);
        } else {
          Cidade newCidade = Cidade(null,
            this.state.nome.value,
            this.state.estado.value,
            null,
          );

          result = await _cidadeRepository.create(newCidade);
        }

        yield this.state.copyWith(formStatus: FormzSubmissionStatus.success,
            generalNotificationKey: HttpUtils.successResult);
            } catch (e) {
        yield this.state.copyWith(formStatus: FormzSubmissionStatus.failure,
            generalNotificationKey: HttpUtils.errorServerKey);
      }
    }
  }

  Stream<CidadeState> onLoadCidadeIdForEdit(LoadCidadeByIdForEdit? event) async* {
    yield this.state.copyWith(cidadeStatusUI: CidadeStatusUI.loading);
    Cidade loadedCidade = await _cidadeRepository.getCidade(event?.id);

    final nome = NomeInput.dirty((loadedCidade.nome != null ? loadedCidade.nome: '')!);
    final estado = EstadoInput.dirty((loadedCidade.estado != null ? loadedCidade.estado: null)!);

    yield this.state.copyWith(loadedCidade: loadedCidade, editMode: true,
      nome: nome,
      estado: estado,
    cidadeStatusUI: CidadeStatusUI.done);

    nomeController.text = loadedCidade.nome!;
  }

  Stream<CidadeState> onDeleteCidadeId(DeleteCidadeById event) async* {
    try {
      await _cidadeRepository.delete(event.id!);
      this.add(InitCidadeList());
      yield this.state.copyWith(deleteStatus: CidadeDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: CidadeDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: CidadeDeleteStatus.none);
  }

  Stream<CidadeState> onLoadCidadeIdForView(LoadCidadeByIdForView event) async* {
    yield this.state.copyWith(cidadeStatusUI: CidadeStatusUI.loading);
    try {
      Cidade loadedCidade = await _cidadeRepository.getCidade(event.id);
      yield this.state.copyWith(loadedCidade: loadedCidade, cidadeStatusUI: CidadeStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedCidade: null, cidadeStatusUI: CidadeStatusUI.error);
    }
  }


  Stream<CidadeState> onNomeChange(NomeChanged event) async* {
    final nome = NomeInput.dirty(event.nome);
    yield this.state.copyWith(
      nome: nome,
    );
  }
  Stream<CidadeState> onEstadoChange(EstadoChanged event) async* {
    final estado = EstadoInput.dirty(event.estado);
    yield this.state.copyWith(
      estado: estado,
    );
  }

  @override
  Future<void> close() {
    nomeController.dispose();
    return super.close();
  }

}
