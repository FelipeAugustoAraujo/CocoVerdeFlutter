import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/account/login/login_repository.dart';
import 'package:Cocoverde/entities/cidade/bloc/cidade_bloc.dart';
import 'package:Cocoverde/entities/cidade/cidade_model.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:Cocoverde/shared/widgets/drawer/drawer_widget.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';
import 'cidade_route.dart';

class CidadeListScreen extends StatelessWidget {
    CidadeListScreen({Key? key, this.scaffoldMode = true}) : super(key: CidadeRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
      final scaffoldMode;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<CidadeBloc, CidadeState>(
      listener: (context, state) {
        if(state.deleteStatus == CidadeDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('Cidade deleted successfuly')
          ));
        }
      },
      child: scaffoldMode ? Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('Cidades List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<CidadeBloc, CidadeState>(
              buildWhen: (previous, current) => previous.cidades != current.cidades,
              builder: (context, state) {
                return Visibility(
                  visible: state.cidadeStatusUI == CidadeStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (Cidade cidade in state.cidades) cidadeCard(cidade, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: CocoverdeDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, CidadeRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      )
      : Column(
        children: [
          Row(
            children: [
              Text("Liste de Cidade", style: Theme.of(context).textTheme.headlineSmall),
              ElevatedButton(onPressed: () => Navigator.pushNamed(context, CidadeRoutes.create), child: Icon(Icons.add))
            ],
          ),
          SingleChildScrollView(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<CidadeBloc, CidadeState>(
            buildWhen: (previous, current) => previous.cidades != current.cidades,
            builder: (context, state) {
              return Visibility(
                visible: state.cidadeStatusUI == CidadeStatusUI.done,
                replacement: LoadingIndicator(),
                child: Column(children: <Widget>[
                  for (Cidade cidade in state.cidades) cidadeCard(cidade, context)
                ]),
              );
            }
                  ),
                ),
        ],
      ),
    );
  }

  Widget cidadeCard(Cidade cidade, BuildContext context) {
    CidadeBloc cidadeBloc = BlocProvider.of<CidadeBloc>(context);
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
                    title: Text('Nome : ${cidade.nome.toString()}'),
                    subtitle: Text('Estado : ${cidade.estado.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, CidadeRoutes.edit,
                            arguments: EntityArguments(cidade.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              cidadeBloc, context, cidade.id);
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
                  context, CidadeRoutes.view,
                  arguments: EntityArguments(cidade.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(CidadeBloc cidadeBloc, BuildContext context, int? id) {
    return BlocProvider<CidadeBloc>.value(
      value: cidadeBloc,
      child: AlertDialog(
        title: new Text('Delete Cidades'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              cidadeBloc.add(DeleteCidadeById(id: id));
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
