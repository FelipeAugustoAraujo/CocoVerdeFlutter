import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:time_machine/time_machine.dart';

import 'package:cocoverde/entities/configuracao/configuracao_model.dart';
import 'package:cocoverde/entities/configuracao/configuracao_repository.dart';
import 'package:cocoverde/entities/configuracao/bloc/configuracao_form_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'configuracao_events.dart';
part 'configuracao_state.dart';

class ConfiguracaoBloc extends Bloc<ConfiguracaoEvent, ConfiguracaoState> {
  final ConfiguracaoRepository _configuracaoRepository;


  ConfiguracaoBloc({required ConfiguracaoRepository configuracaoRepository}) :
        _configuracaoRepository = configuracaoRepository,
  super(ConfiguracaoState());

  @override
  void onTransition(Transition<ConfiguracaoEvent, ConfiguracaoState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<ConfiguracaoState> mapEventToState(ConfiguracaoEvent event) async* {
    if (event is InitConfiguracaoList) {
      yield* onInitList(event);
    } else if (event is ConfiguracaoFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadConfiguracaoByIdForEdit) {
      yield* onLoadConfiguracaoIdForEdit(event);
    } else if (event is DeleteConfiguracaoById) {
      yield* onDeleteConfiguracaoId(event);
    } else if (event is LoadConfiguracaoByIdForView) {
      yield* onLoadConfiguracaoIdForView(event);
    }  }

  Stream<ConfiguracaoState> onInitList(InitConfiguracaoList event) async* {
    yield this.state.copyWith(configuracaoStatusUI: ConfiguracaoStatusUI.loading);
    List<Configuracao> configuracaos = await _configuracaoRepository.getAllConfiguracaos();
    yield this.state.copyWith(configuracaos: configuracaos, configuracaoStatusUI: ConfiguracaoStatusUI.done);
  }


  Stream<ConfiguracaoState> onSubmit() async* {
    if (this.state.isValid) {
      yield this.state.copyWith(formStatus: FormzSubmissionStatus.inProgress);
      try {
        Configuracao? result;
        if(this.state.editMode) {
          Configuracao newConfiguracao = Configuracao(state.loadedConfiguracao.id,
          );

          result = await _configuracaoRepository.update(newConfiguracao);
        } else {
          Configuracao newConfiguracao = Configuracao(null,
          );

          result = await _configuracaoRepository.create(newConfiguracao);
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

  Stream<ConfiguracaoState> onLoadConfiguracaoIdForEdit(LoadConfiguracaoByIdForEdit? event) async* {
    yield this.state.copyWith(configuracaoStatusUI: ConfiguracaoStatusUI.loading);
    Configuracao loadedConfiguracao = await _configuracaoRepository.getConfiguracao(event?.id);


    yield this.state.copyWith(loadedConfiguracao: loadedConfiguracao, editMode: true,
    configuracaoStatusUI: ConfiguracaoStatusUI.done);

  }

  Stream<ConfiguracaoState> onDeleteConfiguracaoId(DeleteConfiguracaoById event) async* {
    try {
      await _configuracaoRepository.delete(event.id!);
      this.add(InitConfiguracaoList());
      yield this.state.copyWith(deleteStatus: ConfiguracaoDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: ConfiguracaoDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: ConfiguracaoDeleteStatus.none);
  }

  Stream<ConfiguracaoState> onLoadConfiguracaoIdForView(LoadConfiguracaoByIdForView event) async* {
    yield this.state.copyWith(configuracaoStatusUI: ConfiguracaoStatusUI.loading);
    try {
      Configuracao loadedConfiguracao = await _configuracaoRepository.getConfiguracao(event.id);
      yield this.state.copyWith(loadedConfiguracao: loadedConfiguracao, configuracaoStatusUI: ConfiguracaoStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedConfiguracao: null, configuracaoStatusUI: ConfiguracaoStatusUI.error);
    }
  }



  @override
  Future<void> close() {
    return super.close();
  }

}
