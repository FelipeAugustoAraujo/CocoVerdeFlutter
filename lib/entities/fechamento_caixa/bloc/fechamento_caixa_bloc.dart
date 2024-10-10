import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';
import 'package:time_machine/time_machine.dart';

import 'package:Cocoverde/entities/fechamento_caixa/fechamento_caixa_model.dart';
import 'package:Cocoverde/entities/fechamento_caixa/fechamento_caixa_repository.dart';
import 'package:Cocoverde/entities/fechamento_caixa/bloc/fechamento_caixa_form_model.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';
import 'package:intl/intl.dart';

part 'fechamento_caixa_events.dart';
part 'fechamento_caixa_state.dart';

class FechamentoCaixaBloc extends Bloc<FechamentoCaixaEvent, FechamentoCaixaState> {
  final FechamentoCaixaRepository _fechamentoCaixaRepository;

  final dataInicialController = TextEditingController();
  final dataFinalController = TextEditingController();
  final quantidadeCocosPerdidosController = TextEditingController();
  final quantidadeCocosVendidosController = TextEditingController();
  final quantidadeCocoSobrouController = TextEditingController();
  final divididoPorController = TextEditingController();
  final valorTotalCocoController = TextEditingController();
  final valorTotalCocoPerdidoController = TextEditingController();
  final valorPorPessoaController = TextEditingController();
  final valorDespesasController = TextEditingController();
  final valorDinheiroController = TextEditingController();
  final valorCartaoController = TextEditingController();
  final valorTotalController = TextEditingController();

  FechamentoCaixaBloc({required FechamentoCaixaRepository fechamentoCaixaRepository}) :
        _fechamentoCaixaRepository = fechamentoCaixaRepository,
  super(FechamentoCaixaState());

