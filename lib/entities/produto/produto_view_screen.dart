import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/entities/produto/bloc/produto_bloc.dart';
import 'package:Cocoverde/entities/produto/produto_model.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'produto_route.dart';



import 'package:Cocoverde/entities/detalhes_entrada_financeira/detalhes_entrada_financeira_repository.dart';
import 'package:Cocoverde/entities/detalhes_entrada_financeira/detalhes_entrada_financeira_list_screen.dart';
import 'package:Cocoverde/entities/detalhes_entrada_financeira/bloc/detalhes_entrada_financeira_bloc.dart';


class ProdutoViewScreen extends StatelessWidget {
  ProdutoViewScreen({Key? key}) : super(key: ProdutoRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Produtos View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<ProdutoBloc, ProdutoState>(
              buildWhen: (previous, current) => previous.loadedProduto != current.loadedProduto,
              builder: (context, state) {
                return Visibility(
                  visible: state.produtoStatusUI == ProdutoStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    produtoCard(state.loadedProduto, context),



                        BlocProvider<DetalhesEntradaFinanceiraBloc>(
                          create: (context) => DetalhesEntradaFinanceiraBloc(detalhesEntradaFinanceiraRepository: DetalhesEntradaFinanceiraRepository())
                            ..add(InitDetalhesEntradaFinanceiraListByProduto (produtoId: state.loadedProduto.id!)),
                          child: DetalhesEntradaFinanceiraListScreen(scaffoldMode: false,)),

                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, ProdutoRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget produtoCard(Produto produto, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + produto.id.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Nome : ' + produto.nome.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Descricao : ' + produto.descricao.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Valor Base : ' + produto.valorBase.toString(), style: Theme.of(context).textTheme.bodyLarge,),
          ],
        ),
      ),
    );
  }
}
