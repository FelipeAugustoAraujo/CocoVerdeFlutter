import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:time_machine/time_machine.dart';

import 'package:cocoverde/entities/cliente/cliente_model.dart';
import 'package:cocoverde/entities/cliente/cliente_repository.dart';
import 'package:cocoverde/entities/cliente/bloc/cliente_form_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'cliente_events.dart';
part 'cliente_state.dart';

class ClienteBloc extends Bloc<ClienteEvent, ClienteState> {
  final ClienteRepository _clienteRepository;

  final nomeController = TextEditingController();
  final dataNascimentoController = TextEditingController();
  final identificadorController = TextEditingController();
  final dataCadastroController = TextEditingController();
  final telefoneController = TextEditingController();

  ClienteBloc({required ClienteRepository clienteRepository}) :
        _clienteRepository = clienteRepository,
  super(ClienteState());

  @override
  void onTransition(Transition<ClienteEvent, ClienteState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<ClienteState> mapEventToState(ClienteEvent event) async* {
    if (event is InitClienteList) {
      yield* onInitList(event);

        } else if (event is InitClienteListByEndereco) {
        yield* onInitClienteListByEndereco(event);
    } else if (event is ClienteFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadClienteByIdForEdit) {
      yield* onLoadClienteIdForEdit(event);
    } else if (event is DeleteClienteById) {
      yield* onDeleteClienteId(event);
    } else if (event is LoadClienteByIdForView) {
      yield* onLoadClienteIdForView(event);
    }else if (event is NomeChanged){
      yield* onNomeChange(event);
    }else if (event is DataNascimentoChanged){
      yield* onDataNascimentoChange(event);
    }else if (event is IdentificadorChanged){
      yield* onIdentificadorChange(event);
    }else if (event is DataCadastroChanged){
      yield* onDataCadastroChange(event);
    }else if (event is TelefoneChanged){
      yield* onTelefoneChange(event);
    }  }

  Stream<ClienteState> onInitList(InitClienteList event) async* {
    yield this.state.copyWith(clienteStatusUI: ClienteStatusUI.loading);
    List<Cliente> clientes = await _clienteRepository.getAllClientes();
    yield this.state.copyWith(clientes: clientes, clienteStatusUI: ClienteStatusUI.done);
  }


  Stream<ClienteState> onInitClienteListByEndereco(InitClienteListByEndereco event) async* {
    yield this.state.copyWith(clienteStatusUI: ClienteStatusUI.loading);
    List<Cliente> clientes = await _clienteRepository.getAllClienteListByEndereco(event.enderecoId);
    yield this.state.copyWith(clientes: clientes, clienteStatusUI: ClienteStatusUI.done);
  }

  Stream<ClienteState> onSubmit() async* {
    if (this.state.isValid) {
      yield this.state.copyWith(formStatus: FormzSubmissionStatus.inProgress);
      try {
        Cliente? result;
        if(this.state.editMode) {
          Cliente newCliente = Cliente(state.loadedCliente.id,
            this.state.nome.value,
            this.state.dataNascimento.value,
            this.state.identificador.value,
            this.state.dataCadastro.value,
            this.state.telefone.value,
            null,
          );

          result = await _clienteRepository.update(newCliente);
        } else {
          Cliente newCliente = Cliente(null,
            this.state.nome.value,
            this.state.dataNascimento.value,
            this.state.identificador.value,
            this.state.dataCadastro.value,
            this.state.telefone.value,
            null,
          );

          result = await _clienteRepository.create(newCliente);
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

  Stream<ClienteState> onLoadClienteIdForEdit(LoadClienteByIdForEdit? event) async* {
    yield this.state.copyWith(clienteStatusUI: ClienteStatusUI.loading);
    Cliente loadedCliente = await _clienteRepository.getCliente(event?.id);

    final nome = NomeInput.dirty((loadedCliente.nome != null ? loadedCliente.nome: '')!);
    final dataNascimento = DataNascimentoInput.dirty((loadedCliente.dataNascimento != null ? loadedCliente.dataNascimento: '')!);
    final identificador = IdentificadorInput.dirty((loadedCliente.identificador != null ? loadedCliente.identificador: '')!);
    final dataCadastro = DataCadastroInput.dirty((loadedCliente.dataCadastro != null ? loadedCliente.dataCadastro: null)!);
    final telefone = TelefoneInput.dirty((loadedCliente.telefone != null ? loadedCliente.telefone: '')!);

    yield this.state.copyWith(loadedCliente: loadedCliente, editMode: true,
      nome: nome,
      dataNascimento: dataNascimento,
      identificador: identificador,
      dataCadastro: dataCadastro,
      telefone: telefone,
    clienteStatusUI: ClienteStatusUI.done);

    nomeController.text = loadedCliente.nome!;
    dataNascimentoController.text = loadedCliente.dataNascimento!;
    identificadorController.text = loadedCliente.identificador!;
    dataCadastroController.text = DateFormat.yMMMMd('en').format(loadedCliente.dataCadastro!.toDateTimeLocal());
    telefoneController.text = loadedCliente.telefone!;
  }

  Stream<ClienteState> onDeleteClienteId(DeleteClienteById event) async* {
    try {
      await _clienteRepository.delete(event.id!);
      this.add(InitClienteList());
      yield this.state.copyWith(deleteStatus: ClienteDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: ClienteDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: ClienteDeleteStatus.none);
  }

  Stream<ClienteState> onLoadClienteIdForView(LoadClienteByIdForView event) async* {
    yield this.state.copyWith(clienteStatusUI: ClienteStatusUI.loading);
    try {
      Cliente loadedCliente = await _clienteRepository.getCliente(event.id);
      yield this.state.copyWith(loadedCliente: loadedCliente, clienteStatusUI: ClienteStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedCliente: null, clienteStatusUI: ClienteStatusUI.error);
    }
  }


  Stream<ClienteState> onNomeChange(NomeChanged event) async* {
    final nome = NomeInput.dirty(event.nome);
    yield this.state.copyWith(
      nome: nome,
    );
  }
  Stream<ClienteState> onDataNascimentoChange(DataNascimentoChanged event) async* {
    final dataNascimento = DataNascimentoInput.dirty(event.dataNascimento);
    yield this.state.copyWith(
      dataNascimento: dataNascimento,
    );
  }
  Stream<ClienteState> onIdentificadorChange(IdentificadorChanged event) async* {
    final identificador = IdentificadorInput.dirty(event.identificador);
    yield this.state.copyWith(
      identificador: identificador,
    );
  }
  Stream<ClienteState> onDataCadastroChange(DataCadastroChanged event) async* {
    final dataCadastro = DataCadastroInput.dirty(event.dataCadastro);
    yield this.state.copyWith(
      dataCadastro: dataCadastro,
    );
  }
  Stream<ClienteState> onTelefoneChange(TelefoneChanged event) async* {
    final telefone = TelefoneInput.dirty(event.telefone);
    yield this.state.copyWith(
      telefone: telefone,
    );
  }

  @override
  Future<void> close() {
    nomeController.dispose();
    dataNascimentoController.dispose();
    identificadorController.dispose();
    dataCadastroController.dispose();
    telefoneController.dispose();
    return super.close();
  }

}
