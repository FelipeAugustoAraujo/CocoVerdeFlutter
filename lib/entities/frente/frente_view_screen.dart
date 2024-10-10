import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/entities/frente/bloc/frente_bloc.dart';
import 'package:Cocoverde/entities/frente/frente_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'frente_route.dart';

import 'package:Cocoverde/entities/produto/produto_repository.dart';
import 'package:Cocoverde/entities/produto/produto_list_screen.dart';
import 'package:Cocoverde/entities/produto/bloc/produto_bloc.dart';

import 'package:Cocoverde/entities/entrada_financeira/entrada_financeira_repository.dart';
import 'package:Cocoverde/entities/entrada_financeira/entrada_financeira_list_screen.dart';
import 'package:Cocoverde/entities/entrada_financeira/bloc/entrada_financeira_bloc.dart';

import 'package:Cocoverde/entities/saida_financeira/saida_financeira_repository.dart';
import 'package:Cocoverde/entities/saida_financeira/saida_financeira_list_screen.dart';
import 'package:Cocoverde/entities/saida_financeira/bloc/saida_financeira_bloc.dart';

class FrenteViewScreen extends StatelessWidget {
  FrenteViewScreen({Key? key}) : super(key: FrenteRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Frentes View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<FrenteBloc, FrenteState>(
              buildWhen: (previous, current) => previous.loadedFrente != current.loadedFrente,
              builder: (context, state) {
                return Visibility(
                  visible: state.frenteStatusUI == FrenteStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    frenteCard(state.loadedFrente, context),

                        BlocProvider<ProdutoBloc>(
                          create: (context) => ProdutoBloc(produtoRepository: ProdutoRepository())
                            ..add(InitProdutoListByFrente (frenteId: state.loadedFrente.id!)),
                          child: ProdutoListScreen(scaffoldMode: false,)),

                        BlocProvider<EntradaFinanceiraBloc>(
                          create: (context) => EntradaFinanceiraBloc(entradaFinanceiraRepository: EntradaFinanceiraRepository())
                            ..add(InitEntradaFinanceiraListByFrente (frenteId: state.loadedFrente.id!)),
                          child: EntradaFinanceiraListScreen(scaffoldMode: false,)),

                        BlocProvider<SaidaFinanceiraBloc>(
                          create: (context) => SaidaFinanceiraBloc(saidaFinanceiraRepository: SaidaFinanceiraRepository())
                            ..add(InitSaidaFinanceiraListByFrente (frenteId: state.loadedFrente.id!)),
                          child: SaidaFinanceiraListScreen(scaffoldMode: false,)),
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, FrenteRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget frenteCard(Frente frente, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + frente.id.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Quantidade : ' + frente.quantidade.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                // Instant
              Text('Criado Em : ' + (frente.criadoEm != null ? DateFormat.yMMMMd('en').format(frente.criadoEm!.toDateTimeLocal()) : ''), style: Theme.of(context).textTheme.bodyLarge,),
                // Instant
              Text('Modificado Em : ' + (frente.modificadoEm != null ? DateFormat.yMMMMd('en').format(frente.modificadoEm!.toDateTimeLocal()) : ''), style: Theme.of(context).textTheme.bodyLarge,),
          ],
        ),
      ),
    );
  }
}
