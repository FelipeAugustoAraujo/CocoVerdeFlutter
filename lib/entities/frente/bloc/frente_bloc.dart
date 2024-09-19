import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:time_machine/time_machine.dart';

import 'package:cocoverde/entities/frente/frente_model.dart';
import 'package:cocoverde/entities/frente/frente_repository.dart';
import 'package:cocoverde/entities/frente/bloc/frente_form_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'frente_events.dart';
part 'frente_state.dart';

class FrenteBloc extends Bloc<FrenteEvent, FrenteState> {
  final FrenteRepository _frenteRepository;

  final quantidadeController = TextEditingController();
  final criadoEmController = TextEditingController();
  final modificadoEmController = TextEditingController();

  FrenteBloc({required FrenteRepository frenteRepository}) :
        _frenteRepository = frenteRepository,
  super(FrenteState());

  @override
  void onTransition(Transition<FrenteEvent, FrenteState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<FrenteState> mapEventToState(FrenteEvent event) async* {
    if (event is InitFrenteList) {
      yield* onInitList(event);

        } else if (event is InitFrenteListByProduto) {
        yield* onInitFrenteListByProduto(event);

        } else if (event is InitFrenteListByEntradaFinanceira) {
        yield* onInitFrenteListByEntradaFinanceira(event);

        } else if (event is InitFrenteListBySaidaFinanceira) {
        yield* onInitFrenteListBySaidaFinanceira(event);
    } else if (event is FrenteFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadFrenteByIdForEdit) {
      yield* onLoadFrenteIdForEdit(event);
    } else if (event is DeleteFrenteById) {
      yield* onDeleteFrenteId(event);
    } else if (event is LoadFrenteByIdForView) {
      yield* onLoadFrenteIdForView(event);
    }else if (event is QuantidadeChanged){
      yield* onQuantidadeChange(event);
    }else if (event is CriadoEmChanged){
      yield* onCriadoEmChange(event);
    }else if (event is ModificadoEmChanged){
      yield* onModificadoEmChange(event);
    }  }

  Stream<FrenteState> onInitList(InitFrenteList event) async* {
    yield this.state.copyWith(frenteStatusUI: FrenteStatusUI.loading);
    List<Frente> frentes = await _frenteRepository.getAllFrentes();
    yield this.state.copyWith(frentes: frentes, frenteStatusUI: FrenteStatusUI.done);
  }


  Stream<FrenteState> onInitFrenteListByProduto(InitFrenteListByProduto event) async* {
    yield this.state.copyWith(frenteStatusUI: FrenteStatusUI.loading);
    List<Frente> frentes = await _frenteRepository.getAllFrenteListByProduto(event.produtoId);
    yield this.state.copyWith(frentes: frentes, frenteStatusUI: FrenteStatusUI.done);
  }

  Stream<FrenteState> onInitFrenteListByEntradaFinanceira(InitFrenteListByEntradaFinanceira event) async* {
    yield this.state.copyWith(frenteStatusUI: FrenteStatusUI.loading);
    List<Frente> frentes = await _frenteRepository.getAllFrenteListByEntradaFinanceira(event.entradaFinanceiraId);
    yield this.state.copyWith(frentes: frentes, frenteStatusUI: FrenteStatusUI.done);
  }

  Stream<FrenteState> onInitFrenteListBySaidaFinanceira(InitFrenteListBySaidaFinanceira event) async* {
    yield this.state.copyWith(frenteStatusUI: FrenteStatusUI.loading);
    List<Frente> frentes = await _frenteRepository.getAllFrenteListBySaidaFinanceira(event.saidaFinanceiraId);
    yield this.state.copyWith(frentes: frentes, frenteStatusUI: FrenteStatusUI.done);
  }

  Stream<FrenteState> onSubmit() async* {
    if (this.state.isValid) {
      yield this.state.copyWith(formStatus: FormzSubmissionStatus.inProgress);
      try {
        Frente? result;
        if(this.state.editMode) {
          Frente newFrente = Frente(state.loadedFrente.id,
            this.state.quantidade.value,
            this.state.criadoEm.value,
            this.state.modificadoEm.value,
            null,
            null,
            null,
          );

          result = await _frenteRepository.update(newFrente);
        } else {
          Frente newFrente = Frente(null,
            this.state.quantidade.value,
            this.state.criadoEm.value,
            this.state.modificadoEm.value,
            null,
            null,
            null,
          );

          result = await _frenteRepository.create(newFrente);
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

  Stream<FrenteState> onLoadFrenteIdForEdit(LoadFrenteByIdForEdit? event) async* {
    yield this.state.copyWith(frenteStatusUI: FrenteStatusUI.loading);
    Frente loadedFrente = await _frenteRepository.getFrente(event?.id);

    final quantidade = QuantidadeInput.dirty((loadedFrente.quantidade != null ? loadedFrente.quantidade: 0)!);
    final criadoEm = CriadoEmInput.dirty((loadedFrente.criadoEm != null ? loadedFrente.criadoEm: null)!);
    final modificadoEm = ModificadoEmInput.dirty((loadedFrente.modificadoEm != null ? loadedFrente.modificadoEm: null)!);

    yield this.state.copyWith(loadedFrente: loadedFrente, editMode: true,
      quantidade: quantidade,
      criadoEm: criadoEm,
      modificadoEm: modificadoEm,
    frenteStatusUI: FrenteStatusUI.done);

    quantidadeController.text = loadedFrente.quantidade!.toString();
    criadoEmController.text = DateFormat.yMMMMd('en').format(loadedFrente.criadoEm!.toDateTimeLocal());
    modificadoEmController.text = DateFormat.yMMMMd('en').format(loadedFrente.modificadoEm!.toDateTimeLocal());
  }

  Stream<FrenteState> onDeleteFrenteId(DeleteFrenteById event) async* {
    try {
      await _frenteRepository.delete(event.id!);
      this.add(InitFrenteList());
      yield this.state.copyWith(deleteStatus: FrenteDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: FrenteDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: FrenteDeleteStatus.none);
  }

  Stream<FrenteState> onLoadFrenteIdForView(LoadFrenteByIdForView event) async* {
    yield this.state.copyWith(frenteStatusUI: FrenteStatusUI.loading);
    try {
      Frente loadedFrente = await _frenteRepository.getFrente(event.id);
      yield this.state.copyWith(loadedFrente: loadedFrente, frenteStatusUI: FrenteStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedFrente: null, frenteStatusUI: FrenteStatusUI.error);
    }
  }


  Stream<FrenteState> onQuantidadeChange(QuantidadeChanged event) async* {
    final quantidade = QuantidadeInput.dirty(event.quantidade);
    yield this.state.copyWith(
      quantidade: quantidade,
    );
  }
  Stream<FrenteState> onCriadoEmChange(CriadoEmChanged event) async* {
    final criadoEm = CriadoEmInput.dirty(event.criadoEm);
    yield this.state.copyWith(
      criadoEm: criadoEm,
    );
  }
  Stream<FrenteState> onModificadoEmChange(ModificadoEmChanged event) async* {
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
