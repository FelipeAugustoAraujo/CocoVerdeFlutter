import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/account/login/login_repository.dart';
import 'package:cocoverde/entities/fornecedor/bloc/fornecedor_bloc.dart';
import 'package:cocoverde/entities/fornecedor/fornecedor_model.dart';
import 'package:flutter/material.dart';
import 'package:cocoverde/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:cocoverde/shared/widgets/drawer/drawer_widget.dart';
import 'package:cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'package:cocoverde/shared/models/entity_arguments.dart';
import 'package:intl/intl.dart';
import 'fornecedor_route.dart';

class FornecedorListScreen extends StatelessWidget {
    FornecedorListScreen({Key? key, this.scaffoldMode = true}) : super(key: FornecedorRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
      final scaffoldMode;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<FornecedorBloc, FornecedorState>(
      listener: (context, state) {
        if(state.deleteStatus == FornecedorDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('Fornecedor deleted successfuly')
          ));
        }
      },
      child: scaffoldMode ? Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('Fornecedors List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<FornecedorBloc, FornecedorState>(
              buildWhen: (previous, current) => previous.fornecedors != current.fornecedors,
              builder: (context, state) {
                return Visibility(
                  visible: state.fornecedorStatusUI == FornecedorStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (Fornecedor fornecedor in state.fornecedors) fornecedorCard(fornecedor, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: CocoverdeDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, FornecedorRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      )
      : Column(
        children: [
          Row(
            children: [
              Text("Liste de Fornecedor", style: Theme.of(context).textTheme.headlineSmall),
              ElevatedButton(onPressed: () => Navigator.pushNamed(context, FornecedorRoutes.create), child: Icon(Icons.add))
            ],
          ),
          SingleChildScrollView(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<FornecedorBloc, FornecedorState>(
            buildWhen: (previous, current) => previous.fornecedors != current.fornecedors,
            builder: (context, state) {
              return Visibility(
                visible: state.fornecedorStatusUI == FornecedorStatusUI.done,
                replacement: LoadingIndicator(),
                child: Column(children: <Widget>[
                  for (Fornecedor fornecedor in state.fornecedors) fornecedorCard(fornecedor, context)
                ]),
              );
            }
                  ),
                ),
        ],
      ),
    );
  }

  Widget fornecedorCard(Fornecedor fornecedor, BuildContext context) {
    FornecedorBloc fornecedorBloc = BlocProvider.of<FornecedorBloc>(context);
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
                    title: Text('Nome : ${fornecedor.nome.toString()}'),
                    subtitle: Text('Identificador : ${fornecedor.identificador.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, FornecedorRoutes.edit,
                            arguments: EntityArguments(fornecedor.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              fornecedorBloc, context, fornecedor.id);
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
                  context, FornecedorRoutes.view,
                  arguments: EntityArguments(fornecedor.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(FornecedorBloc fornecedorBloc, BuildContext context, int? id) {
    return BlocProvider<FornecedorBloc>.value(
      value: fornecedorBloc,
      child: AlertDialog(
        title: new Text('Delete Fornecedors'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              fornecedorBloc.add(DeleteFornecedorById(id: id));
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
