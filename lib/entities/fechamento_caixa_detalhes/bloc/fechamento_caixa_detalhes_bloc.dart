import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:Cocoverde/entities/fechamento_caixa_detalhes/fechamento_caixa_detalhes_model.dart';
import 'package:Cocoverde/entities/fechamento_caixa_detalhes/fechamento_caixa_detalhes_repository.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';

part 'fechamento_caixa_detalhes_events.dart';
part 'fechamento_caixa_detalhes_state.dart';

class FechamentoCaixaDetalhesBloc extends Bloc<FechamentoCaixaDetalhesEvent, FechamentoCaixaDetalhesState> {
  final FechamentoCaixaDetalhesRepository _fechamentoCaixaDetalhesRepository;


  FechamentoCaixaDetalhesBloc({required FechamentoCaixaDetalhesRepository fechamentoCaixaDetalhesRepository}) :
        _fechamentoCaixaDetalhesRepository = fechamentoCaixaDetalhesRepository,
  super(FechamentoCaixaDetalhesState());

  @override
  void onTransition(Transition<FechamentoCaixaDetalhesEvent, FechamentoCaixaDetalhesState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<FechamentoCaixaDetalhesState> mapEventToState(FechamentoCaixaDetalhesEvent event) async* {
    if (event is InitFechamentoCaixaDetalhesList) {
      yield* onInitList(event);

        } else if (event is InitFechamentoCaixaDetalhesListByFechamentoCaixa) {
        yield* onInitFechamentoCaixaDetalhesListByFechamentoCaixa(event);

        } else if (event is InitFechamentoCaixaDetalhesListByEntradaFinanceira) {
        yield* onInitFechamentoCaixaDetalhesListByEntradaFinanceira(event);

        } else if (event is InitFechamentoCaixaDetalhesListBySaidaFinanceira) {
        yield* onInitFechamentoCaixaDetalhesListBySaidaFinanceira(event);
    } else if (event is FechamentoCaixaDetalhesFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadFechamentoCaixaDetalhesByIdForEdit) {
      yield* onLoadFechamentoCaixaDetalhesIdForEdit(event);
    } else if (event is DeleteFechamentoCaixaDetalhesById) {
      yield* onDeleteFechamentoCaixaDetalhesId(event);
    } else if (event is LoadFechamentoCaixaDetalhesByIdForView) {
      yield* onLoadFechamentoCaixaDetalhesIdForView(event);
    }  }

  Stream<FechamentoCaixaDetalhesState> onInitList(InitFechamentoCaixaDetalhesList event) async* {
    yield this.state.copyWith(fechamentoCaixaDetalhesStatusUI: FechamentoCaixaDetalhesStatusUI.loading);
    List<FechamentoCaixaDetalhes> fechamentoCaixaDetalhes = await _fechamentoCaixaDetalhesRepository.getAllFechamentoCaixaDetalhes();
    yield this.state.copyWith(fechamentoCaixaDetalhes: fechamentoCaixaDetalhes, fechamentoCaixaDetalhesStatusUI: FechamentoCaixaDetalhesStatusUI.done);
  }


  Stream<FechamentoCaixaDetalhesState> onInitFechamentoCaixaDetalhesListByFechamentoCaixa(InitFechamentoCaixaDetalhesListByFechamentoCaixa event) async* {
    yield this.state.copyWith(fechamentoCaixaDetalhesStatusUI: FechamentoCaixaDetalhesStatusUI.loading);
    List<FechamentoCaixaDetalhes> fechamentoCaixaDetalhes = await _fechamentoCaixaDetalhesRepository.getAllFechamentoCaixaDetalhesListByFechamentoCaixa(event.fechamentoCaixaId);
    yield this.state.copyWith(fechamentoCaixaDetalhes: fechamentoCaixaDetalhes, fechamentoCaixaDetalhesStatusUI: FechamentoCaixaDetalhesStatusUI.done);
  }

  Stream<FechamentoCaixaDetalhesState> onInitFechamentoCaixaDetalhesListByEntradaFinanceira(InitFechamentoCaixaDetalhesListByEntradaFinanceira event) async* {
    yield this.state.copyWith(fechamentoCaixaDetalhesStatusUI: FechamentoCaixaDetalhesStatusUI.loading);
    List<FechamentoCaixaDetalhes> fechamentoCaixaDetalhes = await _fechamentoCaixaDetalhesRepository.getAllFechamentoCaixaDetalhesListByEntradaFinanceira(event.entradaFinanceiraId);
    yield this.state.copyWith(fechamentoCaixaDetalhes: fechamentoCaixaDetalhes, fechamentoCaixaDetalhesStatusUI: FechamentoCaixaDetalhesStatusUI.done);
  }

  Stream<FechamentoCaixaDetalhesState> onInitFechamentoCaixaDetalhesListBySaidaFinanceira(InitFechamentoCaixaDetalhesListBySaidaFinanceira event) async* {
    yield this.state.copyWith(fechamentoCaixaDetalhesStatusUI: FechamentoCaixaDetalhesStatusUI.loading);
    List<FechamentoCaixaDetalhes> fechamentoCaixaDetalhes = await _fechamentoCaixaDetalhesRepository.getAllFechamentoCaixaDetalhesListBySaidaFinanceira(event.saidaFinanceiraId);
    yield this.state.copyWith(fechamentoCaixaDetalhes: fechamentoCaixaDetalhes, fechamentoCaixaDetalhesStatusUI: FechamentoCaixaDetalhesStatusUI.done);
  }

  Stream<FechamentoCaixaDetalhesState> onSubmit() async* {
    if (this.state.isValid) {
      yield this.state.copyWith(formStatus: FormzSubmissionStatus.inProgress);
      try {
        FechamentoCaixaDetalhes? result;
        if(this.state.editMode) {
          FechamentoCaixaDetalhes newFechamentoCaixaDetalhes = FechamentoCaixaDetalhes(state.loadedFechamentoCaixaDetalhes.id,
            null,
            null,
            null,
          );

          result = await _fechamentoCaixaDetalhesRepository.update(newFechamentoCaixaDetalhes);
        } else {
          FechamentoCaixaDetalhes newFechamentoCaixaDetalhes = FechamentoCaixaDetalhes(null,
            null,
            null,
            null,
          );

          result = await _fechamentoCaixaDetalhesRepository.create(newFechamentoCaixaDetalhes);
        }

        yield this.state.copyWith(formStatus: FormzSubmissionStatus.success,
            generalNotificationKey: HttpUtils.successResult);
            } catch (e) {
        yield this.state.copyWith(formStatus: FormzSubmissionStatus.failure,
            generalNotificationKey: HttpUtils.errorServerKey);
      }
    }
  }

  Stream<FechamentoCaixaDetalhesState> onLoadFechamentoCaixaDetalhesIdForEdit(LoadFechamentoCaixaDetalhesByIdForEdit? event) async* {
    yield this.state.copyWith(fechamentoCaixaDetalhesStatusUI: FechamentoCaixaDetalhesStatusUI.loading);
    FechamentoCaixaDetalhes loadedFechamentoCaixaDetalhes = await _fechamentoCaixaDetalhesRepository.getFechamentoCaixaDetalhes(event?.id);


    yield this.state.copyWith(loadedFechamentoCaixaDetalhes: loadedFechamentoCaixaDetalhes, editMode: true,
    fechamentoCaixaDetalhesStatusUI: FechamentoCaixaDetalhesStatusUI.done);

  }

  Stream<FechamentoCaixaDetalhesState> onDeleteFechamentoCaixaDetalhesId(DeleteFechamentoCaixaDetalhesById event) async* {
    try {
      await _fechamentoCaixaDetalhesRepository.delete(event.id!);
      this.add(InitFechamentoCaixaDetalhesList());
      yield this.state.copyWith(deleteStatus: FechamentoCaixaDetalhesDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: FechamentoCaixaDetalhesDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: FechamentoCaixaDetalhesDeleteStatus.none);
  }

  Stream<FechamentoCaixaDetalhesState> onLoadFechamentoCaixaDetalhesIdForView(LoadFechamentoCaixaDetalhesByIdForView event) async* {
    yield this.state.copyWith(fechamentoCaixaDetalhesStatusUI: FechamentoCaixaDetalhesStatusUI.loading);
    try {
      FechamentoCaixaDetalhes loadedFechamentoCaixaDetalhes = await _fechamentoCaixaDetalhesRepository.getFechamentoCaixaDetalhes(event.id);
      yield this.state.copyWith(loadedFechamentoCaixaDetalhes: loadedFechamentoCaixaDetalhes, fechamentoCaixaDetalhesStatusUI: FechamentoCaixaDetalhesStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedFechamentoCaixaDetalhes: null, fechamentoCaixaDetalhesStatusUI: FechamentoCaixaDetalhesStatusUI.error);
    }
  }



  @override
  Future<void> close() {
    return super.close();
  }

}