  @override
  void onTransition(Transition<FechamentoCaixaEvent, FechamentoCaixaState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<FechamentoCaixaState> mapEventToState(FechamentoCaixaEvent event) async* {
    if (event is InitFechamentoCaixaList) {
      yield* onInitList(event);

        } else if (event is InitFechamentoCaixaListByFechamentoCaixaDetalhes) {
        yield* onInitFechamentoCaixaListByFechamentoCaixaDetalhes(event);
    } else if (event is FechamentoCaixaFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadFechamentoCaixaByIdForEdit) {
      yield* onLoadFechamentoCaixaIdForEdit(event);
    } else if (event is DeleteFechamentoCaixaById) {
      yield* onDeleteFechamentoCaixaId(event);
    } else if (event is LoadFechamentoCaixaByIdForView) {
      yield* onLoadFechamentoCaixaIdForView(event);
    }else if (event is DataInicialChanged){
      yield* onDataInicialChange(event);
    }else if (event is DataFinalChanged){
      yield* onDataFinalChange(event);
    }else if (event is QuantidadeCocosPerdidosChanged){
      yield* onQuantidadeCocosPerdidosChange(event);
    }else if (event is QuantidadeCocosVendidosChanged){
      yield* onQuantidadeCocosVendidosChange(event);
    }else if (event is QuantidadeCocoSobrouChanged){
      yield* onQuantidadeCocoSobrouChange(event);
    }else if (event is DivididoPorChanged){
      yield* onDivididoPorChange(event);
    }else if (event is ValorTotalCocoChanged){
      yield* onValorTotalCocoChange(event);
    }else if (event is ValorTotalCocoPerdidoChanged){
      yield* onValorTotalCocoPerdidoChange(event);
    }else if (event is ValorPorPessoaChanged){
      yield* onValorPorPessoaChange(event);
    }else if (event is ValorDespesasChanged){
      yield* onValorDespesasChange(event);
    }else if (event is ValorDinheiroChanged){
      yield* onValorDinheiroChange(event);
    }else if (event is ValorCartaoChanged){
      yield* onValorCartaoChange(event);
    }else if (event is ValorTotalChanged){
      yield* onValorTotalChange(event);
    }  }

  Stream<FechamentoCaixaState> onInitList(InitFechamentoCaixaList event) async* {
    yield this.state.copyWith(fechamentoCaixaStatusUI: FechamentoCaixaStatusUI.loading);
    List<FechamentoCaixa> fechamentoCaixas = await _fechamentoCaixaRepository.getAllFechamentoCaixas();
    yield this.state.copyWith(fechamentoCaixas: fechamentoCaixas, fechamentoCaixaStatusUI: FechamentoCaixaStatusUI.done);
  }


  Stream<FechamentoCaixaState> onInitFechamentoCaixaListByFechamentoCaixaDetalhes(InitFechamentoCaixaListByFechamentoCaixaDetalhes event) async* {
    yield this.state.copyWith(fechamentoCaixaStatusUI: FechamentoCaixaStatusUI.loading);
    List<FechamentoCaixa> fechamentoCaixas = await _fechamentoCaixaRepository.getAllFechamentoCaixaListByFechamentoCaixaDetalhes(event.fechamentoCaixaDetalhesId);
    yield this.state.copyWith(fechamentoCaixas: fechamentoCaixas, fechamentoCaixaStatusUI: FechamentoCaixaStatusUI.done);
  }

  Stream<FechamentoCaixaState> onSubmit() async* {
    if (this.state.isValid) {
      yield this.state.copyWith(formStatus: FormzSubmissionStatus.inProgress);
      try {
        FechamentoCaixa? result;
        if(this.state.editMode) {
          FechamentoCaixa newFechamentoCaixa = FechamentoCaixa(state.loadedFechamentoCaixa.id,
            this.state.dataInicial.value,
            this.state.dataFinal.value,
            this.state.quantidadeCocosPerdidos.value,
            this.state.quantidadeCocosVendidos.value,
            this.state.quantidadeCocoSobrou.value,
            this.state.divididoPor.value,
            this.state.valorTotalCoco.value,
            this.state.valorTotalCocoPerdido.value,
            this.state.valorPorPessoa.value,
            this.state.valorDespesas.value,
            this.state.valorDinheiro.value,
            this.state.valorCartao.value,
            this.state.valorTotal.value,
            null,
          );

          result = await _fechamentoCaixaRepository.update(newFechamentoCaixa);
        } else {
          FechamentoCaixa newFechamentoCaixa = FechamentoCaixa(null,
            this.state.dataInicial.value,
            this.state.dataFinal.value,
            this.state.quantidadeCocosPerdidos.value,
            this.state.quantidadeCocosVendidos.value,
            this.state.quantidadeCocoSobrou.value,
            this.state.divididoPor.value,
            this.state.valorTotalCoco.value,
            this.state.valorTotalCocoPerdido.value,
            this.state.valorPorPessoa.value,
            this.state.valorDespesas.value,
            this.state.valorDinheiro.value,
            this.state.valorCartao.value,
            this.state.valorTotal.value,
            null,
          );

          result = await _fechamentoCaixaRepository.create(newFechamentoCaixa);
        }

        yield this.state.copyWith(formStatus: FormzSubmissionStatus.success,
            generalNotificationKey: HttpUtils.successResult);
            } catch (e) {
        yield this.state.copyWith(formStatus: FormzSubmissionStatus.failure,
            generalNotificationKey: HttpUtils.errorServerKey);
      }
    }
  }

  Stream<FechamentoCaixaState> onLoadFechamentoCaixaIdForEdit(LoadFechamentoCaixaByIdForEdit? event) async* {
    yield this.state.copyWith(fechamentoCaixaStatusUI: FechamentoCaixaStatusUI.loading);
    FechamentoCaixa loadedFechamentoCaixa = await _fechamentoCaixaRepository.getFechamentoCaixa(event?.id);

    final dataInicial = DataInicialInput.dirty((loadedFechamentoCaixa.dataInicial != null ? loadedFechamentoCaixa.dataInicial: null)!);
    final dataFinal = DataFinalInput.dirty((loadedFechamentoCaixa.dataFinal != null ? loadedFechamentoCaixa.dataFinal: null)!);
    final quantidadeCocosPerdidos = QuantidadeCocosPerdidosInput.dirty((loadedFechamentoCaixa.quantidadeCocosPerdidos != null ? loadedFechamentoCaixa.quantidadeCocosPerdidos: 0)!);
    final quantidadeCocosVendidos = QuantidadeCocosVendidosInput.dirty((loadedFechamentoCaixa.quantidadeCocosVendidos != null ? loadedFechamentoCaixa.quantidadeCocosVendidos: 0)!);
    final quantidadeCocoSobrou = QuantidadeCocoSobrouInput.dirty((loadedFechamentoCaixa.quantidadeCocoSobrou != null ? loadedFechamentoCaixa.quantidadeCocoSobrou: 0)!);
    final divididoPor = DivididoPorInput.dirty((loadedFechamentoCaixa.divididoPor != null ? loadedFechamentoCaixa.divididoPor: 0)!);
    final valorTotalCoco = ValorTotalCocoInput.dirty((loadedFechamentoCaixa.valorTotalCoco != null ? loadedFechamentoCaixa.valorTotalCoco: '')!);
    final valorTotalCocoPerdido = ValorTotalCocoPerdidoInput.dirty((loadedFechamentoCaixa.valorTotalCocoPerdido != null ? loadedFechamentoCaixa.valorTotalCocoPerdido: '')!);
    final valorPorPessoa = ValorPorPessoaInput.dirty((loadedFechamentoCaixa.valorPorPessoa != null ? loadedFechamentoCaixa.valorPorPessoa: '')!);
    final valorDespesas = ValorDespesasInput.dirty((loadedFechamentoCaixa.valorDespesas != null ? loadedFechamentoCaixa.valorDespesas: '')!);
    final valorDinheiro = ValorDinheiroInput.dirty((loadedFechamentoCaixa.valorDinheiro != null ? loadedFechamentoCaixa.valorDinheiro: '')!);
    final valorCartao = ValorCartaoInput.dirty((loadedFechamentoCaixa.valorCartao != null ? loadedFechamentoCaixa.valorCartao: '')!);
    final valorTotal = ValorTotalInput.dirty((loadedFechamentoCaixa.valorTotal != null ? loadedFechamentoCaixa.valorTotal: '')!);

    yield this.state.copyWith(loadedFechamentoCaixa: loadedFechamentoCaixa, editMode: true,
      dataInicial: dataInicial,
      dataFinal: dataFinal,
      quantidadeCocosPerdidos: quantidadeCocosPerdidos,
      quantidadeCocosVendidos: quantidadeCocosVendidos,
      quantidadeCocoSobrou: quantidadeCocoSobrou,
      divididoPor: divididoPor,
      valorTotalCoco: valorTotalCoco,
      valorTotalCocoPerdido: valorTotalCocoPerdido,
      valorPorPessoa: valorPorPessoa,
      valorDespesas: valorDespesas,
      valorDinheiro: valorDinheiro,
      valorCartao: valorCartao,
      valorTotal: valorTotal,
    fechamentoCaixaStatusUI: FechamentoCaixaStatusUI.done);

    dataInicialController.text = DateFormat.yMMMMd('en').format(loadedFechamentoCaixa.dataInicial!.toDateTimeLocal());
    dataFinalController.text = DateFormat.yMMMMd('en').format(loadedFechamentoCaixa.dataFinal!.toDateTimeLocal());
    quantidadeCocosPerdidosController.text = loadedFechamentoCaixa.quantidadeCocosPerdidos!.toString();
    quantidadeCocosVendidosController.text = loadedFechamentoCaixa.quantidadeCocosVendidos!.toString();
    quantidadeCocoSobrouController.text = loadedFechamentoCaixa.quantidadeCocoSobrou!.toString();
    divididoPorController.text = loadedFechamentoCaixa.divididoPor!.toString();
    valorTotalCocoController.text = loadedFechamentoCaixa.valorTotalCoco!;
    valorTotalCocoPerdidoController.text = loadedFechamentoCaixa.valorTotalCocoPerdido!;
    valorPorPessoaController.text = loadedFechamentoCaixa.valorPorPessoa!;
    valorDespesasController.text = loadedFechamentoCaixa.valorDespesas!;
    valorDinheiroController.text = loadedFechamentoCaixa.valorDinheiro!;
    valorCartaoController.text = loadedFechamentoCaixa.valorCartao!;
    valorTotalController.text = loadedFechamentoCaixa.valorTotal!;
  }

  Stream<FechamentoCaixaState> onDeleteFechamentoCaixaId(DeleteFechamentoCaixaById event) async* {
    try {
      await _fechamentoCaixaRepository.delete(event.id!);
      this.add(InitFechamentoCaixaList());
      yield this.state.copyWith(deleteStatus: FechamentoCaixaDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: FechamentoCaixaDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: FechamentoCaixaDeleteStatus.none);
  }

  Stream<FechamentoCaixaState> onLoadFechamentoCaixaIdForView(LoadFechamentoCaixaByIdForView event) async* {
    yield this.state.copyWith(fechamentoCaixaStatusUI: FechamentoCaixaStatusUI.loading);
    try {
      FechamentoCaixa loadedFechamentoCaixa = await _fechamentoCaixaRepository.getFechamentoCaixa(event.id);
      yield this.state.copyWith(loadedFechamentoCaixa: loadedFechamentoCaixa, fechamentoCaixaStatusUI: FechamentoCaixaStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedFechamentoCaixa: null, fechamentoCaixaStatusUI: FechamentoCaixaStatusUI.error);
    }
  }


  Stream<FechamentoCaixaState> onDataInicialChange(DataInicialChanged event) async* {
    final dataInicial = DataInicialInput.dirty(event.dataInicial);
    yield this.state.copyWith(
      dataInicial: dataInicial,
    );
  }
  Stream<FechamentoCaixaState> onDataFinalChange(DataFinalChanged event) async* {
    final dataFinal = DataFinalInput.dirty(event.dataFinal);
    yield this.state.copyWith(
      dataFinal: dataFinal,
    );
  }
  Stream<FechamentoCaixaState> onQuantidadeCocosPerdidosChange(QuantidadeCocosPerdidosChanged event) async* {
    final quantidadeCocosPerdidos = QuantidadeCocosPerdidosInput.dirty(event.quantidadeCocosPerdidos);
    yield this.state.copyWith(
      quantidadeCocosPerdidos: quantidadeCocosPerdidos,
    );
  }
  Stream<FechamentoCaixaState> onQuantidadeCocosVendidosChange(QuantidadeCocosVendidosChanged event) async* {
    final quantidadeCocosVendidos = QuantidadeCocosVendidosInput.dirty(event.quantidadeCocosVendidos);
    yield this.state.copyWith(
      quantidadeCocosVendidos: quantidadeCocosVendidos,
    );
  }
  Stream<FechamentoCaixaState> onQuantidadeCocoSobrouChange(QuantidadeCocoSobrouChanged event) async* {
    final quantidadeCocoSobrou = QuantidadeCocoSobrouInput.dirty(event.quantidadeCocoSobrou);
    yield this.state.copyWith(
      quantidadeCocoSobrou: quantidadeCocoSobrou,
    );
  }
  Stream<FechamentoCaixaState> onDivididoPorChange(DivididoPorChanged event) async* {
    final divididoPor = DivididoPorInput.dirty(event.divididoPor);
    yield this.state.copyWith(
      divididoPor: divididoPor,
    );
  }
  Stream<FechamentoCaixaState> onValorTotalCocoChange(ValorTotalCocoChanged event) async* {
    final valorTotalCoco = ValorTotalCocoInput.dirty(event.valorTotalCoco);
    yield this.state.copyWith(
      valorTotalCoco: valorTotalCoco,
    );
  }
  Stream<FechamentoCaixaState> onValorTotalCocoPerdidoChange(ValorTotalCocoPerdidoChanged event) async* {
    final valorTotalCocoPerdido = ValorTotalCocoPerdidoInput.dirty(event.valorTotalCocoPerdido);
    yield this.state.copyWith(
      valorTotalCocoPerdido: valorTotalCocoPerdido,
    );
  }
  Stream<FechamentoCaixaState> onValorPorPessoaChange(ValorPorPessoaChanged event) async* {
    final valorPorPessoa = ValorPorPessoaInput.dirty(event.valorPorPessoa);
    yield this.state.copyWith(
      valorPorPessoa: valorPorPessoa,
    );
  }
  Stream<FechamentoCaixaState> onValorDespesasChange(ValorDespesasChanged event) async* {
    final valorDespesas = ValorDespesasInput.dirty(event.valorDespesas);
    yield this.state.copyWith(
      valorDespesas: valorDespesas,
    );
  }
  Stream<FechamentoCaixaState> onValorDinheiroChange(ValorDinheiroChanged event) async* {
    final valorDinheiro = ValorDinheiroInput.dirty(event.valorDinheiro);
    yield this.state.copyWith(
      valorDinheiro: valorDinheiro,
    );
  }
  Stream<FechamentoCaixaState> onValorCartaoChange(ValorCartaoChanged event) async* {
    final valorCartao = ValorCartaoInput.dirty(event.valorCartao);
    yield this.state.copyWith(
      valorCartao: valorCartao,
    );
  }
  Stream<FechamentoCaixaState> onValorTotalChange(ValorTotalChanged event) async* {
    final valorTotal = ValorTotalInput.dirty(event.valorTotal);
    yield this.state.copyWith(
      valorTotal: valorTotal,
    );
  }

  @override
  Future<void> close() {
    dataInicialController.dispose();
    dataFinalController.dispose();
    quantidadeCocosPerdidosController.dispose();
    quantidadeCocosVendidosController.dispose();
    quantidadeCocoSobrouController.dispose();
    divididoPorController.dispose();
    valorTotalCocoController.dispose();
    valorTotalCocoPerdidoController.dispose();
    valorPorPessoaController.dispose();
    valorDespesasController.dispose();
    valorDinheiroController.dispose();
    valorCartaoController.dispose();
    valorTotalController.dispose();
    return super.close();
  }

}
