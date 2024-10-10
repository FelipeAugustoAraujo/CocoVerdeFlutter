import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/entities/cidade/bloc/cidade_bloc.dart';
import 'package:Cocoverde/entities/cidade/cidade_model.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'cidade_route.dart';

import 'package:Cocoverde/entities/endereco/endereco_repository.dart';
import 'package:Cocoverde/entities/endereco/endereco_list_screen.dart';
import 'package:Cocoverde/entities/endereco/bloc/endereco_bloc.dart';

class CidadeViewScreen extends StatelessWidget {
  CidadeViewScreen({Key? key}) : super(key: CidadeRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Cidades View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<CidadeBloc, CidadeState>(
              buildWhen: (previous, current) => previous.loadedCidade != current.loadedCidade,
              builder: (context, state) {
                return Visibility(
                  visible: state.cidadeStatusUI == CidadeStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    cidadeCard(state.loadedCidade, context),

                        BlocProvider<EnderecoBloc>(
                          create: (context) => EnderecoBloc(enderecoRepository: EnderecoRepository())
                            ..add(InitEnderecoListByCidade (cidadeId: state.loadedCidade.id!)),
                          child: EnderecoListScreen(scaffoldMode: false,)),
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, CidadeRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget cidadeCard(Cidade cidade, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + cidade.id.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Nome : ' + cidade.nome.toString(), style: Theme.of(context).textTheme.bodyLarge,),
                Text('Estado : ' + cidade.estado.toString(), style: Theme.of(context).textTheme.bodyLarge,),
          ],
        ),
      ),
    );
  }
}
