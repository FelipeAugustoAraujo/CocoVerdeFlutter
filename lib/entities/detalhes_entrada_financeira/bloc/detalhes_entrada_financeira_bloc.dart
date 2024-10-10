import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:Cocoverde/entities/detalhes_entrada_financeira/detalhes_entrada_financeira_model.dart';
import 'package:Cocoverde/entities/detalhes_entrada_financeira/detalhes_entrada_financeira_repository.dart';
import 'package:Cocoverde/entities/detalhes_entrada_financeira/bloc/detalhes_entrada_financeira_form_model.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';

part 'detalhes_entrada_financeira_events.dart';
part 'detalhes_entrada_financeira_state.dart';

class DetalhesEntradaFinanceiraBloc extends Bloc<DetalhesEntradaFinanceiraEvent, DetalhesEntradaFinanceiraState> {
  final DetalhesEntradaFinanceiraRepository _detalhesEntradaFinanceiraRepository;

  final quantidadeItemController = TextEditingController();
  final valorController = TextEditingController();

  DetalhesEntradaFinanceiraBloc({required DetalhesEntradaFinanceiraRepository detalhesEntradaFinanceiraRepository}) :
        _detalhesEntradaFinanceiraRepository = detalhesEntradaFinanceiraRepository,
  super(DetalhesEntradaFinanceiraState());

