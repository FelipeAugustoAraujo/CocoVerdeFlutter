import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/entities/configuracao/bloc/configuracao_bloc.dart';
import 'package:cocoverde/entities/configuracao/configuracao_model.dart';
import 'package:flutter/material.dart';
import 'package:cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'configuracao_route.dart';

class ConfiguracaoViewScreen extends StatelessWidget {
  ConfiguracaoViewScreen({Key? key}) : super(key: ConfiguracaoRoutes.createScreenKey);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:Text('Configuracaos View'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<ConfiguracaoBloc, ConfiguracaoState>(
              buildWhen: (previous, current) => previous.loadedConfiguracao != current.loadedConfiguracao,
              builder: (context, state) {
                return Visibility(
                  visible: state.configuracaoStatusUI == ConfiguracaoStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    configuracaoCard(state.loadedConfiguracao, context),
                  ]),
                );
              }
            ),
          ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, ConfiguracaoRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
    );
  }

  Widget configuracaoCard(Configuracao configuracao, BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Id : ' + configuracao.id.toString(), style: Theme.of(context).textTheme.bodyText1,),
          ],
        ),
      ),
    );
  }
}
