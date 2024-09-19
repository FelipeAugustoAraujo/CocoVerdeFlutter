import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:time_machine/time_machine.dart';

import 'package:cocoverde/entities/dia_trabalho/dia_trabalho_model.dart';
import 'package:cocoverde/entities/dia_trabalho/dia_trabalho_repository.dart';
import 'package:cocoverde/entities/dia_trabalho/bloc/dia_trabalho_form_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'dia_trabalho_events.dart';
part 'dia_trabalho_state.dart';

class DiaTrabalhoBloc extends Bloc<DiaTrabalhoEvent, DiaTrabalhoState> {
  final DiaTrabalhoRepository _diaTrabalhoRepository;

  final dataController = TextEditingController();

  DiaTrabalhoBloc({required DiaTrabalhoRepository diaTrabalhoRepository}) :
        _diaTrabalhoRepository = diaTrabalhoRepository,
  super(DiaTrabalhoState());

  @override
  void onTransition(Transition<DiaTrabalhoEvent, DiaTrabalhoState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<DiaTrabalhoState> mapEventToState(DiaTrabalhoEvent event) async* {
    if (event is InitDiaTrabalhoList) {
      yield* onInitList(event);
    } else if (event is DiaTrabalhoFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadDiaTrabalhoByIdForEdit) {
      yield* onLoadDiaTrabalhoIdForEdit(event);
    } else if (event is DeleteDiaTrabalhoById) {
      yield* onDeleteDiaTrabalhoId(event);
    } else if (event is LoadDiaTrabalhoByIdForView) {
      yield* onLoadDiaTrabalhoIdForView(event);
    }else if (event is DataChanged){
      yield* onDataChange(event);
    }  }

  Stream<DiaTrabalhoState> onInitList(InitDiaTrabalhoList event) async* {
    yield this.state.copyWith(diaTrabalhoStatusUI: DiaTrabalhoStatusUI.loading);
    List<DiaTrabalho> diaTrabalhos = await _diaTrabalhoRepository.getAllDiaTrabalhos();
    yield this.state.copyWith(diaTrabalhos: diaTrabalhos, diaTrabalhoStatusUI: DiaTrabalhoStatusUI.done);
  }


  Stream<DiaTrabalhoState> onSubmit() async* {
    if (this.state.isValid) {
      yield this.state.copyWith(formStatus: FormzSubmissionStatus.inProgress);
      try {
        DiaTrabalho? result;
        if(this.state.editMode) {
          DiaTrabalho newDiaTrabalho = DiaTrabalho(state.loadedDiaTrabalho.id,
            this.state.data.value,
          );

          result = await _diaTrabalhoRepository.update(newDiaTrabalho);
        } else {
          DiaTrabalho newDiaTrabalho = DiaTrabalho(null,
            this.state.data.value,
          );

          result = await _diaTrabalhoRepository.create(newDiaTrabalho);
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

  Stream<DiaTrabalhoState> onLoadDiaTrabalhoIdForEdit(LoadDiaTrabalhoByIdForEdit? event) async* {
    yield this.state.copyWith(diaTrabalhoStatusUI: DiaTrabalhoStatusUI.loading);
    DiaTrabalho loadedDiaTrabalho = await _diaTrabalhoRepository.getDiaTrabalho(event?.id);

    final data = DataInput.dirty((loadedDiaTrabalho.data != null ? loadedDiaTrabalho.data: null)!);

    yield this.state.copyWith(loadedDiaTrabalho: loadedDiaTrabalho, editMode: true,
      data: data,
    diaTrabalhoStatusUI: DiaTrabalhoStatusUI.done);

    dataController.text = DateFormat.yMMMMd('en').format(loadedDiaTrabalho.data!.toDateTimeLocal());
  }

  Stream<DiaTrabalhoState> onDeleteDiaTrabalhoId(DeleteDiaTrabalhoById event) async* {
    try {
      await _diaTrabalhoRepository.delete(event.id!);
      this.add(InitDiaTrabalhoList());
      yield this.state.copyWith(deleteStatus: DiaTrabalhoDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: DiaTrabalhoDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: DiaTrabalhoDeleteStatus.none);
  }

  Stream<DiaTrabalhoState> onLoadDiaTrabalhoIdForView(LoadDiaTrabalhoByIdForView event) async* {
    yield this.state.copyWith(diaTrabalhoStatusUI: DiaTrabalhoStatusUI.loading);
    try {
      DiaTrabalho loadedDiaTrabalho = await _diaTrabalhoRepository.getDiaTrabalho(event.id);
      yield this.state.copyWith(loadedDiaTrabalho: loadedDiaTrabalho, diaTrabalhoStatusUI: DiaTrabalhoStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedDiaTrabalho: null, diaTrabalhoStatusUI: DiaTrabalhoStatusUI.error);
    }
  }


  Stream<DiaTrabalhoState> onDataChange(DataChanged event) async* {
    final data = DataInput.dirty(event.data);
    yield this.state.copyWith(
      data: data,
    );
  }

  @override
  Future<void> close() {
    dataController.dispose();
    return super.close();
  }

}
