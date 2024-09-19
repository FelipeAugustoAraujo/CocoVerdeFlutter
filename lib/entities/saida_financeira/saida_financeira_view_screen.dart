import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/entities/saida_financeira/bloc/saida_financeira_bloc.dart';
import 'package:cocoverde/entities/saida_financeira/saida_financeira_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'saida_financeira_route.dart';




import 'package:cocoverde/entities/imagem/imagem_repository.dart';
import 'package:cocoverde/entities/imagem/imagem_list_screen.dart';
import 'package:cocoverde/entities/imagem/bloc/imagem_bloc.dart';

class SaidaFinanceiraViewScreen extends StatelessWidget {
  SaidaFinanceiraViewScreen({Key? key}) : super(key: SaidaFinanceiraRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('SaidaFinanceiras View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<SaidaFinanceiraBloc, SaidaFinanceiraState>(
              buildWhen: (previous, current) => previous.loadedSaidaFinanceira != current.loadedSaidaFinanceira,
              builder: (context, state) {
                return Visibility(
                  visible: state.saidaFinanceiraStatusUI == SaidaFinanceiraStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    saidaFinanceiraCard(state.loadedSaidaFinanceira, context),




                        BlocProvider<ImagemBloc>(
                          create: (context) => ImagemBloc(imagemRepository: ImagemRepository())
                            ..add(InitImagemListBySaidaFinanceira (saidaFinanceiraId: state.loadedSaidaFinanceira.id!)),
                          child: ImagemListScreen(scaffoldMode: false,)),
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, SaidaFinanceiraRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget saidaFinanceiraCard(SaidaFinanceira saidaFinanceira, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + saidaFinanceira.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                // Instant
              Text('Data : ' + (saidaFinanceira.data != null ? DateFormat.yMMMMd('en').format(saidaFinanceira.data!.toDateTimeLocal()) : ''), style: Theme.of(context).textTheme.bodyText1,),
                Text('Valor Total : ' + saidaFinanceira.valorTotal.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Descricao : ' + saidaFinanceira.descricao.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Metodo Pagamento : ' + saidaFinanceira.metodoPagamento.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Status Pagamento : ' + saidaFinanceira.statusPagamento.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Responsavel Pagamento : ' + saidaFinanceira.responsavelPagamento.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
