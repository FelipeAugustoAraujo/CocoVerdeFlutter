import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:time_machine/time_machine.dart';

import 'package:cocoverde/entities/entrada_financeira/entrada_financeira_model.dart';
import 'package:cocoverde/entities/entrada_financeira/entrada_financeira_repository.dart';
import 'package:cocoverde/entities/entrada_financeira/bloc/entrada_financeira_form_model.dart';
import 'package:cocoverde/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'entrada_financeira_events.dart';
part 'entrada_financeira_state.dart';

class EntradaFinanceiraBloc extends Bloc<EntradaFinanceiraEvent, EntradaFinanceiraState> {
  final EntradaFinanceiraRepository _entradaFinanceiraRepository;

  final dataController = TextEditingController();
  final valorTotalController = TextEditingController();
  final descricaoController = TextEditingController();

  EntradaFinanceiraBloc({required EntradaFinanceiraRepository entradaFinanceiraRepository}) :
        _entradaFinanceiraRepository = entradaFinanceiraRepository,
  super(EntradaFinanceiraState());

  @override
  void onTransition(Transition<EntradaFinanceiraEvent, EntradaFinanceiraState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<EntradaFinanceiraState> mapEventToState(EntradaFinanceiraEvent event) async* {
    if (event is InitEntradaFinanceiraList) {
      yield* onInitList(event);

        } else if (event is InitEntradaFinanceiraListByFornecedor) {
        yield* onInitEntradaFinanceiraListByFornecedor(event);

        } else if (event is InitEntradaFinanceiraListByEstoque) {
        yield* onInitEntradaFinanceiraListByEstoque(event);

        } else if (event is InitEntradaFinanceiraListByFrente) {
        yield* onInitEntradaFinanceiraListByFrente(event);

        } else if (event is InitEntradaFinanceiraListByFechamentoCaixaDetalhes) {
        yield* onInitEntradaFinanceiraListByFechamentoCaixaDetalhes(event);

        } else if (event is InitEntradaFinanceiraListByDetalhesEntradaFinanceira) {
        yield* onInitEntradaFinanceiraListByDetalhesEntradaFinanceira(event);

        } else if (event is InitEntradaFinanceiraListByImagem) {
        yield* onInitEntradaFinanceiraListByImagem(event);
    } else if (event is EntradaFinanceiraFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadEntradaFinanceiraByIdForEdit) {
      yield* onLoadEntradaFinanceiraIdForEdit(event);
    } else if (event is DeleteEntradaFinanceiraById) {
      yield* onDeleteEntradaFinanceiraId(event);
    } else if (event is LoadEntradaFinanceiraByIdForView) {
      yield* onLoadEntradaFinanceiraIdForView(event);
    }else if (event is DataChanged){
      yield* onDataChange(event);
    }else if (event is ValorTotalChanged){
      yield* onValorTotalChange(event);
    }else if (event is DescricaoChanged){
      yield* onDescricaoChange(event);
    }else if (event is MetodoPagamentoChanged){
      yield* onMetodoPagamentoChange(event);
    }else if (event is StatusPagamentoChanged){
      yield* onStatusPagamentoChange(event);
    }else if (event is ResponsavelPagamentoChanged){
      yield* onResponsavelPagamentoChange(event);
    }  }

  Stream<EntradaFinanceiraState> onInitList(InitEntradaFinanceiraList event) async* {
    yield this.state.copyWith(entradaFinanceiraStatusUI: EntradaFinanceiraStatusUI.loading);
    List<EntradaFinanceira> entradaFinanceiras = await _entradaFinanceiraRepository.getAllEntradaFinanceiras();
    yield this.state.copyWith(entradaFinanceiras: entradaFinanceiras, entradaFinanceiraStatusUI: EntradaFinanceiraStatusUI.done);
  }


  Stream<EntradaFinanceiraState> onInitEntradaFinanceiraListByFornecedor(InitEntradaFinanceiraListByFornecedor event) async* {
    yield this.state.copyWith(entradaFinanceiraStatusUI: EntradaFinanceiraStatusUI.loading);
    List<EntradaFinanceira> entradaFinanceiras = await _entradaFinanceiraRepository.getAllEntradaFinanceiraListByFornecedor(event.fornecedorId);
    yield this.state.copyWith(entradaFinanceiras: entradaFinanceiras, entradaFinanceiraStatusUI: EntradaFinanceiraStatusUI.done);
  }

  Stream<EntradaFinanceiraState> onInitEntradaFinanceiraListByEstoque(InitEntradaFinanceiraListByEstoque event) async* {
    yield this.state.copyWith(entradaFinanceiraStatusUI: EntradaFinanceiraStatusUI.loading);
    List<EntradaFinanceira> entradaFinanceiras = await _entradaFinanceiraRepository.getAllEntradaFinanceiraListByEstoque(event.estoqueId);
    yield this.state.copyWith(entradaFinanceiras: entradaFinanceiras, entradaFinanceiraStatusUI: EntradaFinanceiraStatusUI.done);
  }

  Stream<EntradaFinanceiraState> onInitEntradaFinanceiraListByFrente(InitEntradaFinanceiraListByFrente event) async* {
    yield this.state.copyWith(entradaFinanceiraStatusUI: EntradaFinanceiraStatusUI.loading);
    List<EntradaFinanceira> entradaFinanceiras = await _entradaFinanceiraRepository.getAllEntradaFinanceiraListByFrente(event.frenteId);
    yield this.state.copyWith(entradaFinanceiras: entradaFinanceiras, entradaFinanceiraStatusUI: EntradaFinanceiraStatusUI.done);
  }

  Stream<EntradaFinanceiraState> onInitEntradaFinanceiraListByFechamentoCaixaDetalhes(InitEntradaFinanceiraListByFechamentoCaixaDetalhes event) async* {
    yield this.state.copyWith(entradaFinanceiraStatusUI: EntradaFinanceiraStatusUI.loading);
    List<EntradaFinanceira> entradaFinanceiras = await _entradaFinanceiraRepository.getAllEntradaFinanceiraListByFechamentoCaixaDetalhes(event.fechamentoCaixaDetalhesId);
    yield this.state.copyWith(entradaFinanceiras: entradaFinanceiras, entradaFinanceiraStatusUI: EntradaFinanceiraStatusUI.done);
  }

  Stream<EntradaFinanceiraState> onInitEntradaFinanceiraListByDetalhesEntradaFinanceira(InitEntradaFinanceiraListByDetalhesEntradaFinanceira event) async* {
    yield this.state.copyWith(entradaFinanceiraStatusUI: EntradaFinanceiraStatusUI.loading);
    List<EntradaFinanceira> entradaFinanceiras = await _entradaFinanceiraRepository.getAllEntradaFinanceiraListByDetalhesEntradaFinanceira(event.detalhesEntradaFinanceiraId);
    yield this.state.copyWith(entradaFinanceiras: entradaFinanceiras, entradaFinanceiraStatusUI: EntradaFinanceiraStatusUI.done);
  }

  Stream<EntradaFinanceiraState> onInitEntradaFinanceiraListByImagem(InitEntradaFinanceiraListByImagem event) async* {
    yield this.state.copyWith(entradaFinanceiraStatusUI: EntradaFinanceiraStatusUI.loading);
    List<EntradaFinanceira> entradaFinanceiras = await _entradaFinanceiraRepository.getAllEntradaFinanceiraListByImagem(event.imagemId);
    yield this.state.copyWith(entradaFinanceiras: entradaFinanceiras, entradaFinanceiraStatusUI: EntradaFinanceiraStatusUI.done);
  }

  Stream<EntradaFinanceiraState> onSubmit() async* {
    if (this.state.isValid) {
      yield this.state.copyWith(formStatus: FormzSubmissionStatus.inProgress);
      try {
        EntradaFinanceira? result;
        if(this.state.editMode) {
          EntradaFinanceira newEntradaFinanceira = EntradaFinanceira(state.loadedEntradaFinanceira.id,
            this.state.data.value,
            this.state.valorTotal.value,
            this.state.descricao.value,
            this.state.metodoPagamento.value,
            this.state.statusPagamento.value,
            this.state.responsavelPagamento.value,
            null,
            null,
            null,
            null,
            null,
            null,
          );

          result = await _entradaFinanceiraRepository.update(newEntradaFinanceira);
        } else {
          EntradaFinanceira newEntradaFinanceira = EntradaFinanceira(null,
            this.state.data.value,
            this.state.valorTotal.value,
            this.state.descricao.value,
            this.state.metodoPagamento.value,
            this.state.statusPagamento.value,
            this.state.responsavelPagamento.value,
            null,
            null,
            null,
            null,
            null,
            null,
          );

          result = await _entradaFinanceiraRepository.create(newEntradaFinanceira);
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

  Stream<EntradaFinanceiraState> onLoadEntradaFinanceiraIdForEdit(LoadEntradaFinanceiraByIdForEdit? event) async* {
    yield this.state.copyWith(entradaFinanceiraStatusUI: EntradaFinanceiraStatusUI.loading);
    EntradaFinanceira loadedEntradaFinanceira = await _entradaFinanceiraRepository.getEntradaFinanceira(event?.id);

    final data = DataInput.dirty((loadedEntradaFinanceira.data != null ? loadedEntradaFinanceira.data: null)!);
    final valorTotal = ValorTotalInput.dirty((loadedEntradaFinanceira.valorTotal != null ? loadedEntradaFinanceira.valorTotal: '')!);
    final descricao = DescricaoInput.dirty((loadedEntradaFinanceira.descricao != null ? loadedEntradaFinanceira.descricao: '')!);
    final metodoPagamento = MetodoPagamentoInput.dirty((loadedEntradaFinanceira.metodoPagamento != null ? loadedEntradaFinanceira.metodoPagamento: null)!);
    final statusPagamento = StatusPagamentoInput.dirty((loadedEntradaFinanceira.statusPagamento != null ? loadedEntradaFinanceira.statusPagamento: null)!);
    final responsavelPagamento = ResponsavelPagamentoInput.dirty((loadedEntradaFinanceira.responsavelPagamento != null ? loadedEntradaFinanceira.responsavelPagamento: null)!);

    yield this.state.copyWith(loadedEntradaFinanceira: loadedEntradaFinanceira, editMode: true,
      data: data,
      valorTotal: valorTotal,
      descricao: descricao,
      metodoPagamento: metodoPagamento,
      statusPagamento: statusPagamento,
      responsavelPagamento: responsavelPagamento,
    entradaFinanceiraStatusUI: EntradaFinanceiraStatusUI.done);

    dataController.text = DateFormat.yMMMMd('en').format(loadedEntradaFinanceira.data!.toDateTimeLocal());
    valorTotalController.text = loadedEntradaFinanceira.valorTotal!;
    descricaoController.text = loadedEntradaFinanceira.descricao!;
  }

  Stream<EntradaFinanceiraState> onDeleteEntradaFinanceiraId(DeleteEntradaFinanceiraById event) async* {
    try {
      await _entradaFinanceiraRepository.delete(event.id!);
      this.add(InitEntradaFinanceiraList());
      yield this.state.copyWith(deleteStatus: EntradaFinanceiraDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: EntradaFinanceiraDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: EntradaFinanceiraDeleteStatus.none);
  }

  Stream<EntradaFinanceiraState> onLoadEntradaFinanceiraIdForView(LoadEntradaFinanceiraByIdForView event) async* {
    yield this.state.copyWith(entradaFinanceiraStatusUI: EntradaFinanceiraStatusUI.loading);
    try {
      EntradaFinanceira loadedEntradaFinanceira = await _entradaFinanceiraRepository.getEntradaFinanceira(event.id);
      yield this.state.copyWith(loadedEntradaFinanceira: loadedEntradaFinanceira, entradaFinanceiraStatusUI: EntradaFinanceiraStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedEntradaFinanceira: null, entradaFinanceiraStatusUI: EntradaFinanceiraStatusUI.error);
    }
  }


  Stream<EntradaFinanceiraState> onDataChange(DataChanged event) async* {
    final data = DataInput.dirty(event.data);
    yield this.state.copyWith(
      data: data,
    );
  }
  Stream<EntradaFinanceiraState> onValorTotalChange(ValorTotalChanged event) async* {
    final valorTotal = ValorTotalInput.dirty(event.valorTotal);
    yield this.state.copyWith(
      valorTotal: valorTotal,
    );
  }
  Stream<EntradaFinanceiraState> onDescricaoChange(DescricaoChanged event) async* {
    final descricao = DescricaoInput.dirty(event.descricao);
    yield this.state.copyWith(
      descricao: descricao,
    );
  }
  Stream<EntradaFinanceiraState> onMetodoPagamentoChange(MetodoPagamentoChanged event) async* {
    final metodoPagamento = MetodoPagamentoInput.dirty(event.metodoPagamento);
    yield this.state.copyWith(
      metodoPagamento: metodoPagamento,
    );
  }
  Stream<EntradaFinanceiraState> onStatusPagamentoChange(StatusPagamentoChanged event) async* {
    final statusPagamento = StatusPagamentoInput.dirty(event.statusPagamento);
    yield this.state.copyWith(
      statusPagamento: statusPagamento,
    );
  }
  Stream<EntradaFinanceiraState> onResponsavelPagamentoChange(ResponsavelPagamentoChanged event) async* {
    final responsavelPagamento = ResponsavelPagamentoInput.dirty(event.responsavelPagamento);
    yield this.state.copyWith(
      responsavelPagamento: responsavelPagamento,
    );
  }

  @override
  Future<void> close() {
    dataController.dispose();
    valorTotalController.dispose();
    descricaoController.dispose();
    return super.close();
  }

}
