import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:time_machine/time_machine.dart';

import 'package:cocoverde/entities/funcionario/funcionario_model.dart';
import 'package:cocoverde/entities/funcionario/funcionario_repository.dart';
import 'package:cocoverde/entities/funcionario/bloc/funcionario_form_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'funcionario_events.dart';
part 'funcionario_state.dart';

class FuncionarioBloc extends Bloc<FuncionarioEvent, FuncionarioState> {
  final FuncionarioRepository _funcionarioRepository;

  final nomeController = TextEditingController();
  final dataNascimentoController = TextEditingController();
  final identificadorController = TextEditingController();
  final telefoneController = TextEditingController();
  final dataCadastroController = TextEditingController();
  final valorBaseController = TextEditingController();

  FuncionarioBloc({required FuncionarioRepository funcionarioRepository}) :
        _funcionarioRepository = funcionarioRepository,
  super(FuncionarioState());

  @override
  void onTransition(Transition<FuncionarioEvent, FuncionarioState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<FuncionarioState> mapEventToState(FuncionarioEvent event) async* {
    if (event is InitFuncionarioList) {
      yield* onInitList(event);

        } else if (event is InitFuncionarioListByEndereco) {
        yield* onInitFuncionarioListByEndereco(event);
    } else if (event is FuncionarioFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadFuncionarioByIdForEdit) {
      yield* onLoadFuncionarioIdForEdit(event);
    } else if (event is DeleteFuncionarioById) {
      yield* onDeleteFuncionarioId(event);
    } else if (event is LoadFuncionarioByIdForView) {
      yield* onLoadFuncionarioIdForView(event);
    }else if (event is NomeChanged){
      yield* onNomeChange(event);
    }else if (event is DataNascimentoChanged){
      yield* onDataNascimentoChange(event);
    }else if (event is IdentificadorChanged){
      yield* onIdentificadorChange(event);
    }else if (event is TelefoneChanged){
      yield* onTelefoneChange(event);
    }else if (event is DataCadastroChanged){
      yield* onDataCadastroChange(event);
    }else if (event is ValorBaseChanged){
      yield* onValorBaseChange(event);
    }  }

  Stream<FuncionarioState> onInitList(InitFuncionarioList event) async* {
    yield this.state.copyWith(funcionarioStatusUI: FuncionarioStatusUI.loading);
    List<Funcionario> funcionarios = await _funcionarioRepository.getAllFuncionarios();
    yield this.state.copyWith(funcionarios: funcionarios, funcionarioStatusUI: FuncionarioStatusUI.done);
  }


  Stream<FuncionarioState> onInitFuncionarioListByEndereco(InitFuncionarioListByEndereco event) async* {
    yield this.state.copyWith(funcionarioStatusUI: FuncionarioStatusUI.loading);
    List<Funcionario> funcionarios = await _funcionarioRepository.getAllFuncionarioListByEndereco(event.enderecoId);
    yield this.state.copyWith(funcionarios: funcionarios, funcionarioStatusUI: FuncionarioStatusUI.done);
  }

  Stream<FuncionarioState> onSubmit() async* {
    if (this.state.isValid) {
      yield this.state.copyWith(formStatus: FormzSubmissionStatus.inProgress);
      try {
        Funcionario? result;
        if(this.state.editMode) {
          Funcionario newFuncionario = Funcionario(state.loadedFuncionario.id,
            this.state.nome.value,
            this.state.dataNascimento.value,
            this.state.identificador.value,
            this.state.telefone.value,
            this.state.dataCadastro.value,
            this.state.valorBase.value,
            null,
          );

          result = await _funcionarioRepository.update(newFuncionario);
        } else {
          Funcionario newFuncionario = Funcionario(null,
            this.state.nome.value,
            this.state.dataNascimento.value,
            this.state.identificador.value,
            this.state.telefone.value,
            this.state.dataCadastro.value,
            this.state.valorBase.value,
            null,
          );

          result = await _funcionarioRepository.create(newFuncionario);
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

  Stream<FuncionarioState> onLoadFuncionarioIdForEdit(LoadFuncionarioByIdForEdit? event) async* {
    yield this.state.copyWith(funcionarioStatusUI: FuncionarioStatusUI.loading);
    Funcionario loadedFuncionario = await _funcionarioRepository.getFuncionario(event?.id);

    final nome = NomeInput.dirty((loadedFuncionario.nome != null ? loadedFuncionario.nome: '')!);
    final dataNascimento = DataNascimentoInput.dirty((loadedFuncionario.dataNascimento != null ? loadedFuncionario.dataNascimento: '')!);
    final identificador = IdentificadorInput.dirty((loadedFuncionario.identificador != null ? loadedFuncionario.identificador: '')!);
    final telefone = TelefoneInput.dirty((loadedFuncionario.telefone != null ? loadedFuncionario.telefone: '')!);
    final dataCadastro = DataCadastroInput.dirty((loadedFuncionario.dataCadastro != null ? loadedFuncionario.dataCadastro: null)!);
    final valorBase = ValorBaseInput.dirty((loadedFuncionario.valorBase != null ? loadedFuncionario.valorBase: '')!);

    yield this.state.copyWith(loadedFuncionario: loadedFuncionario, editMode: true,
      nome: nome,
      dataNascimento: dataNascimento,
      identificador: identificador,
      telefone: telefone,
      dataCadastro: dataCadastro,
      valorBase: valorBase,
    funcionarioStatusUI: FuncionarioStatusUI.done);

    nomeController.text = loadedFuncionario.nome!;
    dataNascimentoController.text = loadedFuncionario.dataNascimento!;
    identificadorController.text = loadedFuncionario.identificador!;
    telefoneController.text = loadedFuncionario.telefone!;
    dataCadastroController.text = DateFormat.yMMMMd('en').format(loadedFuncionario.dataCadastro!.toDateTimeLocal());
    valorBaseController.text = loadedFuncionario.valorBase!;
  }

  Stream<FuncionarioState> onDeleteFuncionarioId(DeleteFuncionarioById event) async* {
    try {
      await _funcionarioRepository.delete(event.id!);
      this.add(InitFuncionarioList());
      yield this.state.copyWith(deleteStatus: FuncionarioDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: FuncionarioDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: FuncionarioDeleteStatus.none);
  }

  Stream<FuncionarioState> onLoadFuncionarioIdForView(LoadFuncionarioByIdForView event) async* {
    yield this.state.copyWith(funcionarioStatusUI: FuncionarioStatusUI.loading);
    try {
      Funcionario loadedFuncionario = await _funcionarioRepository.getFuncionario(event.id);
      yield this.state.copyWith(loadedFuncionario: loadedFuncionario, funcionarioStatusUI: FuncionarioStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedFuncionario: null, funcionarioStatusUI: FuncionarioStatusUI.error);
    }
  }


  Stream<FuncionarioState> onNomeChange(NomeChanged event) async* {
    final nome = NomeInput.dirty(event.nome);
    yield this.state.copyWith(
      nome: nome,
    );
  }
  Stream<FuncionarioState> onDataNascimentoChange(DataNascimentoChanged event) async* {
    final dataNascimento = DataNascimentoInput.dirty(event.dataNascimento);
    yield this.state.copyWith(
      dataNascimento: dataNascimento,
    );
  }
  Stream<FuncionarioState> onIdentificadorChange(IdentificadorChanged event) async* {
    final identificador = IdentificadorInput.dirty(event.identificador);
    yield this.state.copyWith(
      identificador: identificador,
    );
  }
  Stream<FuncionarioState> onTelefoneChange(TelefoneChanged event) async* {
    final telefone = TelefoneInput.dirty(event.telefone);
    yield this.state.copyWith(
      telefone: telefone,
    );
  }
  Stream<FuncionarioState> onDataCadastroChange(DataCadastroChanged event) async* {
    final dataCadastro = DataCadastroInput.dirty(event.dataCadastro);
    yield this.state.copyWith(
      dataCadastro: dataCadastro,
    );
  }
  Stream<FuncionarioState> onValorBaseChange(ValorBaseChanged event) async* {
    final valorBase = ValorBaseInput.dirty(event.valorBase);
    yield this.state.copyWith(
      valorBase: valorBase,
    );
  }

  @override
  Future<void> close() {
    nomeController.dispose();
    dataNascimentoController.dispose();
    identificadorController.dispose();
    telefoneController.dispose();
    dataCadastroController.dispose();
    valorBaseController.dispose();
    return super.close();
  }

}
