import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/entities/fechamento_caixa/bloc/fechamento_caixa_bloc.dart';
import 'package:cocoverde/entities/fechamento_caixa/fechamento_caixa_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'fechamento_caixa_route.dart';


class FechamentoCaixaViewScreen extends StatelessWidget {
  FechamentoCaixaViewScreen({Key? key}) : super(key: FechamentoCaixaRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('FechamentoCaixas View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<FechamentoCaixaBloc, FechamentoCaixaState>(
              buildWhen: (previous, current) => previous.loadedFechamentoCaixa != current.loadedFechamentoCaixa,
              builder: (context, state) {
                return Visibility(
                  visible: state.fechamentoCaixaStatusUI == FechamentoCaixaStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    fechamentoCaixaCard(state.loadedFechamentoCaixa, context),

                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, FechamentoCaixaRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget fechamentoCaixaCard(FechamentoCaixa fechamentoCaixa, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + fechamentoCaixa.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
                // Instant
              Text('Data Inicial : ' + (fechamentoCaixa.dataInicial != null ? DateFormat.yMMMMd('en').format(fechamentoCaixa.dataInicial!.toDateTimeLocal()) : ''), style: Theme.of(context).textTheme.bodyText1,),
                // Instant
              Text('Data Final : ' + (fechamentoCaixa.dataFinal != null ? DateFormat.yMMMMd('en').format(fechamentoCaixa.dataFinal!.toDateTimeLocal()) : ''), style: Theme.of(context).textTheme.bodyText1,),
                Text('Quantidade Cocos Perdidos : ' + fechamentoCaixa.quantidadeCocosPerdidos.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Quantidade Cocos Vendidos : ' + fechamentoCaixa.quantidadeCocosVendidos.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Quantidade Coco Sobrou : ' + fechamentoCaixa.quantidadeCocoSobrou.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Dividido Por : ' + fechamentoCaixa.divididoPor.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Valor Total Coco : ' + fechamentoCaixa.valorTotalCoco.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Valor Total Coco Perdido : ' + fechamentoCaixa.valorTotalCocoPerdido.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Valor Por Pessoa : ' + fechamentoCaixa.valorPorPessoa.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Valor Despesas : ' + fechamentoCaixa.valorDespesas.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Valor Dinheiro : ' + fechamentoCaixa.valorDinheiro.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Valor Cartao : ' + fechamentoCaixa.valorCartao.toString(), style: Theme.of(context).textTheme.bodyText1,),
                Text('Valor Total : ' + fechamentoCaixa.valorTotal.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
