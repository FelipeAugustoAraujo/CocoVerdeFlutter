import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/account/login/login_repository.dart';
import 'package:cocoverde/entities/cliente/bloc/cliente_bloc.dart';
import 'package:cocoverde/entities/cliente/cliente_model.dart';
import 'package:flutter/material.dart';
import 'package:cocoverde/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:cocoverde/shared/widgets/drawer/drawer_widget.dart';
import 'package:cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'package:cocoverde/shared/models/entity_arguments.dart';
import 'package:intl/intl.dart';
import 'cliente_route.dart';

class ClienteListScreen extends StatelessWidget {
    ClienteListScreen({Key? key, this.scaffoldMode = true}) : super(key: ClienteRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
      final scaffoldMode;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<ClienteBloc, ClienteState>(
      listener: (context, state) {
        if(state.deleteStatus == ClienteDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('Cliente deleted successfuly')
          ));
        }
      },
      child: scaffoldMode ? Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('Clientes List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<ClienteBloc, ClienteState>(
              buildWhen: (previous, current) => previous.clientes != current.clientes,
              builder: (context, state) {
                return Visibility(
                  visible: state.clienteStatusUI == ClienteStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (Cliente cliente in state.clientes) clienteCard(cliente, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: CocoverdeDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, ClienteRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      )
      : Column(
        children: [
          Row(
            children: [
              Text("Liste de Cliente", style: Theme.of(context).textTheme.headlineSmall),
              ElevatedButton(onPressed: () => Navigator.pushNamed(context, ClienteRoutes.create), child: Icon(Icons.add))
            ],
          ),
          SingleChildScrollView(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<ClienteBloc, ClienteState>(
            buildWhen: (previous, current) => previous.clientes != current.clientes,
            builder: (context, state) {
              return Visibility(
                visible: state.clienteStatusUI == ClienteStatusUI.done,
                replacement: LoadingIndicator(),
                child: Column(children: <Widget>[
                  for (Cliente cliente in state.clientes) clienteCard(cliente, context)
                ]),
              );
            }
                  ),
                ),
        ],
      ),
    );
  }

  Widget clienteCard(Cliente cliente, BuildContext context) {
    ClienteBloc clienteBloc = BlocProvider.of<ClienteBloc>(context);
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
                    title: Text('Nome : ${cliente.nome.toString()}'),
                    subtitle: Text('Data Nascimento : ${cliente.dataNascimento.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, ClienteRoutes.edit,
                            arguments: EntityArguments(cliente.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              clienteBloc, context, cliente.id);
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
                  context, ClienteRoutes.view,
                  arguments: EntityArguments(cliente.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(ClienteBloc clienteBloc, BuildContext context, int? id) {
    return BlocProvider<ClienteBloc>.value(
      value: clienteBloc,
      child: AlertDialog(
        title: new Text('Delete Clientes'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              clienteBloc.add(DeleteClienteById(id: id));
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
