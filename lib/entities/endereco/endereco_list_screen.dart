import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/account/login/login_repository.dart';
import 'package:Cocoverde/entities/endereco/bloc/endereco_bloc.dart';
import 'package:Cocoverde/entities/endereco/endereco_model.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:Cocoverde/shared/widgets/drawer/drawer_widget.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';
import 'endereco_route.dart';

class EnderecoListScreen extends StatelessWidget {
    EnderecoListScreen({Key? key, this.scaffoldMode = true}) : super(key: EnderecoRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
      final scaffoldMode;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<EnderecoBloc, EnderecoState>(
      listener: (context, state) {
        if(state.deleteStatus == EnderecoDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('Endereco deleted successfuly')
          ));
        }
      },
      child: scaffoldMode ? Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('Enderecos List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<EnderecoBloc, EnderecoState>(
              buildWhen: (previous, current) => previous.enderecos != current.enderecos,
              builder: (context, state) {
                return Visibility(
                  visible: state.enderecoStatusUI == EnderecoStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (Endereco endereco in state.enderecos) enderecoCard(endereco, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: CocoverdeDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, EnderecoRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      )
      : Column(
        children: [
          Row(
            children: [
              Text("Liste de Endereco", style: Theme.of(context).textTheme.headlineSmall),
              ElevatedButton(onPressed: () => Navigator.pushNamed(context, EnderecoRoutes.create), child: Icon(Icons.add))
            ],
          ),
          SingleChildScrollView(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<EnderecoBloc, EnderecoState>(
            buildWhen: (previous, current) => previous.enderecos != current.enderecos,
            builder: (context, state) {
              return Visibility(
                visible: state.enderecoStatusUI == EnderecoStatusUI.done,
                replacement: LoadingIndicator(),
                child: Column(children: <Widget>[
                  for (Endereco endereco in state.enderecos) enderecoCard(endereco, context)
                ]),
              );
            }
                  ),
                ),
        ],
      ),
    );
  }

  Widget enderecoCard(Endereco endereco, BuildContext context) {
    EnderecoBloc enderecoBloc = BlocProvider.of<EnderecoBloc>(context);
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
                    title: Text('Cep : ${endereco.cep.toString()}'),
                    subtitle: Text('Logradouro : ${endereco.logradouro.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, EnderecoRoutes.edit,
                            arguments: EntityArguments(endereco.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              enderecoBloc, context, endereco.id);
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
                  context, EnderecoRoutes.view,
                  arguments: EntityArguments(endereco.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(EnderecoBloc enderecoBloc, BuildContext context, int? id) {
    return BlocProvider<EnderecoBloc>.value(
      value: enderecoBloc,
      child: AlertDialog(
        title: new Text('Delete Enderecos'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              enderecoBloc.add(DeleteEnderecoById(id: id));
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
