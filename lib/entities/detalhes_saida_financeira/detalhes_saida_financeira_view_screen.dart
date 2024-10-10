import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/entities/detalhes_saida_financeira/bloc/detalhes_saida_financeira_bloc.dart';
import 'package:Cocoverde/entities/detalhes_saida_financeira/detalhes_saida_financeira_model.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'detalhes_saida_financeira_route.dart';

class DetalhesSaidaFinanceiraViewScreen extends StatelessWidget {
  DetalhesSaidaFinanceiraViewScreen({Key? key}) : super(key: DetalhesSaidaFinanceiraRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('DetalhesSaidaFinanceiras View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<DetalhesSaidaFinanceiraBloc, DetalhesSaidaFinanceiraState>(
              buildWhen: (previous, current) => previous.loadedDetalhesSaidaFinanceira != current.loadedDetalhesSaidaFinanceira,
              builder: (context, state) {
                return Visibility(
                  visible: state.detalhesSaidaFinanceiraStatusUI == DetalhesSaidaFinanceiraStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    detalhesSaidaFinanceiraCard(state.loadedDetalhesSaidaFinanceira, context),
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, DetalhesSaidaFinanceiraRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget detalhesSaidaFinanceiraCard(DetalhesSaidaFinanceira detalhesSaidaFinanceira, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + detalhesSaidaFinanceira.id.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Quantidade Item : ' + detalhesSaidaFinanceira.quantidadeItem.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Valor : ' + detalhesSaidaFinanceira.valor.toString(), style: Theme.of(context).textTheme.bodyLarge,),
          ],
        ),
      ),
    );
  }
}
