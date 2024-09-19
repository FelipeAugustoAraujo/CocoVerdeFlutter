import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/entities/fechamento_caixa_detalhes/bloc/fechamento_caixa_detalhes_bloc.dart';
import 'package:cocoverde/entities/fechamento_caixa_detalhes/fechamento_caixa_detalhes_model.dart';
import 'package:flutter/material.dart';
import 'package:cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'fechamento_caixa_detalhes_route.dart';


import 'package:cocoverde/entities/entrada_financeira/entrada_financeira_repository.dart';
import 'package:cocoverde/entities/entrada_financeira/entrada_financeira_list_screen.dart';
import 'package:cocoverde/entities/entrada_financeira/bloc/entrada_financeira_bloc.dart';

import 'package:cocoverde/entities/saida_financeira/saida_financeira_repository.dart';
import 'package:cocoverde/entities/saida_financeira/saida_financeira_list_screen.dart';
import 'package:cocoverde/entities/saida_financeira/bloc/saida_financeira_bloc.dart';

class FechamentoCaixaDetalhesViewScreen extends StatelessWidget {
  FechamentoCaixaDetalhesViewScreen({Key? key}) : super(key: FechamentoCaixaDetalhesRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('FechamentoCaixaDetalhes View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<FechamentoCaixaDetalhesBloc, FechamentoCaixaDetalhesState>(
              buildWhen: (previous, current) => previous.loadedFechamentoCaixaDetalhes != current.loadedFechamentoCaixaDetalhes,
              builder: (context, state) {
                return Visibility(
                  visible: state.fechamentoCaixaDetalhesStatusUI == FechamentoCaixaDetalhesStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    fechamentoCaixaDetalhesCard(state.loadedFechamentoCaixaDetalhes, context),


                        BlocProvider<EntradaFinanceiraBloc>(
                          create: (context) => EntradaFinanceiraBloc(entradaFinanceiraRepository: EntradaFinanceiraRepository())
                            ..add(InitEntradaFinanceiraListByFechamentoCaixaDetalhes (fechamentoCaixaDetalhesId: state.loadedFechamentoCaixaDetalhes.id!)),
                          child: EntradaFinanceiraListScreen(scaffoldMode: false,)),

                        BlocProvider<SaidaFinanceiraBloc>(
                          create: (context) => SaidaFinanceiraBloc(saidaFinanceiraRepository: SaidaFinanceiraRepository())
                            ..add(InitSaidaFinanceiraListByFechamentoCaixaDetalhes (fechamentoCaixaDetalhesId: state.loadedFechamentoCaixaDetalhes.id!)),
                          child: SaidaFinanceiraListScreen(scaffoldMode: false,)),
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, FechamentoCaixaDetalhesRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget fechamentoCaixaDetalhesCard(FechamentoCaixaDetalhes fechamentoCaixaDetalhes, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + fechamentoCaixaDetalhes.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
