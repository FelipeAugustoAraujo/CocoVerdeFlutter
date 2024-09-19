part of 'produto_bloc.dart';

enum ProdutoStatusUI {init, loading, error, done}
enum ProdutoDeleteStatus {ok, ko, none}

class ProdutoState extends Equatable with FormzMixin {
  final List<Produto> produtos;
  final Produto loadedProduto;
  final bool editMode;
  final ProdutoDeleteStatus deleteStatus;
  final ProdutoStatusUI produtoStatusUI;

  final FormzSubmissionStatus formStatus;
  final String generalNotificationKey;

  final NomeInput nome;
  final DescricaoInput descricao;
  final ValorBaseInput valorBase;


  ProdutoState({
    this.produtos = const [],
    this.produtoStatusUI = ProdutoStatusUI.init,
    this.loadedProduto = const Produto(0,'','','',null,null,null,null,),
    this.editMode = false,
    this.formStatus = FormzSubmissionStatus.initial,
    this.generalNotificationKey = '',
    this.deleteStatus = ProdutoDeleteStatus.none,
    this.nome = const NomeInput.pure(),
    this.descricao = const DescricaoInput.pure(),
    this.valorBase = const ValorBaseInput.pure(),
  });

  ProdutoState copyWith({
    List<Produto>? produtos,
    ProdutoStatusUI? produtoStatusUI,
    bool? editMode,
    ProdutoDeleteStatus? deleteStatus,
    Produto? loadedProduto,
    FormzSubmissionStatus? formStatus,
    String? generalNotificationKey,
    NomeInput? nome,
    DescricaoInput? descricao,
    ValorBaseInput? valorBase,
  }) {
    return ProdutoState(
      produtos: produtos ?? this.produtos,
      produtoStatusUI: produtoStatusUI ?? this.produtoStatusUI,
      loadedProduto: loadedProduto ?? this.loadedProduto,
      editMode: editMode ?? this.editMode,
      formStatus: formStatus ?? this.formStatus,
      generalNotificationKey: generalNotificationKey ?? this.generalNotificationKey,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      valorBase: valorBase ?? this.valorBase,
    );
  }

  @override
  List<Object> get props => [produtos, produtoStatusUI,
     loadedProduto, editMode, deleteStatus, formStatus, generalNotificationKey,
nome,descricao,valorBase,];

  @override
  bool get stringify => true;

  @override
  List<FormzInput> get inputs => [nome,descricao,valorBase,];
}
