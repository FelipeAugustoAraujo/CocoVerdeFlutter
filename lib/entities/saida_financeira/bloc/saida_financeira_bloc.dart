import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:time_machine/time_machine.dart';

import 'package:Cocoverde/entities/saida_financeira/saida_financeira_model.dart';
import 'package:Cocoverde/entities/saida_financeira/saida_financeira_repository.dart';
import 'package:Cocoverde/entities/saida_financeira/bloc/saida_financeira_form_model.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'saida_financeira_events.dart';
part 'saida_financeira_state.dart';

class SaidaFinanceiraBloc extends Bloc<SaidaFinanceiraEvent, SaidaFinanceiraState> {
  final SaidaFinanceiraRepository _saidaFinanceiraRepository;

  final dataController = TextEditingController();
  final valorTotalController = TextEditingController();
  final descricaoController = TextEditingController();

  SaidaFinanceiraBloc({required SaidaFinanceiraRepository saidaFinanceiraRepository}) :
        _saidaFinanceiraRepository = saidaFinanceiraRepository,
  super(SaidaFinanceiraState());

  @override
  void onTransition(Transition<SaidaFinanceiraEvent, SaidaFinanceiraState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<SaidaFinanceiraState> mapEventToState(SaidaFinanceiraEvent event) async* {
    if (event is InitSaidaFinanceiraList) {
      yield* onInitList(event);

        } else if (event is InitSaidaFinanceiraListByEstoque) {
        yield* onInitSaidaFinanceiraListByEstoque(event);

        } else if (event is InitSaidaFinanceiraListByFrente) {
        yield* onInitSaidaFinanceiraListByFrente(event);

        } else if (event is InitSaidaFinanceiraListByFechamentoCaixaDetalhes) {
        yield* onInitSaidaFinanceiraListByFechamentoCaixaDetalhes(event);

        } else if (event is InitSaidaFinanceiraListByImagem) {
        yield* onInitSaidaFinanceiraListByImagem(event);
    } else if (event is SaidaFinanceiraFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadSaidaFinanceiraByIdForEdit) {
      yield* onLoadSaidaFinanceiraIdForEdit(event);
    } else if (event is DeleteSaidaFinanceiraById) {
      yield* onDeleteSaidaFinanceiraId(event);
    } else if (event is LoadSaidaFinanceiraByIdForView) {
      yield* onLoadSaidaFinanceiraIdForView(event);
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

  Stream<SaidaFinanceiraState> onInitList(InitSaidaFinanceiraList event) async* {
    yield this.state.copyWith(saidaFinanceiraStatusUI: SaidaFinanceiraStatusUI.loading);
    List<SaidaFinanceira> saidaFinanceiras = await _saidaFinanceiraRepository.getAllSaidaFinanceiras();
    yield this.state.copyWith(saidaFinanceiras: saidaFinanceiras, saidaFinanceiraStatusUI: SaidaFinanceiraStatusUI.done);
  }


  Stream<SaidaFinanceiraState> onInitSaidaFinanceiraListByEstoque(InitSaidaFinanceiraListByEstoque event) async* {
    yield this.state.copyWith(saidaFinanceiraStatusUI: SaidaFinanceiraStatusUI.loading);
    List<SaidaFinanceira> saidaFinanceiras = await _saidaFinanceiraRepository.getAllSaidaFinanceiraListByEstoque(event.estoqueId);
    yield this.state.copyWith(saidaFinanceiras: saidaFinanceiras, saidaFinanceiraStatusUI: SaidaFinanceiraStatusUI.done);
  }

  Stream<SaidaFinanceiraState> onInitSaidaFinanceiraListByFrente(InitSaidaFinanceiraListByFrente event) async* {
    yield this.state.copyWith(saidaFinanceiraStatusUI: SaidaFinanceiraStatusUI.loading);
    List<SaidaFinanceira> saidaFinanceiras = await _saidaFinanceiraRepository.getAllSaidaFinanceiraListByFrente(event.frenteId);
    yield this.state.copyWith(saidaFinanceiras: saidaFinanceiras, saidaFinanceiraStatusUI: SaidaFinanceiraStatusUI.done);
  }

  Stream<SaidaFinanceiraState> onInitSaidaFinanceiraListByFechamentoCaixaDetalhes(InitSaidaFinanceiraListByFechamentoCaixaDetalhes event) async* {
    yield this.state.copyWith(saidaFinanceiraStatusUI: SaidaFinanceiraStatusUI.loading);
    List<SaidaFinanceira> saidaFinanceiras = await _saidaFinanceiraRepository.getAllSaidaFinanceiraListByFechamentoCaixaDetalhes(event.fechamentoCaixaDetalhesId);
    yield this.state.copyWith(saidaFinanceiras: saidaFinanceiras, saidaFinanceiraStatusUI: SaidaFinanceiraStatusUI.done);
  }

  Stream<SaidaFinanceiraState> onInitSaidaFinanceiraListByImagem(InitSaidaFinanceiraListByImagem event) async* {
    yield this.state.copyWith(saidaFinanceiraStatusUI: SaidaFinanceiraStatusUI.loading);
    List<SaidaFinanceira> saidaFinanceiras = await _saidaFinanceiraRepository.getAllSaidaFinanceiraListByImagem(event.imagemId);
    yield this.state.copyWith(saidaFinanceiras: saidaFinanceiras, saidaFinanceiraStatusUI: SaidaFinanceiraStatusUI.done);
  }

  Stream<SaidaFinanceiraState> onSubmit() async* {
    if (this.state.isValid) {
      yield this.state.copyWith(formStatus: FormzSubmissionStatus.inProgress);
      try {
        SaidaFinanceira? result;
        if(this.state.editMode) {
          SaidaFinanceira newSaidaFinanceira = SaidaFinanceira(state.loadedSaidaFinanceira.id,
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
          );

          result = await _saidaFinanceiraRepository.update(newSaidaFinanceira);
        } else {
          SaidaFinanceira newSaidaFinanceira = SaidaFinanceira(null,
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
          );

          result = await _saidaFinanceiraRepository.create(newSaidaFinanceira);
        }

        yield this.state.copyWith(formStatus: FormzSubmissionStatus.success,
            generalNotificationKey: HttpUtils.successResult);
            } catch (e) {
        yield this.state.copyWith(formStatus: FormzSubmissionStatus.failure,
            generalNotificationKey: HttpUtils.errorServerKey);
      }
    }
  }

  Stream<SaidaFinanceiraState> onLoadSaidaFinanceiraIdForEdit(LoadSaidaFinanceiraByIdForEdit? event) async* {
    yield this.state.copyWith(saidaFinanceiraStatusUI: SaidaFinanceiraStatusUI.loading);
    SaidaFinanceira loadedSaidaFinanceira = await _saidaFinanceiraRepository.getSaidaFinanceira(event?.id);

    final data = DataInput.dirty((loadedSaidaFinanceira.data != null ? loadedSaidaFinanceira.data: null)!);
    final valorTotal = ValorTotalInput.dirty((loadedSaidaFinanceira.valorTotal != null ? loadedSaidaFinanceira.valorTotal: '')!);
    final descricao = DescricaoInput.dirty((loadedSaidaFinanceira.descricao != null ? loadedSaidaFinanceira.descricao: '')!);
    final metodoPagamento = MetodoPagamentoInput.dirty((loadedSaidaFinanceira.metodoPagamento != null ? loadedSaidaFinanceira.metodoPagamento: null)!);
    final statusPagamento = StatusPagamentoInput.dirty((loadedSaidaFinanceira.statusPagamento != null ? loadedSaidaFinanceira.statusPagamento: null)!);
    final responsavelPagamento = ResponsavelPagamentoInput.dirty((loadedSaidaFinanceira.responsavelPagamento != null ? loadedSaidaFinanceira.responsavelPagamento: null)!);

    yield this.state.copyWith(loadedSaidaFinanceira: loadedSaidaFinanceira, editMode: true,
      data: data,
      valorTotal: valorTotal,
      descricao: descricao,
      metodoPagamento: metodoPagamento,
      statusPagamento: statusPagamento,
      responsavelPagamento: responsavelPagamento,
    saidaFinanceiraStatusUI: SaidaFinanceiraStatusUI.done);

    dataController.text = DateFormat.yMMMMd('en').format(loadedSaidaFinanceira.data!.toDateTimeLocal());
    valorTotalController.text = loadedSaidaFinanceira.valorTotal!;
    descricaoController.text = loadedSaidaFinanceira.descricao!;
  }

  Stream<SaidaFinanceiraState> onDeleteSaidaFinanceiraId(DeleteSaidaFinanceiraById event) async* {
    try {
      await _saidaFinanceiraRepository.delete(event.id!);
      this.add(InitSaidaFinanceiraList());
      yield this.state.copyWith(deleteStatus: SaidaFinanceiraDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: SaidaFinanceiraDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: SaidaFinanceiraDeleteStatus.none);
  }

  Stream<SaidaFinanceiraState> onLoadSaidaFinanceiraIdForView(LoadSaidaFinanceiraByIdForView event) async* {
    yield this.state.copyWith(saidaFinanceiraStatusUI: SaidaFinanceiraStatusUI.loading);
    try {
      SaidaFinanceira loadedSaidaFinanceira = await _saidaFinanceiraRepository.getSaidaFinanceira(event.id);
      yield this.state.copyWith(loadedSaidaFinanceira: loadedSaidaFinanceira, saidaFinanceiraStatusUI: SaidaFinanceiraStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedSaidaFinanceira: null, saidaFinanceiraStatusUI: SaidaFinanceiraStatusUI.error);
    }
  }


  Stream<SaidaFinanceiraState> onDataChange(DataChanged event) async* {
    final data = DataInput.dirty(event.data);
    yield this.state.copyWith(
      data: data,
    );
  }
  Stream<SaidaFinanceiraState> onValorTotalChange(ValorTotalChanged event) async* {
    final valorTotal = ValorTotalInput.dirty(event.valorTotal);
    yield this.state.copyWith(
      valorTotal: valorTotal,
    );
  }
  Stream<SaidaFinanceiraState> onDescricaoChange(DescricaoChanged event) async* {
    final descricao = DescricaoInput.dirty(event.descricao);
    yield this.state.copyWith(
      descricao: descricao,
    );
  }
  Stream<SaidaFinanceiraState> onMetodoPagamentoChange(MetodoPagamentoChanged event) async* {
    final metodoPagamento = MetodoPagamentoInput.dirty(event.metodoPagamento);
    yield this.state.copyWith(
      metodoPagamento: metodoPagamento,
    );
  }
  Stream<SaidaFinanceiraState> onStatusPagamentoChange(StatusPagamentoChanged event) async* {
    final statusPagamento = StatusPagamentoInput.dirty(event.statusPagamento);
    yield this.state.copyWith(
      statusPagamento: statusPagamento,
    );
  }
  Stream<SaidaFinanceiraState> onResponsavelPagamentoChange(ResponsavelPagamentoChanged event) async* {
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
