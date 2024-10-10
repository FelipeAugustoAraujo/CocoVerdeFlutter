import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/account/login/login_repository.dart';
import 'package:Cocoverde/entities/detalhes_saida_financeira/bloc/detalhes_saida_financeira_bloc.dart';
import 'package:Cocoverde/entities/detalhes_saida_financeira/detalhes_saida_financeira_model.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:Cocoverde/shared/widgets/drawer/drawer_widget.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';
import 'detalhes_saida_financeira_route.dart';

class DetalhesSaidaFinanceiraListScreen extends StatelessWidget {
    DetalhesSaidaFinanceiraListScreen({Key? key, this.scaffoldMode = true}) : super(key: DetalhesSaidaFinanceiraRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
      final scaffoldMode;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<DetalhesSaidaFinanceiraBloc, DetalhesSaidaFinanceiraState>(
      listener: (context, state) {
        if(state.deleteStatus == DetalhesSaidaFinanceiraDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('DetalhesSaidaFinanceira deleted successfuly')
          ));
        }
      },
      child: scaffoldMode ? Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('DetalhesSaidaFinanceiras List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<DetalhesSaidaFinanceiraBloc, DetalhesSaidaFinanceiraState>(
              buildWhen: (previous, current) => previous.detalhesSaidaFinanceiras != current.detalhesSaidaFinanceiras,
              builder: (context, state) {
                return Visibility(
                  visible: state.detalhesSaidaFinanceiraStatusUI == DetalhesSaidaFinanceiraStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (DetalhesSaidaFinanceira detalhesSaidaFinanceira in state.detalhesSaidaFinanceiras) detalhesSaidaFinanceiraCard(detalhesSaidaFinanceira, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: CocoverdeDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, DetalhesSaidaFinanceiraRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      )
      : Column(
        children: [
          Row(
            children: [
              Text("Liste de DetalhesSaidaFinanceira", style: Theme.of(context).textTheme.headlineSmall),
              ElevatedButton(onPressed: () => Navigator.pushNamed(context, DetalhesSaidaFinanceiraRoutes.create), child: Icon(Icons.add))
            ],
          ),
          SingleChildScrollView(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<DetalhesSaidaFinanceiraBloc, DetalhesSaidaFinanceiraState>(
            buildWhen: (previous, current) => previous.detalhesSaidaFinanceiras != current.detalhesSaidaFinanceiras,
            builder: (context, state) {
              return Visibility(
                visible: state.detalhesSaidaFinanceiraStatusUI == DetalhesSaidaFinanceiraStatusUI.done,
                replacement: LoadingIndicator(),
                child: Column(children: <Widget>[
                  for (DetalhesSaidaFinanceira detalhesSaidaFinanceira in state.detalhesSaidaFinanceiras) detalhesSaidaFinanceiraCard(detalhesSaidaFinanceira, context)
                ]),
              );
            }
                  ),
                ),
        ],
      ),
    );
  }

  Widget detalhesSaidaFinanceiraCard(DetalhesSaidaFinanceira detalhesSaidaFinanceira, BuildContext context) {
    DetalhesSaidaFinanceiraBloc detalhesSaidaFinanceiraBloc = BlocProvider.of<DetalhesSaidaFinanceiraBloc>(context);
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
                    title: Text('Quantidade Item : ${detalhesSaidaFinanceira.quantidadeItem.toString()}'),
                    subtitle: Text('Valor : ${detalhesSaidaFinanceira.valor.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, DetalhesSaidaFinanceiraRoutes.edit,
                            arguments: EntityArguments(detalhesSaidaFinanceira.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              detalhesSaidaFinanceiraBloc, context, detalhesSaidaFinanceira.id);
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
                  context, DetalhesSaidaFinanceiraRoutes.view,
                  arguments: EntityArguments(detalhesSaidaFinanceira.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(DetalhesSaidaFinanceiraBloc detalhesSaidaFinanceiraBloc, BuildContext context, int? id) {
    return BlocProvider<DetalhesSaidaFinanceiraBloc>.value(
      value: detalhesSaidaFinanceiraBloc,
      child: AlertDialog(
        title: new Text('Delete DetalhesSaidaFinanceiras'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              detalhesSaidaFinanceiraBloc.add(DeleteDetalhesSaidaFinanceiraById(id: id));
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
