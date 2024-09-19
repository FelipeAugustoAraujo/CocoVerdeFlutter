import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:time_machine/time_machine.dart';

import 'package:cocoverde/entities/detalhes_saida_financeira/detalhes_saida_financeira_model.dart';
import 'package:cocoverde/entities/detalhes_saida_financeira/detalhes_saida_financeira_repository.dart';
import 'package:cocoverde/entities/detalhes_saida_financeira/bloc/detalhes_saida_financeira_form_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'detalhes_saida_financeira_events.dart';
part 'detalhes_saida_financeira_state.dart';

class DetalhesSaidaFinanceiraBloc extends Bloc<DetalhesSaidaFinanceiraEvent, DetalhesSaidaFinanceiraState> {
  final DetalhesSaidaFinanceiraRepository _detalhesSaidaFinanceiraRepository;

  final quantidadeItemController = TextEditingController();
  final valorController = TextEditingController();

  DetalhesSaidaFinanceiraBloc({required DetalhesSaidaFinanceiraRepository detalhesSaidaFinanceiraRepository}) :
        _detalhesSaidaFinanceiraRepository = detalhesSaidaFinanceiraRepository,
  super(DetalhesSaidaFinanceiraState());

  @override
  void onTransition(Transition<DetalhesSaidaFinanceiraEvent, DetalhesSaidaFinanceiraState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<DetalhesSaidaFinanceiraState> mapEventToState(DetalhesSaidaFinanceiraEvent event) async* {
    if (event is InitDetalhesSaidaFinanceiraList) {
      yield* onInitList(event);
    } else if (event is DetalhesSaidaFinanceiraFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadDetalhesSaidaFinanceiraByIdForEdit) {
      yield* onLoadDetalhesSaidaFinanceiraIdForEdit(event);
    } else if (event is DeleteDetalhesSaidaFinanceiraById) {
      yield* onDeleteDetalhesSaidaFinanceiraId(event);
    } else if (event is LoadDetalhesSaidaFinanceiraByIdForView) {
      yield* onLoadDetalhesSaidaFinanceiraIdForView(event);
    }else if (event is QuantidadeItemChanged){
      yield* onQuantidadeItemChange(event);
    }else if (event is ValorChanged){
      yield* onValorChange(event);
    }  }

  Stream<DetalhesSaidaFinanceiraState> onInitList(InitDetalhesSaidaFinanceiraList event) async* {
    yield this.state.copyWith(detalhesSaidaFinanceiraStatusUI: DetalhesSaidaFinanceiraStatusUI.loading);
    List<DetalhesSaidaFinanceira> detalhesSaidaFinanceiras = await _detalhesSaidaFinanceiraRepository.getAllDetalhesSaidaFinanceiras();
    yield this.state.copyWith(detalhesSaidaFinanceiras: detalhesSaidaFinanceiras, detalhesSaidaFinanceiraStatusUI: DetalhesSaidaFinanceiraStatusUI.done);
  }


  Stream<DetalhesSaidaFinanceiraState> onSubmit() async* {
    if (this.state.isValid) {
      yield this.state.copyWith(formStatus: FormzSubmissionStatus.inProgress);
      try {
        DetalhesSaidaFinanceira? result;
        if(this.state.editMode) {
          DetalhesSaidaFinanceira newDetalhesSaidaFinanceira = DetalhesSaidaFinanceira(state.loadedDetalhesSaidaFinanceira.id,
            this.state.quantidadeItem.value,
            this.state.valor.value,
          );

          result = await _detalhesSaidaFinanceiraRepository.update(newDetalhesSaidaFinanceira);
        } else {
          DetalhesSaidaFinanceira newDetalhesSaidaFinanceira = DetalhesSaidaFinanceira(null,
            this.state.quantidadeItem.value,
            this.state.valor.value,
          );

          result = await _detalhesSaidaFinanceiraRepository.create(newDetalhesSaidaFinanceira);
        }

        if (result == null) {
          yield this.state.copyWith(formStatus: FormzSubmissionStatus.failure,
              generalNotificationKey: HttpUtils.badRequestServerKey);
        } else {
          yield this.state.copyWith(formStatus: FormzSubmissionStatus.success,
              generalNotificationKey: HttpUtils.successResult);
        }
      } catch (e) {
        yield this.state.copyWith(formStatus: FormzSubmissionStatus.failure,
            generalNotificationKey: HttpUtils.errorServerKey);
      }
    }
  }

  Stream<DetalhesSaidaFinanceiraState> onLoadDetalhesSaidaFinanceiraIdForEdit(LoadDetalhesSaidaFinanceiraByIdForEdit? event) async* {
    yield this.state.copyWith(detalhesSaidaFinanceiraStatusUI: DetalhesSaidaFinanceiraStatusUI.loading);
    DetalhesSaidaFinanceira loadedDetalhesSaidaFinanceira = await _detalhesSaidaFinanceiraRepository.getDetalhesSaidaFinanceira(event?.id);

    final quantidadeItem = QuantidadeItemInput.dirty((loadedDetalhesSaidaFinanceira.quantidadeItem != null ? loadedDetalhesSaidaFinanceira.quantidadeItem: 0)!);
    final valor = ValorInput.dirty((loadedDetalhesSaidaFinanceira.valor != null ? loadedDetalhesSaidaFinanceira.valor: '')!);

    yield this.state.copyWith(loadedDetalhesSaidaFinanceira: loadedDetalhesSaidaFinanceira, editMode: true,
      quantidadeItem: quantidadeItem,
      valor: valor,
    detalhesSaidaFinanceiraStatusUI: DetalhesSaidaFinanceiraStatusUI.done);

    quantidadeItemController.text = loadedDetalhesSaidaFinanceira.quantidadeItem!.toString();
    valorController.text = loadedDetalhesSaidaFinanceira.valor!;
  }

  Stream<DetalhesSaidaFinanceiraState> onDeleteDetalhesSaidaFinanceiraId(DeleteDetalhesSaidaFinanceiraById event) async* {
    try {
      await _detalhesSaidaFinanceiraRepository.delete(event.id!);
      this.add(InitDetalhesSaidaFinanceiraList());
      yield this.state.copyWith(deleteStatus: DetalhesSaidaFinanceiraDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: DetalhesSaidaFinanceiraDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: DetalhesSaidaFinanceiraDeleteStatus.none);
  }

  Stream<DetalhesSaidaFinanceiraState> onLoadDetalhesSaidaFinanceiraIdForView(LoadDetalhesSaidaFinanceiraByIdForView event) async* {
    yield this.state.copyWith(detalhesSaidaFinanceiraStatusUI: DetalhesSaidaFinanceiraStatusUI.loading);
    try {
      DetalhesSaidaFinanceira loadedDetalhesSaidaFinanceira = await _detalhesSaidaFinanceiraRepository.getDetalhesSaidaFinanceira(event.id);
      yield this.state.copyWith(loadedDetalhesSaidaFinanceira: loadedDetalhesSaidaFinanceira, detalhesSaidaFinanceiraStatusUI: DetalhesSaidaFinanceiraStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedDetalhesSaidaFinanceira: null, detalhesSaidaFinanceiraStatusUI: DetalhesSaidaFinanceiraStatusUI.error);
    }
  }


  Stream<DetalhesSaidaFinanceiraState> onQuantidadeItemChange(QuantidadeItemChanged event) async* {
    final quantidadeItem = QuantidadeItemInput.dirty(event.quantidadeItem);
    yield this.state.copyWith(
      quantidadeItem: quantidadeItem,
    );
  }
  Stream<DetalhesSaidaFinanceiraState> onValorChange(ValorChanged event) async* {
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
