import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/entities/detalhes_entrada_financeira/bloc/detalhes_entrada_financeira_bloc.dart';
import 'package:cocoverde/entities/detalhes_entrada_financeira/detalhes_entrada_financeira_model.dart';
import 'package:flutter/material.dart';
import 'package:cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'detalhes_entrada_financeira_route.dart';



class DetalhesEntradaFinanceiraViewScreen extends StatelessWidget {
  DetalhesEntradaFinanceiraViewScreen({Key? key}) : super(key: DetalhesEntradaFinanceiraRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('DetalhesEntradaFinanceiras View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<DetalhesEntradaFinanceiraBloc, DetalhesEntradaFinanceiraState>(
              buildWhen: (previous, current) => previous.loadedDetalhesEntradaFinanceira != current.loadedDetalhesEntradaFinanceira,
              builder: (context, state) {
                return Visibility(
                  visible: state.detalhesEntradaFinanceiraStatusUI == DetalhesEntradaFinanceiraStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    detalhesEntradaFinanceiraCard(state.loadedDetalhesEntradaFinanceira, context),


                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, DetalhesEntradaFinanceiraRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget detalhesEntradaFinanceiraCard(DetalhesEntradaFinanceira detalhesEntradaFinanceira, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + detalhesEntradaFinanceira.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Quantidade Item : ' + detalhesEntradaFinanceira.quantidadeItem.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Valor : ' + detalhesEntradaFinanceira.valor.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
