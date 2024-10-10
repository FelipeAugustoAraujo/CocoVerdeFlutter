import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:Cocoverde/entities/endereco/endereco_model.dart';
import 'package:Cocoverde/entities/endereco/endereco_repository.dart';
import 'package:Cocoverde/entities/endereco/bloc/endereco_form_model.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';

part 'endereco_events.dart';
part 'endereco_state.dart';

class EnderecoBloc extends Bloc<EnderecoEvent, EnderecoState> {
  final EnderecoRepository _enderecoRepository;

  final cepController = TextEditingController();
  final logradouroController = TextEditingController();
  final numeroController = TextEditingController();
  final complementoController = TextEditingController();
  final bairroController = TextEditingController();

  EnderecoBloc({required EnderecoRepository enderecoRepository}) :
        _enderecoRepository = enderecoRepository,
  super(EnderecoState());

  @override
  void onTransition(Transition<EnderecoEvent, EnderecoState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<EnderecoState> mapEventToState(EnderecoEvent event) async* {
    if (event is InitEnderecoList) {
      yield* onInitList(event);

        } else if (event is InitEnderecoListByFornecedor) {
        yield* onInitEnderecoListByFornecedor(event);

        } else if (event is InitEnderecoListByFuncionario) {
        yield* onInitEnderecoListByFuncionario(event);

        } else if (event is InitEnderecoListByCliente) {
        yield* onInitEnderecoListByCliente(event);

        } else if (event is InitEnderecoListByCidade) {
        yield* onInitEnderecoListByCidade(event);
    } else if (event is EnderecoFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadEnderecoByIdForEdit) {
      yield* onLoadEnderecoIdForEdit(event);
    } else if (event is DeleteEnderecoById) {
      yield* onDeleteEnderecoId(event);
    } else if (event is LoadEnderecoByIdForView) {
      yield* onLoadEnderecoIdForView(event);
    }else if (event is CepChanged){
      yield* onCepChange(event);
    }else if (event is LogradouroChanged){
      yield* onLogradouroChange(event);
    }else if (event is NumeroChanged){
      yield* onNumeroChange(event);
    }else if (event is ComplementoChanged){
      yield* onComplementoChange(event);
    }else if (event is BairroChanged){
      yield* onBairroChange(event);
    }  }

  Stream<EnderecoState> onInitList(InitEnderecoList event) async* {
    yield this.state.copyWith(enderecoStatusUI: EnderecoStatusUI.loading);
    List<Endereco> enderecos = await _enderecoRepository.getAllEnderecos();
    yield this.state.copyWith(enderecos: enderecos, enderecoStatusUI: EnderecoStatusUI.done);
  }


  Stream<EnderecoState> onInitEnderecoListByFornecedor(InitEnderecoListByFornecedor event) async* {
    yield this.state.copyWith(enderecoStatusUI: EnderecoStatusUI.loading);
    List<Endereco> enderecos = await _enderecoRepository.getAllEnderecoListByFornecedor(event.fornecedorId);
    yield this.state.copyWith(enderecos: enderecos, enderecoStatusUI: EnderecoStatusUI.done);
  }

  Stream<EnderecoState> onInitEnderecoListByFuncionario(InitEnderecoListByFuncionario event) async* {
    yield this.state.copyWith(enderecoStatusUI: EnderecoStatusUI.loading);
    List<Endereco> enderecos = await _enderecoRepository.getAllEnderecoListByFuncionario(event.funcionarioId);
    yield this.state.copyWith(enderecos: enderecos, enderecoStatusUI: EnderecoStatusUI.done);
  }

  Stream<EnderecoState> onInitEnderecoListByCliente(InitEnderecoListByCliente event) async* {
    yield this.state.copyWith(enderecoStatusUI: EnderecoStatusUI.loading);
    List<Endereco> enderecos = await _enderecoRepository.getAllEnderecoListByCliente(event.clienteId);
    yield this.state.copyWith(enderecos: enderecos, enderecoStatusUI: EnderecoStatusUI.done);
  }

  Stream<EnderecoState> onInitEnderecoListByCidade(InitEnderecoListByCidade event) async* {
    yield this.state.copyWith(enderecoStatusUI: EnderecoStatusUI.loading);
    List<Endereco> enderecos = await _enderecoRepository.getAllEnderecoListByCidade(event.cidadeId);
    yield this.state.copyWith(enderecos: enderecos, enderecoStatusUI: EnderecoStatusUI.done);
  }

  Stream<EnderecoState> onSubmit() async* {
    if (this.state.isValid) {
      yield this.state.copyWith(formStatus: FormzSubmissionStatus.inProgress);
      try {
        Endereco? result;
        if(this.state.editMode) {
          Endereco newEndereco = Endereco(state.loadedEndereco.id,
            this.state.cep.value,
            this.state.logradouro.value,
            this.state.numero.value,
            this.state.complemento.value,
            this.state.bairro.value,
            null,
            null,
            null,
            null,
          );

          result = await _enderecoRepository.update(newEndereco);
        } else {
          Endereco newEndereco = Endereco(null,
            this.state.cep.value,
            this.state.logradouro.value,
            this.state.numero.value,
            this.state.complemento.value,
            this.state.bairro.value,
            null,
            null,
            null,
            null,
          );

          result = await _enderecoRepository.create(newEndereco);
        }

        yield this.state.copyWith(formStatus: FormzSubmissionStatus.success,
            generalNotificationKey: HttpUtils.successResult);
            } catch (e) {
        yield this.state.copyWith(formStatus: FormzSubmissionStatus.failure,
            generalNotificationKey: HttpUtils.errorServerKey);
      }
    }
  }

  Stream<EnderecoState> onLoadEnderecoIdForEdit(LoadEnderecoByIdForEdit? event) async* {
    yield this.state.copyWith(enderecoStatusUI: EnderecoStatusUI.loading);
    Endereco loadedEndereco = await _enderecoRepository.getEndereco(event?.id);

    final cep = CepInput.dirty((loadedEndereco.cep != null ? loadedEndereco.cep: '')!);
    final logradouro = LogradouroInput.dirty((loadedEndereco.logradouro != null ? loadedEndereco.logradouro: '')!);
    final numero = NumeroInput.dirty((loadedEndereco.numero != null ? loadedEndereco.numero: 0)!);
    final complemento = ComplementoInput.dirty((loadedEndereco.complemento != null ? loadedEndereco.complemento: '')!);
    final bairro = BairroInput.dirty((loadedEndereco.bairro != null ? loadedEndereco.bairro: '')!);

    yield this.state.copyWith(loadedEndereco: loadedEndereco, editMode: true,
      cep: cep,
      logradouro: logradouro,
      numero: numero,
      complemento: complemento,
      bairro: bairro,
    enderecoStatusUI: EnderecoStatusUI.done);

    cepController.text = loadedEndereco.cep!;
    logradouroController.text = loadedEndereco.logradouro!;
    numeroController.text = loadedEndereco.numero!.toString();
    complementoController.text = loadedEndereco.complemento!;
    bairroController.text = loadedEndereco.bairro!;
  }

  Stream<EnderecoState> onDeleteEnderecoId(DeleteEnderecoById event) async* {
    try {
      await _enderecoRepository.delete(event.id!);
      this.add(InitEnderecoList());
      yield this.state.copyWith(deleteStatus: EnderecoDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: EnderecoDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: EnderecoDeleteStatus.none);
  }

  Stream<EnderecoState> onLoadEnderecoIdForView(LoadEnderecoByIdForView event) async* {
    yield this.state.copyWith(enderecoStatusUI: EnderecoStatusUI.loading);
    try {
      Endereco loadedEndereco = await _enderecoRepository.getEndereco(event.id);
      yield this.state.copyWith(loadedEndereco: loadedEndereco, enderecoStatusUI: EnderecoStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedEndereco: null, enderecoStatusUI: EnderecoStatusUI.error);
    }
  }


  Stream<EnderecoState> onCepChange(CepChanged event) async* {
    final cep = CepInput.dirty(event.cep);
    yield this.state.copyWith(
      cep: cep,
    );
  }
  Stream<EnderecoState> onLogradouroChange(LogradouroChanged event) async* {
    final logradouro = LogradouroInput.dirty(event.logradouro);
    yield this.state.copyWith(
      logradouro: logradouro,
    );
  }
  Stream<EnderecoState> onNumeroChange(NumeroChanged event) async* {
    final numero = NumeroInput.dirty(event.numero);
    yield this.state.copyWith(
      numero: numero,
    );
  }
  Stream<EnderecoState> onComplementoChange(ComplementoChanged event) async* {
    final complemento = ComplementoInput.dirty(event.complemento);
    yield this.state.copyWith(
      complemento: complemento,
    );
  }
  Stream<EnderecoState> onBairroChange(BairroChanged event) async* {
    final bairro = BairroInput.dirty(event.bairro);
    yield this.state.copyWith(
      bairro: bairro,
    );
  }

  @override
  Future<void> close() {
    cepController.dispose();
    logradouroController.dispose();
    numeroController.dispose();
    complementoController.dispose();
    bairroController.dispose();
    return super.close();
  }

}
