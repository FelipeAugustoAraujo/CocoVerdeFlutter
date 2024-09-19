import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/entities/estoque/bloc/estoque_bloc.dart';
import 'package:cocoverde/entities/estoque/estoque_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'estoque_route.dart';

import 'package:cocoverde/entities/produto/produto_repository.dart';
import 'package:cocoverde/entities/produto/produto_list_screen.dart';
import 'package:cocoverde/entities/produto/bloc/produto_bloc.dart';

import 'package:cocoverde/entities/entrada_financeira/entrada_financeira_repository.dart';
import 'package:cocoverde/entities/entrada_financeira/entrada_financeira_list_screen.dart';
import 'package:cocoverde/entities/entrada_financeira/bloc/entrada_financeira_bloc.dart';

import 'package:cocoverde/entities/saida_financeira/saida_financeira_repository.dart';
import 'package:cocoverde/entities/saida_financeira/saida_financeira_list_screen.dart';
import 'package:cocoverde/entities/saida_financeira/bloc/saida_financeira_bloc.dart';

class EstoqueViewScreen extends StatelessWidget {
  EstoqueViewScreen({Key? key}) : super(key: EstoqueRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Estoques View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<EstoqueBloc, EstoqueState>(
              buildWhen: (previous, current) => previous.loadedEstoque != current.loadedEstoque,
              builder: (context, state) {
                return Visibility(
                  visible: state.estoqueStatusUI == EstoqueStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    estoqueCard(state.loadedEstoque, context),

                        BlocProvider<ProdutoBloc>(
                          create: (context) => ProdutoBloc(produtoRepository: ProdutoRepository())
                            ..add(InitProdutoListByEstoque (estoqueId: state.loadedEstoque.id!)),
                          child: ProdutoListScreen(scaffoldMode: false,)),

                        BlocProvider<EntradaFinanceiraBloc>(
                          create: (context) => EntradaFinanceiraBloc(entradaFinanceiraRepository: EntradaFinanceiraRepository())
                            ..add(InitEntradaFinanceiraListByEstoque (estoqueId: state.loadedEstoque.id!)),
                          child: EntradaFinanceiraListScreen(scaffoldMode: false,)),

                        BlocProvider<SaidaFinanceiraBloc>(
                          create: (context) => SaidaFinanceiraBloc(saidaFinanceiraRepository: SaidaFinanceiraRepository())
                            ..add(InitSaidaFinanceiraListByEstoque (estoqueId: state.loadedEstoque.id!)),
                          child: SaidaFinanceiraListScreen(scaffoldMode: false,)),
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, EstoqueRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget estoqueCard(Estoque estoque, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + estoque.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Quantidade : ' + estoque.quantidade.toString(), style: Theme.of(context).textTheme.bodyText1,),
                // Instant
              Text('Criado Em : ' + (estoque.criadoEm != null ? DateFormat.yMMMMd('en').format(estoque.criadoEm!.toDateTimeLocal()) : ''), style: Theme.of(context).textTheme.bodyText1,),
                // Instant
              Text('Modificado Em : ' + (estoque.modificadoEm != null ? DateFormat.yMMMMd('en').format(estoque.modificadoEm!.toDateTimeLocal()) : ''), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
