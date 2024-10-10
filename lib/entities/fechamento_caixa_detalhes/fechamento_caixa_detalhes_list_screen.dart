import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/account/login/login_repository.dart';
import 'package:Cocoverde/entities/fechamento_caixa_detalhes/bloc/fechamento_caixa_detalhes_bloc.dart';
import 'package:Cocoverde/entities/fechamento_caixa_detalhes/fechamento_caixa_detalhes_model.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:Cocoverde/shared/widgets/drawer/drawer_widget.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';
import 'fechamento_caixa_detalhes_route.dart';

class FechamentoCaixaDetalhesListScreen extends StatelessWidget {
    FechamentoCaixaDetalhesListScreen({Key? key, this.scaffoldMode = true}) : super(key: FechamentoCaixaDetalhesRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
      final scaffoldMode;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<FechamentoCaixaDetalhesBloc, FechamentoCaixaDetalhesState>(
      listener: (context, state) {
        if(state.deleteStatus == FechamentoCaixaDetalhesDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('FechamentoCaixaDetalhes deleted successfuly')
          ));
        }
      },
      child: scaffoldMode ? Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('FechamentoCaixaDetalhes List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<FechamentoCaixaDetalhesBloc, FechamentoCaixaDetalhesState>(
              buildWhen: (previous, current) => previous.fechamentoCaixaDetalhes != current.fechamentoCaixaDetalhes,
              builder: (context, state) {
                return Visibility(
                  visible: state.fechamentoCaixaDetalhesStatusUI == FechamentoCaixaDetalhesStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (FechamentoCaixaDetalhes fechamentoCaixaDetalhes in state.fechamentoCaixaDetalhes) fechamentoCaixaDetalhesCard(fechamentoCaixaDetalhes, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: CocoverdeDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, FechamentoCaixaDetalhesRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      )
      : Column(
        children: [
          Row(
            children: [
              Text("Liste de FechamentoCaixaDetalhes", style: Theme.of(context).textTheme.headlineSmall),
              ElevatedButton(onPressed: () => Navigator.pushNamed(context, FechamentoCaixaDetalhesRoutes.create), child: Icon(Icons.add))
            ],
          ),
          SingleChildScrollView(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<FechamentoCaixaDetalhesBloc, FechamentoCaixaDetalhesState>(
            buildWhen: (previous, current) => previous.fechamentoCaixaDetalhes != current.fechamentoCaixaDetalhes,
            builder: (context, state) {
              return Visibility(
                visible: state.fechamentoCaixaDetalhesStatusUI == FechamentoCaixaDetalhesStatusUI.done,
                replacement: LoadingIndicator(),
                child: Column(children: <Widget>[
                  for (FechamentoCaixaDetalhes fechamentoCaixaDetalhes in state.fechamentoCaixaDetalhes) fechamentoCaixaDetalhesCard(fechamentoCaixaDetalhes, context)
                ]),
              );
            }
                  ),
                ),
        ],
      ),
    );
  }

  Widget fechamentoCaixaDetalhesCard(FechamentoCaixaDetalhes fechamentoCaixaDetalhes, BuildContext context) {
    FechamentoCaixaDetalhesBloc fechamentoCaixaDetalhesBloc = BlocProvider.of<FechamentoCaixaDetalhesBloc>(context);
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
                            context, FechamentoCaixaDetalhesRoutes.edit,
                            arguments: EntityArguments(fechamentoCaixaDetalhes.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              fechamentoCaixaDetalhesBloc, context, fechamentoCaixaDetalhes.id);
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
                  context, FechamentoCaixaDetalhesRoutes.view,
                  arguments: EntityArguments(fechamentoCaixaDetalhes.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(FechamentoCaixaDetalhesBloc fechamentoCaixaDetalhesBloc, BuildContext context, int? id) {
    return BlocProvider<FechamentoCaixaDetalhesBloc>.value(
      value: fechamentoCaixaDetalhesBloc,
      child: AlertDialog(
        title: new Text('Delete FechamentoCaixaDetalhes'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              fechamentoCaixaDetalhesBloc.add(DeleteFechamentoCaixaDetalhesById(id: id));
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
