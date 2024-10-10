import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/entities/entrada_financeira/bloc/entrada_financeira_bloc.dart';
import 'package:Cocoverde/entities/entrada_financeira/entrada_financeira_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'entrada_financeira_route.dart';





import 'package:Cocoverde/entities/detalhes_entrada_financeira/detalhes_entrada_financeira_repository.dart';
import 'package:Cocoverde/entities/detalhes_entrada_financeira/detalhes_entrada_financeira_list_screen.dart';
import 'package:Cocoverde/entities/detalhes_entrada_financeira/bloc/detalhes_entrada_financeira_bloc.dart';

import 'package:Cocoverde/entities/imagem/imagem_repository.dart';
import 'package:Cocoverde/entities/imagem/imagem_list_screen.dart';
import 'package:Cocoverde/entities/imagem/bloc/imagem_bloc.dart';

class EntradaFinanceiraViewScreen extends StatelessWidget {
  EntradaFinanceiraViewScreen({Key? key}) : super(key: EntradaFinanceiraRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('EntradaFinanceiras View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<EntradaFinanceiraBloc, EntradaFinanceiraState>(
              buildWhen: (previous, current) => previous.loadedEntradaFinanceira != current.loadedEntradaFinanceira,
              builder: (context, state) {
                return Visibility(
                  visible: state.entradaFinanceiraStatusUI == EntradaFinanceiraStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    entradaFinanceiraCard(state.loadedEntradaFinanceira, context),





                        BlocProvider<DetalhesEntradaFinanceiraBloc>(
                          create: (context) => DetalhesEntradaFinanceiraBloc(detalhesEntradaFinanceiraRepository: DetalhesEntradaFinanceiraRepository())
                            ..add(InitDetalhesEntradaFinanceiraListByEntradaFinanceira (entradaFinanceiraId: state.loadedEntradaFinanceira.id!)),
                          child: DetalhesEntradaFinanceiraListScreen(scaffoldMode: false,)),

                        BlocProvider<ImagemBloc>(
                          create: (context) => ImagemBloc(imagemRepository: ImagemRepository())
                            ..add(InitImagemListByEntradaFinanceira (entradaFinanceiraId: state.loadedEntradaFinanceira.id!)),
                          child: ImagemListScreen(scaffoldMode: false,)),
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, EntradaFinanceiraRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget entradaFinanceiraCard(EntradaFinanceira entradaFinanceira, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + entradaFinanceira.id.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                // Instant
              Text('Data : ' + (entradaFinanceira.data != null ? DateFormat.yMMMMd('en').format(entradaFinanceira.data!.toDateTimeLocal()) : ''), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Valor Total : ' + entradaFinanceira.valorTotal.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Descricao : ' + entradaFinanceira.descricao.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Metodo Pagamento : ' + entradaFinanceira.metodoPagamento.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Status Pagamento : ' + entradaFinanceira.statusPagamento.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Responsavel Pagamento : ' + entradaFinanceira.responsavelPagamento.toString(), style: Theme.of(context).textTheme.bodyLarge,),
          ],
        ),
      ),
    );
  }
}
