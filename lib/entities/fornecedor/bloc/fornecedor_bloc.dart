import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:time_machine/time_machine.dart';

import 'package:Cocoverde/entities/fornecedor/fornecedor_model.dart';
import 'package:Cocoverde/entities/fornecedor/fornecedor_repository.dart';
import 'package:Cocoverde/entities/fornecedor/bloc/fornecedor_form_model.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'fornecedor_events.dart';
part 'fornecedor_state.dart';

class FornecedorBloc extends Bloc<FornecedorEvent, FornecedorState> {
  final FornecedorRepository _fornecedorRepository;

  final nomeController = TextEditingController();
  final identificadorController = TextEditingController();
  final telefoneController = TextEditingController();
  final dataCadastroController = TextEditingController();

  FornecedorBloc({required FornecedorRepository fornecedorRepository}) :
        _fornecedorRepository = fornecedorRepository,
  super(FornecedorState());

  @override
  void onTransition(Transition<FornecedorEvent, FornecedorState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<FornecedorState> mapEventToState(FornecedorEvent event) async* {
    if (event is InitFornecedorList) {
      yield* onInitList(event);

        } else if (event is InitFornecedorListByProduto) {
        yield* onInitFornecedorListByProduto(event);

        } else if (event is InitFornecedorListByEndereco) {
        yield* onInitFornecedorListByEndereco(event);

        } else if (event is InitFornecedorListByEntradaFinanceira) {
        yield* onInitFornecedorListByEntradaFinanceira(event);
    } else if (event is FornecedorFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadFornecedorByIdForEdit) {
      yield* onLoadFornecedorIdForEdit(event);
    } else if (event is DeleteFornecedorById) {
      yield* onDeleteFornecedorId(event);
    } else if (event is LoadFornecedorByIdForView) {
      yield* onLoadFornecedorIdForView(event);
    }else if (event is NomeChanged){
      yield* onNomeChange(event);
    }else if (event is IdentificadorChanged){
      yield* onIdentificadorChange(event);
    }else if (event is TelefoneChanged){
      yield* onTelefoneChange(event);
    }else if (event is DataCadastroChanged){
      yield* onDataCadastroChange(event);
    }  }

  Stream<FornecedorState> onInitList(InitFornecedorList event) async* {
    yield this.state.copyWith(fornecedorStatusUI: FornecedorStatusUI.loading);
    List<Fornecedor> fornecedors = await _fornecedorRepository.getAllFornecedors();
    yield this.state.copyWith(fornecedors: fornecedors, fornecedorStatusUI: FornecedorStatusUI.done);
  }


  Stream<FornecedorState> onInitFornecedorListByProduto(InitFornecedorListByProduto event) async* {
    yield this.state.copyWith(fornecedorStatusUI: FornecedorStatusUI.loading);
    List<Fornecedor> fornecedors = await _fornecedorRepository.getAllFornecedorListByProduto(event.produtoId);
    yield this.state.copyWith(fornecedors: fornecedors, fornecedorStatusUI: FornecedorStatusUI.done);
  }

  Stream<FornecedorState> onInitFornecedorListByEndereco(InitFornecedorListByEndereco event) async* {
    yield this.state.copyWith(fornecedorStatusUI: FornecedorStatusUI.loading);
    List<Fornecedor> fornecedors = await _fornecedorRepository.getAllFornecedorListByEndereco(event.enderecoId);
    yield this.state.copyWith(fornecedors: fornecedors, fornecedorStatusUI: FornecedorStatusUI.done);
  }

  Stream<FornecedorState> onInitFornecedorListByEntradaFinanceira(InitFornecedorListByEntradaFinanceira event) async* {
    yield this.state.copyWith(fornecedorStatusUI: FornecedorStatusUI.loading);
    List<Fornecedor> fornecedors = await _fornecedorRepository.getAllFornecedorListByEntradaFinanceira(event.entradaFinanceiraId);
    yield this.state.copyWith(fornecedors: fornecedors, fornecedorStatusUI: FornecedorStatusUI.done);
  }

  Stream<FornecedorState> onSubmit() async* {
    if (this.state.isValid) {
      yield this.state.copyWith(formStatus: FormzSubmissionStatus.inProgress);
      try {
        Fornecedor? result;
        if(this.state.editMode) {
          Fornecedor newFornecedor = Fornecedor(state.loadedFornecedor.id,
            this.state.nome.value,
            this.state.identificador.value,
            this.state.telefone.value,
            this.state.dataCadastro.value,
            null,
            null,
            null,
          );

          result = await _fornecedorRepository.update(newFornecedor);
        } else {
          Fornecedor newFornecedor = Fornecedor(null,
            this.state.nome.value,
            this.state.identificador.value,
            this.state.telefone.value,
            this.state.dataCadastro.value,
            null,
            null,
            null,
          );

          result = await _fornecedorRepository.create(newFornecedor);
        }

        yield this.state.copyWith(formStatus: FormzSubmissionStatus.success,
            generalNotificationKey: HttpUtils.successResult);
            } catch (e) {
        yield this.state.copyWith(formStatus: FormzSubmissionStatus.failure,
            generalNotificationKey: HttpUtils.errorServerKey);
      }
    }
  }

  Stream<FornecedorState> onLoadFornecedorIdForEdit(LoadFornecedorByIdForEdit? event) async* {
    yield this.state.copyWith(fornecedorStatusUI: FornecedorStatusUI.loading);
    Fornecedor loadedFornecedor = await _fornecedorRepository.getFornecedor(event?.id);

    final nome = NomeInput.dirty((loadedFornecedor.nome != null ? loadedFornecedor.nome: '')!);
    final identificador = IdentificadorInput.dirty((loadedFornecedor.identificador != null ? loadedFornecedor.identificador: '')!);
    final telefone = TelefoneInput.dirty((loadedFornecedor.telefone != null ? loadedFornecedor.telefone: '')!);
    final dataCadastro = DataCadastroInput.dirty((loadedFornecedor.dataCadastro != null ? loadedFornecedor.dataCadastro: null)!);

    yield this.state.copyWith(loadedFornecedor: loadedFornecedor, editMode: true,
      nome: nome,
      identificador: identificador,
      telefone: telefone,
      dataCadastro: dataCadastro,
    fornecedorStatusUI: FornecedorStatusUI.done);

    nomeController.text = loadedFornecedor.nome!;
    identificadorController.text = loadedFornecedor.identificador!;
    telefoneController.text = loadedFornecedor.telefone!;
    dataCadastroController.text = DateFormat.yMMMMd('en').format(loadedFornecedor.dataCadastro!.toDateTimeLocal());
  }

  Stream<FornecedorState> onDeleteFornecedorId(DeleteFornecedorById event) async* {
    try {
      await _fornecedorRepository.delete(event.id!);
      this.add(InitFornecedorList());
      yield this.state.copyWith(deleteStatus: FornecedorDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: FornecedorDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: FornecedorDeleteStatus.none);
  }

  Stream<FornecedorState> onLoadFornecedorIdForView(LoadFornecedorByIdForView event) async* {
    yield this.state.copyWith(fornecedorStatusUI: FornecedorStatusUI.loading);
    try {
      Fornecedor loadedFornecedor = await _fornecedorRepository.getFornecedor(event.id);
      yield this.state.copyWith(loadedFornecedor: loadedFornecedor, fornecedorStatusUI: FornecedorStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedFornecedor: null, fornecedorStatusUI: FornecedorStatusUI.error);
    }
  }


  Stream<FornecedorState> onNomeChange(NomeChanged event) async* {
    final nome = NomeInput.dirty(event.nome);
    yield this.state.copyWith(
      nome: nome,
    );
  }
  Stream<FornecedorState> onIdentificadorChange(IdentificadorChanged event) async* {
    final identificador = IdentificadorInput.dirty(event.identificador);
    yield this.state.copyWith(
      identificador: identificador,
    );
  }
  Stream<FornecedorState> onTelefoneChange(TelefoneChanged event) async* {
    final telefone = TelefoneInput.dirty(event.telefone);
    yield this.state.copyWith(
      telefone: telefone,
    );
  }
  Stream<FornecedorState> onDataCadastroChange(DataCadastroChanged event) async* {
    final dataCadastro = DataCadastroInput.dirty(event.dataCadastro);
    yield this.state.copyWith(
      dataCadastro: dataCadastro,
    );
  }

  @override
  Future<void> close() {
    nomeController.dispose();
    identificadorController.dispose();
    telefoneController.dispose();
    dataCadastroController.dispose();
    return super.close();
  }

}
