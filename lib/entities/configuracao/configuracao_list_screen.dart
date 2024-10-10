import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/account/login/login_repository.dart';
import 'package:Cocoverde/entities/configuracao/bloc/configuracao_bloc.dart';
import 'package:Cocoverde/entities/configuracao/configuracao_model.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:Cocoverde/shared/widgets/drawer/drawer_widget.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';
import 'configuracao_route.dart';

class ConfiguracaoListScreen extends StatelessWidget {
    ConfiguracaoListScreen({Key? key, this.scaffoldMode = true}) : super(key: ConfiguracaoRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
      final scaffoldMode;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<ConfiguracaoBloc, ConfiguracaoState>(
      listener: (context, state) {
        if(state.deleteStatus == ConfiguracaoDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('Configuracao deleted successfuly')
          ));
        }
      },
      child: scaffoldMode ? Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('Configuracaos List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<ConfiguracaoBloc, ConfiguracaoState>(
              buildWhen: (previous, current) => previous.configuracaos != current.configuracaos,
              builder: (context, state) {
                return Visibility(
                  visible: state.configuracaoStatusUI == ConfiguracaoStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (Configuracao configuracao in state.configuracaos) configuracaoCard(configuracao, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: CocoverdeDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, ConfiguracaoRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      )
      : Column(
        children: [
          Row(
            children: [
              Text("Liste de Configuracao", style: Theme.of(context).textTheme.headlineSmall),
              ElevatedButton(onPressed: () => Navigator.pushNamed(context, ConfiguracaoRoutes.create), child: Icon(Icons.add))
            ],
          ),
          SingleChildScrollView(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<ConfiguracaoBloc, ConfiguracaoState>(
            buildWhen: (previous, current) => previous.configuracaos != current.configuracaos,
            builder: (context, state) {
              return Visibility(
                visible: state.configuracaoStatusUI == ConfiguracaoStatusUI.done,
                replacement: LoadingIndicator(),
                child: Column(children: <Widget>[
                  for (Configuracao configuracao in state.configuracaos) configuracaoCard(configuracao, context)
                ]),
              );
            }
                  ),
                ),
        ],
      ),
    );
  }

  Widget configuracaoCard(Configuracao configuracao, BuildContext context) {
    ConfiguracaoBloc configuracaoBloc = BlocProvider.of<ConfiguracaoBloc>(context);
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.90,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 60.0,
                color: Theme.of(context).primaryColor,
              ),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, ConfiguracaoRoutes.edit,
                            arguments: EntityArguments(configuracao.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              configuracaoBloc, context, configuracao.id);
                          },
                        );
                    }
                  },
                  items: [
                    DropdownMenuItem<String>(
                      value: 'Edit',
                      child: Text('Edit'),
                    ),
                    DropdownMenuItem<String>(
                        value: 'Delete', child: Text('Delete'))
                  ]),
              selected: false,
              onTap: () => Navigator.pushNamed(
                  context, ConfiguracaoRoutes.view,
                  arguments: EntityArguments(configuracao.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(ConfiguracaoBloc configuracaoBloc, BuildContext context, int? id) {
    return BlocProvider<ConfiguracaoBloc>.value(
      value: configuracaoBloc,
      child: AlertDialog(
        title: new Text('Delete Configuracaos'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              configuracaoBloc.add(DeleteConfiguracaoById(id: id));
            },
          ),
          new TextButton(
            child: new Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

}
