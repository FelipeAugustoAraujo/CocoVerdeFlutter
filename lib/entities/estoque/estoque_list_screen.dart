import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/account/login/login_repository.dart';
import 'package:Cocoverde/entities/estoque/bloc/estoque_bloc.dart';
import 'package:Cocoverde/entities/estoque/estoque_model.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:Cocoverde/shared/widgets/drawer/drawer_widget.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';
import 'package:intl/intl.dart';
import 'estoque_route.dart';

class EstoqueListScreen extends StatelessWidget {
    EstoqueListScreen({Key? key, this.scaffoldMode = true}) : super(key: EstoqueRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
      final scaffoldMode;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<EstoqueBloc, EstoqueState>(
      listener: (context, state) {
        if(state.deleteStatus == EstoqueDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('Estoque deleted successfuly')
          ));
        }
      },
      child: scaffoldMode ? Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('Estoques List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<EstoqueBloc, EstoqueState>(
              buildWhen: (previous, current) => previous.estoques != current.estoques,
              builder: (context, state) {
                return Visibility(
                  visible: state.estoqueStatusUI == EstoqueStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (Estoque estoque in state.estoques) estoqueCard(estoque, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: CocoverdeDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, EstoqueRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      )
      : Column(
        children: [
          Row(
            children: [
              Text("Liste de Estoque", style: Theme.of(context).textTheme.headlineSmall),
              ElevatedButton(onPressed: () => Navigator.pushNamed(context, EstoqueRoutes.create), child: Icon(Icons.add))
            ],
          ),
          SingleChildScrollView(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<EstoqueBloc, EstoqueState>(
            buildWhen: (previous, current) => previous.estoques != current.estoques,
            builder: (context, state) {
              return Visibility(
                visible: state.estoqueStatusUI == EstoqueStatusUI.done,
                replacement: LoadingIndicator(),
                child: Column(children: <Widget>[
                  for (Estoque estoque in state.estoques) estoqueCard(estoque, context)
                ]),
              );
            }
                  ),
                ),
        ],
      ),
    );
  }

  Widget estoqueCard(Estoque estoque, BuildContext context) {
    EstoqueBloc estoqueBloc = BlocProvider.of<EstoqueBloc>(context);
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
                    title: Text('Quantidade : ${estoque.quantidade.toString()}'),
                    subtitle: Text('Criado Em : ${estoque.criadoEm != null ? DateFormat.yMMMMd('en').format(estoque.criadoEm!.toDateTimeLocal()) : ''}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, EstoqueRoutes.edit,
                            arguments: EntityArguments(estoque.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              estoqueBloc, context, estoque.id);
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
                  context, EstoqueRoutes.view,
                  arguments: EntityArguments(estoque.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(EstoqueBloc estoqueBloc, BuildContext context, int? id) {
    return BlocProvider<EstoqueBloc>.value(
      value: estoqueBloc,
      child: AlertDialog(
        title: new Text('Delete Estoques'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              estoqueBloc.add(DeleteEstoqueById(id: id));
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