  @override
  void onTransition(Transition<DetalhesEntradaFinanceiraEvent, DetalhesEntradaFinanceiraState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<DetalhesEntradaFinanceiraState> mapEventToState(DetalhesEntradaFinanceiraEvent event) async* {
    if (event is InitDetalhesEntradaFinanceiraList) {
      yield* onInitList(event);

        } else if (event is InitDetalhesEntradaFinanceiraListByProduto) {
        yield* onInitDetalhesEntradaFinanceiraListByProduto(event);

        } else if (event is InitDetalhesEntradaFinanceiraListByEntradaFinanceira) {
        yield* onInitDetalhesEntradaFinanceiraListByEntradaFinanceira(event);
    } else if (event is DetalhesEntradaFinanceiraFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadDetalhesEntradaFinanceiraByIdForEdit) {
      yield* onLoadDetalhesEntradaFinanceiraIdForEdit(event);
    } else if (event is DeleteDetalhesEntradaFinanceiraById) {
      yield* onDeleteDetalhesEntradaFinanceiraId(event);
    } else if (event is LoadDetalhesEntradaFinanceiraByIdForView) {
      yield* onLoadDetalhesEntradaFinanceiraIdForView(event);
    }else if (event is QuantidadeItemChanged){
      yield* onQuantidadeItemChange(event);
    }else if (event is ValorChanged){
      yield* onValorChange(event);
    }  }

  Stream<DetalhesEntradaFinanceiraState> onInitList(InitDetalhesEntradaFinanceiraList event) async* {
    yield this.state.copyWith(detalhesEntradaFinanceiraStatusUI: DetalhesEntradaFinanceiraStatusUI.loading);
    List<DetalhesEntradaFinanceira> detalhesEntradaFinanceiras = await _detalhesEntradaFinanceiraRepository.getAllDetalhesEntradaFinanceiras();
    yield this.state.copyWith(detalhesEntradaFinanceiras: detalhesEntradaFinanceiras, detalhesEntradaFinanceiraStatusUI: DetalhesEntradaFinanceiraStatusUI.done);
  }


  Stream<DetalhesEntradaFinanceiraState> onInitDetalhesEntradaFinanceiraListByProduto(InitDetalhesEntradaFinanceiraListByProduto event) async* {
    yield this.state.copyWith(detalhesEntradaFinanceiraStatusUI: DetalhesEntradaFinanceiraStatusUI.loading);
    List<DetalhesEntradaFinanceira> detalhesEntradaFinanceiras = await _detalhesEntradaFinanceiraRepository.getAllDetalhesEntradaFinanceiraListByProduto(event.produtoId);
    yield this.state.copyWith(detalhesEntradaFinanceiras: detalhesEntradaFinanceiras, detalhesEntradaFinanceiraStatusUI: DetalhesEntradaFinanceiraStatusUI.done);
  }

  Stream<DetalhesEntradaFinanceiraState> onInitDetalhesEntradaFinanceiraListByEntradaFinanceira(InitDetalhesEntradaFinanceiraListByEntradaFinanceira event) async* {
    yield this.state.copyWith(detalhesEntradaFinanceiraStatusUI: DetalhesEntradaFinanceiraStatusUI.loading);
    List<DetalhesEntradaFinanceira> detalhesEntradaFinanceiras = await _detalhesEntradaFinanceiraRepository.getAllDetalhesEntradaFinanceiraListByEntradaFinanceira(event.entradaFinanceiraId);
    yield this.state.copyWith(detalhesEntradaFinanceiras: detalhesEntradaFinanceiras, detalhesEntradaFinanceiraStatusUI: DetalhesEntradaFinanceiraStatusUI.done);
  }

  Stream<DetalhesEntradaFinanceiraState> onSubmit() async* {
    if (this.state.isValid) {
      yield this.state.copyWith(formStatus: FormzSubmissionStatus.inProgress);
      try {
        DetalhesEntradaFinanceira? result;
        if(this.state.editMode) {
          DetalhesEntradaFinanceira newDetalhesEntradaFinanceira = DetalhesEntradaFinanceira(state.loadedDetalhesEntradaFinanceira.id,
            this.state.quantidadeItem.value,
            this.state.valor.value,
            null,
            null,
          );

          result = await _detalhesEntradaFinanceiraRepository.update(newDetalhesEntradaFinanceira);
        } else {
          DetalhesEntradaFinanceira newDetalhesEntradaFinanceira = DetalhesEntradaFinanceira(null,
            this.state.quantidadeItem.value,
            this.state.valor.value,
            null,
            null,
          );

          result = await _detalhesEntradaFinanceiraRepository.create(newDetalhesEntradaFinanceira);
        }

        yield this.state.copyWith(formStatus: FormzSubmissionStatus.success,
            generalNotificationKey: HttpUtils.successResult);
            } catch (e) {
        yield this.state.copyWith(formStatus: FormzSubmissionStatus.failure,
            generalNotificationKey: HttpUtils.errorServerKey);
      }
    }
  }

  Stream<DetalhesEntradaFinanceiraState> onLoadDetalhesEntradaFinanceiraIdForEdit(LoadDetalhesEntradaFinanceiraByIdForEdit? event) async* {
    yield this.state.copyWith(detalhesEntradaFinanceiraStatusUI: DetalhesEntradaFinanceiraStatusUI.loading);
    DetalhesEntradaFinanceira loadedDetalhesEntradaFinanceira = await _detalhesEntradaFinanceiraRepository.getDetalhesEntradaFinanceira(event?.id);

    final quantidadeItem = QuantidadeItemInput.dirty((loadedDetalhesEntradaFinanceira.quantidadeItem != null ? loadedDetalhesEntradaFinanceira.quantidadeItem: 0)!);
    final valor = ValorInput.dirty((loadedDetalhesEntradaFinanceira.valor != null ? loadedDetalhesEntradaFinanceira.valor: '')!);

    yield this.state.copyWith(loadedDetalhesEntradaFinanceira: loadedDetalhesEntradaFinanceira, editMode: true,
      quantidadeItem: quantidadeItem,
      valor: valor,
    detalhesEntradaFinanceiraStatusUI: DetalhesEntradaFinanceiraStatusUI.done);

    quantidadeItemController.text = loadedDetalhesEntradaFinanceira.quantidadeItem!.toString();
    valorController.text = loadedDetalhesEntradaFinanceira.valor!;
  }

  Stream<DetalhesEntradaFinanceiraState> onDeleteDetalhesEntradaFinanceiraId(DeleteDetalhesEntradaFinanceiraById event) async* {
    try {
      await _detalhesEntradaFinanceiraRepository.delete(event.id!);
      this.add(InitDetalhesEntradaFinanceiraList());
      yield this.state.copyWith(deleteStatus: DetalhesEntradaFinanceiraDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: DetalhesEntradaFinanceiraDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: DetalhesEntradaFinanceiraDeleteStatus.none);
  }

  Stream<DetalhesEntradaFinanceiraState> onLoadDetalhesEntradaFinanceiraIdForView(LoadDetalhesEntradaFinanceiraByIdForView event) async* {
    yield this.state.copyWith(detalhesEntradaFinanceiraStatusUI: DetalhesEntradaFinanceiraStatusUI.loading);
    try {
      DetalhesEntradaFinanceira loadedDetalhesEntradaFinanceira = await _detalhesEntradaFinanceiraRepository.getDetalhesEntradaFinanceira(event.id);
      yield this.state.copyWith(loadedDetalhesEntradaFinanceira: loadedDetalhesEntradaFinanceira, detalhesEntradaFinanceiraStatusUI: DetalhesEntradaFinanceiraStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedDetalhesEntradaFinanceira: null, detalhesEntradaFinanceiraStatusUI: DetalhesEntradaFinanceiraStatusUI.error);
    }
  }


  Stream<DetalhesEntradaFinanceiraState> onQuantidadeItemChange(QuantidadeItemChanged event) async* {
    final quantidadeItem = QuantidadeItemInput.dirty(event.quantidadeItem);
    yield this.state.copyWith(
      quantidadeItem: quantidadeItem,
    );
  }
  Stream<DetalhesEntradaFinanceiraState> onValorChange(ValorChanged event) async* {
    final valor = ValorInput.dirty(event.valor);
    yield this.state.copyWith(
      valor: valor,
    );
  }

  @override
  Future<void> close() {
    quantidadeItemController.dispose();
    valorController.dispose();
    return super.close();
  }

}
