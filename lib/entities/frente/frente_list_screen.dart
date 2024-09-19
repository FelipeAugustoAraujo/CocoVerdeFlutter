import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/account/login/login_repository.dart';
import 'package:cocoverde/entities/frente/bloc/frente_bloc.dart';
import 'package:cocoverde/entities/frente/frente_model.dart';
import 'package:flutter/material.dart';
import 'package:cocoverde/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:cocoverde/shared/widgets/drawer/drawer_widget.dart';
import 'package:cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'package:cocoverde/shared/models/entity_arguments.dart';
import 'package:intl/intl.dart';
import 'frente_route.dart';

class FrenteListScreen extends StatelessWidget {
    FrenteListScreen({Key? key, this.scaffoldMode = true}) : super(key: FrenteRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
      final scaffoldMode;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<FrenteBloc, FrenteState>(
      listener: (context, state) {
        if(state.deleteStatus == FrenteDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('Frente deleted successfuly')
          ));
        }
      },
      child: scaffoldMode ? Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('Frentes List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<FrenteBloc, FrenteState>(
              buildWhen: (previous, current) => previous.frentes != current.frentes,
              builder: (context, state) {
                return Visibility(
                  visible: state.frenteStatusUI == FrenteStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (Frente frente in state.frentes) frenteCard(frente, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: CocoverdeDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, FrenteRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      )
      : Column(
        children: [
          Row(
            children: [
              Text("Liste de Frente", style: Theme.of(context).textTheme.headlineSmall),
              ElevatedButton(onPressed: () => Navigator.pushNamed(context, FrenteRoutes.create), child: Icon(Icons.add))
            ],
          ),
          SingleChildScrollView(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<FrenteBloc, FrenteState>(
            buildWhen: (previous, current) => previous.frentes != current.frentes,
            builder: (context, state) {
              return Visibility(
                visible: state.frenteStatusUI == FrenteStatusUI.done,
                replacement: LoadingIndicator(),
                child: Column(children: <Widget>[
                  for (Frente frente in state.frentes) frenteCard(frente, context)
                ]),
              );
            }
                  ),
                ),
        ],
      ),
    );
  }

  Widget frenteCard(Frente frente, BuildContext context) {
    FrenteBloc frenteBloc = BlocProvider.of<FrenteBloc>(context);
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
                    title: Text('Quantidade : ${frente.quantidade.toString()}'),
                    subtitle: Text('Criado Em : ${frente.criadoEm != null ? DateFormat.yMMMMd('en').format(frente.criadoEm!.toDateTimeLocal()) : ''}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, FrenteRoutes.edit,
                            arguments: EntityArguments(frente.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              frenteBloc, context, frente.id);
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
                  context, FrenteRoutes.view,
                  arguments: EntityArguments(frente.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(FrenteBloc frenteBloc, BuildContext context, int? id) {
    return BlocProvider<FrenteBloc>.value(
      value: frenteBloc,
      child: AlertDialog(
        title: new Text('Delete Frentes'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              frenteBloc.add(DeleteFrenteById(id: id));
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
