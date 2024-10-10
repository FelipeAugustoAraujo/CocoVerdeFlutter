import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:formz/formz.dart';

import 'package:Cocoverde/entities/produto/produto_model.dart';
import 'package:Cocoverde/entities/produto/produto_repository.dart';
import 'package:Cocoverde/entities/produto/bloc/produto_form_model.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';

part 'produto_events.dart';
part 'produto_state.dart';

class ProdutoBloc extends Bloc<ProdutoEvent, ProdutoState> {
  final ProdutoRepository _produtoRepository;

  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();
  final valorBaseController = TextEditingController();

  ProdutoBloc({required ProdutoRepository produtoRepository}) :
        _produtoRepository = produtoRepository,
  super(ProdutoState());

  @override
  void onTransition(Transition<ProdutoEvent, ProdutoState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<ProdutoState> mapEventToState(ProdutoEvent event) async* {
    if (event is InitProdutoList) {
      yield* onInitList(event);

        } else if (event is InitProdutoListByEstoque) {
        yield* onInitProdutoListByEstoque(event);

        } else if (event is InitProdutoListByFrente) {
        yield* onInitProdutoListByFrente(event);

        } else if (event is InitProdutoListByDetalhesEntradaFinanceira) {
        yield* onInitProdutoListByDetalhesEntradaFinanceira(event);

        } else if (event is InitProdutoListByFornecedor) {
        yield* onInitProdutoListByFornecedor(event);
    } else if (event is ProdutoFormSubmitted) {
      yield* onSubmit();
    } else if (event is LoadProdutoByIdForEdit) {
      yield* onLoadProdutoIdForEdit(event);
    } else if (event is DeleteProdutoById) {
      yield* onDeleteProdutoId(event);
    } else if (event is LoadProdutoByIdForView) {
      yield* onLoadProdutoIdForView(event);
    }else if (event is NomeChanged){
      yield* onNomeChange(event);
    }else if (event is DescricaoChanged){
      yield* onDescricaoChange(event);
    }else if (event is ValorBaseChanged){
      yield* onValorBaseChange(event);
    }  }

  Stream<ProdutoState> onInitList(InitProdutoList event) async* {
    yield this.state.copyWith(produtoStatusUI: ProdutoStatusUI.loading);
    List<Produto> produtos = await _produtoRepository.getAllProdutos();
    yield this.state.copyWith(produtos: produtos, produtoStatusUI: ProdutoStatusUI.done);
  }


  Stream<ProdutoState> onInitProdutoListByEstoque(InitProdutoListByEstoque event) async* {
    yield this.state.copyWith(produtoStatusUI: ProdutoStatusUI.loading);
    List<Produto> produtos = await _produtoRepository.getAllProdutoListByEstoque(event.estoqueId);
    yield this.state.copyWith(produtos: produtos, produtoStatusUI: ProdutoStatusUI.done);
  }

  Stream<ProdutoState> onInitProdutoListByFrente(InitProdutoListByFrente event) async* {
    yield this.state.copyWith(produtoStatusUI: ProdutoStatusUI.loading);
    List<Produto> produtos = await _produtoRepository.getAllProdutoListByFrente(event.frenteId);
    yield this.state.copyWith(produtos: produtos, produtoStatusUI: ProdutoStatusUI.done);
  }

  Stream<ProdutoState> onInitProdutoListByDetalhesEntradaFinanceira(InitProdutoListByDetalhesEntradaFinanceira event) async* {
    yield this.state.copyWith(produtoStatusUI: ProdutoStatusUI.loading);
    List<Produto> produtos = await _produtoRepository.getAllProdutoListByDetalhesEntradaFinanceira(event.detalhesEntradaFinanceiraId);
    yield this.state.copyWith(produtos: produtos, produtoStatusUI: ProdutoStatusUI.done);
  }

  Stream<ProdutoState> onInitProdutoListByFornecedor(InitProdutoListByFornecedor event) async* {
    yield this.state.copyWith(produtoStatusUI: ProdutoStatusUI.loading);
    List<Produto> produtos = await _produtoRepository.getAllProdutoListByFornecedor(event.fornecedorId);
    yield this.state.copyWith(produtos: produtos, produtoStatusUI: ProdutoStatusUI.done);
  }

  Stream<ProdutoState> onSubmit() async* {
    if (this.state.isValid) {
      yield this.state.copyWith(formStatus: FormzSubmissionStatus.inProgress);
      try {
        Produto? result;
        if(this.state.editMode) {
          Produto newProduto = Produto(state.loadedProduto.id,
            this.state.nome.value,
            this.state.descricao.value,
            this.state.valorBase.value,
            null,
            null,
            null,
            null,
          );

          result = await _produtoRepository.update(newProduto);
        } else {
          Produto newProduto = Produto(null,
            this.state.nome.value,
            this.state.descricao.value,
            this.state.valorBase.value,
            null,
            null,
            null,
            null,
          );

          result = await _produtoRepository.create(newProduto);
        }

        yield this.state.copyWith(formStatus: FormzSubmissionStatus.success,
            generalNotificationKey: HttpUtils.successResult);
            } catch (e) {
        yield this.state.copyWith(formStatus: FormzSubmissionStatus.failure,
            generalNotificationKey: HttpUtils.errorServerKey);
      }
    }
  }

  Stream<ProdutoState> onLoadProdutoIdForEdit(LoadProdutoByIdForEdit? event) async* {
    yield this.state.copyWith(produtoStatusUI: ProdutoStatusUI.loading);
    Produto loadedProduto = await _produtoRepository.getProduto(event?.id);

    final nome = NomeInput.dirty((loadedProduto.nome != null ? loadedProduto.nome: '')!);
    final descricao = DescricaoInput.dirty((loadedProduto.descricao != null ? loadedProduto.descricao: '')!);
    final valorBase = ValorBaseInput.dirty((loadedProduto.valorBase != null ? loadedProduto.valorBase: '')!);

    yield this.state.copyWith(loadedProduto: loadedProduto, editMode: true,
      nome: nome,
      descricao: descricao,
      valorBase: valorBase,
    produtoStatusUI: ProdutoStatusUI.done);

    nomeController.text = loadedProduto.nome!;
    descricaoController.text = loadedProduto.descricao!;
    valorBaseController.text = loadedProduto.valorBase!;
  }

  Stream<ProdutoState> onDeleteProdutoId(DeleteProdutoById event) async* {
    try {
      await _produtoRepository.delete(event.id!);
      this.add(InitProdutoList());
      yield this.state.copyWith(deleteStatus: ProdutoDeleteStatus.ok);
    } catch (e) {
      yield this.state.copyWith(deleteStatus: ProdutoDeleteStatus.ko,
          generalNotificationKey: HttpUtils.errorServerKey);
    }
    yield this.state.copyWith(deleteStatus: ProdutoDeleteStatus.none);
  }

  Stream<ProdutoState> onLoadProdutoIdForView(LoadProdutoByIdForView event) async* {
    yield this.state.copyWith(produtoStatusUI: ProdutoStatusUI.loading);
    try {
      Produto loadedProduto = await _produtoRepository.getProduto(event.id);
      yield this.state.copyWith(loadedProduto: loadedProduto, produtoStatusUI: ProdutoStatusUI.done);
    } catch(e) {
      yield this.state.copyWith(loadedProduto: null, produtoStatusUI: ProdutoStatusUI.error);
    }
  }


  Stream<ProdutoState> onNomeChange(NomeChanged event) async* {
    final nome = NomeInput.dirty(event.nome);
    yield this.state.copyWith(
      nome: nome,
    );
  }
  Stream<ProdutoState> onDescricaoChange(DescricaoChanged event) async* {
    final descricao = DescricaoInput.dirty(event.descricao);
    yield this.state.copyWith(
      descricao: descricao,
    );
  }
  Stream<ProdutoState> onValorBaseChange(ValorBaseChanged event) async* {
    final valorBase = ValorBaseInput.dirty(event.valorBase);
    yield this.state.copyWith(
      valorBase: valorBase,
    );
  }

  @override
  Future<void> close() {
    nomeController.dispose();
    descricaoController.dispose();
    valorBaseController.dispose();
    return super.close();
  }

}
