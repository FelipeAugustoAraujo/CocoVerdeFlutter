import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/account/login/login_repository.dart';
import 'package:Cocoverde/entities/funcionario/bloc/funcionario_bloc.dart';
import 'package:Cocoverde/entities/funcionario/funcionario_model.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:Cocoverde/shared/widgets/drawer/drawer_widget.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';
import 'funcionario_route.dart';

class FuncionarioListScreen extends StatelessWidget {
    FuncionarioListScreen({Key? key, this.scaffoldMode = true}) : super(key: FuncionarioRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
      final scaffoldMode;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<FuncionarioBloc, FuncionarioState>(
      listener: (context, state) {
        if(state.deleteStatus == FuncionarioDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('Funcionario deleted successfuly')
          ));
        }
      },
      child: scaffoldMode ? Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('Funcionarios List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<FuncionarioBloc, FuncionarioState>(
              buildWhen: (previous, current) => previous.funcionarios != current.funcionarios,
              builder: (context, state) {
                return Visibility(
                  visible: state.funcionarioStatusUI == FuncionarioStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (Funcionario funcionario in state.funcionarios) funcionarioCard(funcionario, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: CocoverdeDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, FuncionarioRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      )
      : Column(
        children: [
          Row(
            children: [
              Text("Liste de Funcionario", style: Theme.of(context).textTheme.headlineSmall),
              ElevatedButton(onPressed: () => Navigator.pushNamed(context, FuncionarioRoutes.create), child: Icon(Icons.add))
            ],
          ),
          SingleChildScrollView(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<FuncionarioBloc, FuncionarioState>(
            buildWhen: (previous, current) => previous.funcionarios != current.funcionarios,
            builder: (context, state) {
              return Visibility(
                visible: state.funcionarioStatusUI == FuncionarioStatusUI.done,
                replacement: LoadingIndicator(),
                child: Column(children: <Widget>[
                  for (Funcionario funcionario in state.funcionarios) funcionarioCard(funcionario, context)
                ]),
              );
            }
                  ),
                ),
        ],
      ),
    );
  }

  Widget funcionarioCard(Funcionario funcionario, BuildContext context) {
    FuncionarioBloc funcionarioBloc = BlocProvider.of<FuncionarioBloc>(context);
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
                    title: Text('Nome : ${funcionario.nome.toString()}'),
                    subtitle: Text('Data Nascimento : ${funcionario.dataNascimento.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, FuncionarioRoutes.edit,
                            arguments: EntityArguments(funcionario.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              funcionarioBloc, context, funcionario.id);
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
                  context, FuncionarioRoutes.view,
                  arguments: EntityArguments(funcionario.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(FuncionarioBloc funcionarioBloc, BuildContext context, int? id) {
    return BlocProvider<FuncionarioBloc>.value(
      value: funcionarioBloc,
      child: AlertDialog(
        title: new Text('Delete Funcionarios'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              funcionarioBloc.add(DeleteFuncionarioById(id: id));
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
