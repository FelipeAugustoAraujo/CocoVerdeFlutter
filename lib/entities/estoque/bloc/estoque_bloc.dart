import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:time_machine/time_machine.dart';

import 'package:Cocoverde/entities/estoque/estoque_model.dart';
import 'package:Cocoverde/entities/estoque/estoque_repository.dart';
import 'package:Cocoverde/entities/estoque/bloc/estoque_form_model.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'estoque_events.dart';
part 'estoque_state.dart';

class EstoqueBloc extends Bloc<EstoqueEvent, EstoqueState> {
  final EstoqueRepository _estoqueRepository;

  final quantidadeController = TextEditingController();
  final criadoEmController = TextEditingController();
  final modificadoEmController = TextEditingController();

  EstoqueBloc({required EstoqueRepository estoqueRepository}) :
        _estoqueRepository = estoqueRepository,
  super(EstoqueState());

  @override
  void onTransition(Transition<EstoqueEvent, EstoqueState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<EstoqueState> mapEventToState(EstoqueEvent event) async* {
    if (event is InitEstoqueList) {
      yield* onInitList(event);

        } else if (event is InitEstoqueListByProduto) {
        yield* onInitEstoqueListByProduto(event);

        } else if (event is InitEstoqueListByEntradaFinanceira) {
        yield* onInitEstoqueListByEntradaFinanceira(event);

        } else if (event is InitEstoqueListBySaidaFinanceira) {
        yield* onInitEstoqueListBySaidaFinanceira(event);
    } else if (event is EstoqueFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadEstoqueByIdForEdit) {
      yield* onLoadEstoqueIdForEdit(event);
    } else if (event is DeleteEstoqueById) {
      yield* onDeleteEstoqueId(event);
    } else if (event is LoadEstoqueByIdForView) {
      yield* onLoadEstoqueIdForView(event);
    }else if (event is QuantidadeChanged){
      yield* onQuantidadeChange(event);
    }else if (event is CriadoEmChanged){
      yield* onCriadoEmChange(event);
    }else if (event is ModificadoEmChanged){
      yield* onModificadoEmChange(event);
    }  }

  Stream<EstoqueState> onInitList(InitEstoqueList event) async* {
    yield this.state.copyWith(estoqueStatusUI: EstoqueStatusUI.loading);
    List<Estoque> estoques = await _estoqueRepository.getAllEstoques();
    yield this.state.copyWith(estoques: estoques, estoqueStatusUI: EstoqueStatusUI.done);
  }


  Stream<EstoqueState> onInitEstoqueListByProduto(InitEstoqueListByProduto event) async* {
    yield this.state.copyWith(estoqueStatusUI: EstoqueStatusUI.loading);
    List<Estoque> estoques = await _estoqueRepository.getAllEstoqueListByProduto(event.produtoId);
    yield this.state.copyWith(estoques: estoques, estoqueStatusUI: EstoqueStatusUI.done);
  }

  Stream<EstoqueState> onInitEstoqueListByEntradaFinanceira(InitEstoqueListByEntradaFinanceira event) async* {
    yield this.state.copyWith(estoqueStatusUI: EstoqueStatusUI.loading);
    List<Estoque> estoques = await _estoqueRepository.getAllEstoqueListByEntradaFinanceira(event.entradaFinanceiraId);
    yield this.state.copyWith(estoques: estoques, estoqueStatusUI: EstoqueStatusUI.done);
  }

  Stream<EstoqueState> onInitEstoqueListBySaidaFinanceira(InitEstoqueListBySaidaFinanceira event) async* {
    yield this.state.copyWith(estoqueStatusUI: EstoqueStatusUI.loading);
    List<Estoque> estoques = await _estoqueRepository.getAllEstoqueListBySaidaFinanceira(event.saidaFinanceiraId);
    yield this.state.copyWith(estoques: estoques, estoqueStatusUI: EstoqueStatusUI.done);
  }

  Stream<EstoqueState> onSubmit() async* {
    if (this.state.isValid) {
      yield this.state.copyWith(formStatus: FormzSubmissionStatus.inProgress);
      try {
        Estoque? result;
        if(this.state.editMode) {
          Estoque newEstoque = Estoque(state.loadedEstoque.id,
            this.state.quantidade.value,
            this.state.criadoEm.value,
            this.state.modificadoEm.value,
            null,
            null,
            null,
          );

          result = await _estoqueRepository.update(newEstoque);
        } else {
          Estoque newEstoque = Estoque(null,
            this.state.quantidade.value,
            this.state.criadoEm.value,
            this.state.modificadoEm.value,
            null,
            null,
            null,
          );

          result = await _estoqueRepository.create(newEstoque);
        }

        yield this.state.copyWith(formStatus: FormzSubmissionStatus.success,
            generalNotificationKey: HttpUtils.successResult);
            } catch (e) {
        yield this.state.copyWith(formStatus: FormzSubmissionStatus.failure,
            generalNotificationKey: HttpUtils.errorServerKey);
      }
    }
  }

  Stream<EstoqueState> onLoadEstoqueIdForEdit(LoadEstoqueByIdForEdit? event) async* {
    yield this.state.copyWith(estoqueStatusUI: EstoqueStatusUI.loading);
    Estoque loadedEstoque = await _estoqueRepository.getEstoque(event?.id);

    final quantidade = QuantidadeInput.dirty((loadedEstoque.quantidade != null ? loadedEstoque.quantidade: 0)!);
    final criadoEm = CriadoEmInput.dirty((loadedEstoque.criadoEm != null ? loadedEstoque.criadoEm: null)!);
    final modificadoEm = ModificadoEmInput.dirty((loadedEstoque.modificadoEm != null ? loadedEstoque.modificadoEm: null)!);

    yield this.state.copyWith(loadedEstoque: loadedEstoque, editMode: true,
      quantidade: quantidade,
      criadoEm: criadoEm,
      modificadoEm: modificadoEm,
    estoqueStatusUI: EstoqueStatusUI.done);

    quantidadeController.text = loadedEstoque.quantidade!.toString();
    criadoEmController.text = DateFormat.yMMMMd('en').format(loadedEstoque.criadoEm!.toDateTimeLocal());
    modificadoEmController.text = DateFormat.yMMMMd('en').format(loadedEstoque.modificadoEm!.toDateTimeLocal());
  }

  Stream<EstoqueState> onDeleteEstoqueId(DeleteEstoqueById event) async* {
    try {
      await _estoqueRepository.delete(event.id!);
      this.add(InitEstoqueList());
      yield this.state.copyWith(deleteStatus: EstoqueDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: EstoqueDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: EstoqueDeleteStatus.none);
  }

  Stream<EstoqueState> onLoadEstoqueIdForView(LoadEstoqueByIdForView event) async* {
    yield this.state.copyWith(estoqueStatusUI: EstoqueStatusUI.loading);
    try {
      Estoque loadedEstoque = await _estoqueRepository.getEstoque(event.id);
      yield this.state.copyWith(loadedEstoque: loadedEstoque, estoqueStatusUI: EstoqueStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedEstoque: null, estoqueStatusUI: EstoqueStatusUI.error);
    }
  }


  Stream<EstoqueState> onQuantidadeChange(QuantidadeChanged event) async* {
    final quantidade = QuantidadeInput.dirty(event.quantidade);
    yield this.state.copyWith(
      quantidade: quantidade,
    );
  }
  Stream<EstoqueState> onCriadoEmChange(CriadoEmChanged event) async* {
    final criadoEm = CriadoEmInput.dirty(event.criadoEm);
    yield this.state.copyWith(
      criadoEm: criadoEm,
    );
  }
  Stream<EstoqueState> onModificadoEmChange(ModificadoEmChanged event) async* {
    final modificadoEm = ModificadoEmInput.dirty(event.modificadoEm);
    yield this.state.copyWith(
      modificadoEm: modificadoEm,
    );
  }

  @override
  Future<void> close() {
    quantidadeController.dispose();
    criadoEmController.dispose();
    modificadoEmController.dispose();
    return super.close();
  }

}
