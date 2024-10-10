import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/account/login/login_repository.dart';
import 'package:Cocoverde/entities/entrada_financeira/bloc/entrada_financeira_bloc.dart';
import 'package:Cocoverde/entities/entrada_financeira/entrada_financeira_model.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:Cocoverde/shared/widgets/drawer/drawer_widget.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';
import 'package:intl/intl.dart';
import 'entrada_financeira_route.dart';

class EntradaFinanceiraListScreen extends StatelessWidget {
    EntradaFinanceiraListScreen({Key? key, this.scaffoldMode = true}) : super(key: EntradaFinanceiraRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
      final scaffoldMode;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<EntradaFinanceiraBloc, EntradaFinanceiraState>(
      listener: (context, state) {
        if(state.deleteStatus == EntradaFinanceiraDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('EntradaFinanceira deleted successfuly')
          ));
        }
      },
      child: scaffoldMode ? Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('EntradaFinanceiras List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<EntradaFinanceiraBloc, EntradaFinanceiraState>(
              buildWhen: (previous, current) => previous.entradaFinanceiras != current.entradaFinanceiras,
              builder: (context, state) {
                return Visibility(
                  visible: state.entradaFinanceiraStatusUI == EntradaFinanceiraStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (EntradaFinanceira entradaFinanceira in state.entradaFinanceiras) entradaFinanceiraCard(entradaFinanceira, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: CocoverdeDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, EntradaFinanceiraRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      )
      : Column(
        children: [
          Row(
            children: [
              Text("Liste de EntradaFinanceira", style: Theme.of(context).textTheme.headlineSmall),
              ElevatedButton(onPressed: () => Navigator.pushNamed(context, EntradaFinanceiraRoutes.create), child: Icon(Icons.add))
            ],
          ),
          SingleChildScrollView(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<EntradaFinanceiraBloc, EntradaFinanceiraState>(
            buildWhen: (previous, current) => previous.entradaFinanceiras != current.entradaFinanceiras,
            builder: (context, state) {
              return Visibility(
                visible: state.entradaFinanceiraStatusUI == EntradaFinanceiraStatusUI.done,
                replacement: LoadingIndicator(),
                child: Column(children: <Widget>[
                  for (EntradaFinanceira entradaFinanceira in state.entradaFinanceiras) entradaFinanceiraCard(entradaFinanceira, context)
                ]),
              );
            }
                  ),
                ),
        ],
      ),
    );
  }

  Widget entradaFinanceiraCard(EntradaFinanceira entradaFinanceira, BuildContext context) {
    EntradaFinanceiraBloc entradaFinanceiraBloc = BlocProvider.of<EntradaFinanceiraBloc>(context);
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
                    title: Text('Data : ${entradaFinanceira.data != null ? DateFormat.yMMMMd('en').format(entradaFinanceira.data!.toDateTimeLocal()) : ''}'),
                    subtitle: Text('Valor Total : ${entradaFinanceira.valorTotal.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, EntradaFinanceiraRoutes.edit,
                            arguments: EntityArguments(entradaFinanceira.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              entradaFinanceiraBloc, context, entradaFinanceira.id);
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
                  context, EntradaFinanceiraRoutes.view,
                  arguments: EntityArguments(entradaFinanceira.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(EntradaFinanceiraBloc entradaFinanceiraBloc, BuildContext context, int? id) {
    return BlocProvider<EntradaFinanceiraBloc>.value(
      value: entradaFinanceiraBloc,
      child: AlertDialog(
        title: new Text('Delete EntradaFinanceiras'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              entradaFinanceiraBloc.add(DeleteEntradaFinanceiraById(id: id));
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
