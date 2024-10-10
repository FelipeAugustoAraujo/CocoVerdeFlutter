import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/account/login/login_repository.dart';
import 'package:Cocoverde/entities/saida_financeira/bloc/saida_financeira_bloc.dart';
import 'package:Cocoverde/entities/saida_financeira/saida_financeira_model.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:Cocoverde/shared/widgets/drawer/drawer_widget.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';
import 'package:intl/intl.dart';
import 'saida_financeira_route.dart';

class SaidaFinanceiraListScreen extends StatelessWidget {
    SaidaFinanceiraListScreen({Key? key, this.scaffoldMode = true}) : super(key: SaidaFinanceiraRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
      final scaffoldMode;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<SaidaFinanceiraBloc, SaidaFinanceiraState>(
      listener: (context, state) {
        if(state.deleteStatus == SaidaFinanceiraDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('SaidaFinanceira deleted successfuly')
          ));
        }
      },
      child: scaffoldMode ? Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('SaidaFinanceiras List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<SaidaFinanceiraBloc, SaidaFinanceiraState>(
              buildWhen: (previous, current) => previous.saidaFinanceiras != current.saidaFinanceiras,
              builder: (context, state) {
                return Visibility(
                  visible: state.saidaFinanceiraStatusUI == SaidaFinanceiraStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (SaidaFinanceira saidaFinanceira in state.saidaFinanceiras) saidaFinanceiraCard(saidaFinanceira, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: CocoverdeDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, SaidaFinanceiraRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      )
      : Column(
        children: [
          Row(
            children: [
              Text("Liste de SaidaFinanceira", style: Theme.of(context).textTheme.headlineSmall),
              ElevatedButton(onPressed: () => Navigator.pushNamed(context, SaidaFinanceiraRoutes.create), child: Icon(Icons.add))
            ],
          ),
          SingleChildScrollView(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<SaidaFinanceiraBloc, SaidaFinanceiraState>(
            buildWhen: (previous, current) => previous.saidaFinanceiras != current.saidaFinanceiras,
            builder: (context, state) {
              return Visibility(
                visible: state.saidaFinanceiraStatusUI == SaidaFinanceiraStatusUI.done,
                replacement: LoadingIndicator(),
                child: Column(children: <Widget>[
                  for (SaidaFinanceira saidaFinanceira in state.saidaFinanceiras) saidaFinanceiraCard(saidaFinanceira, context)
                ]),
              );
            }
                  ),
                ),
        ],
      ),
    );
  }

  Widget saidaFinanceiraCard(SaidaFinanceira saidaFinanceira, BuildContext context) {
    SaidaFinanceiraBloc saidaFinanceiraBloc = BlocProvider.of<SaidaFinanceiraBloc>(context);
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
                    title: Text('Data : ${saidaFinanceira.data != null ? DateFormat.yMMMMd('en').format(saidaFinanceira.data!.toDateTimeLocal()) : ''}'),
                    subtitle: Text('Valor Total : ${saidaFinanceira.valorTotal.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, SaidaFinanceiraRoutes.edit,
                            arguments: EntityArguments(saidaFinanceira.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              saidaFinanceiraBloc, context, saidaFinanceira.id);
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
                  context, SaidaFinanceiraRoutes.view,
                  arguments: EntityArguments(saidaFinanceira.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(SaidaFinanceiraBloc saidaFinanceiraBloc, BuildContext context, int? id) {
    return BlocProvider<SaidaFinanceiraBloc>.value(
      value: saidaFinanceiraBloc,
      child: AlertDialog(
        title: new Text('Delete SaidaFinanceiras'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              saidaFinanceiraBloc.add(DeleteSaidaFinanceiraById(id: id));
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
