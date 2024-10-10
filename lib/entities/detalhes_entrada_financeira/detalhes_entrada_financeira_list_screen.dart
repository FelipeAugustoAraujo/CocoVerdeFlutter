import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/account/login/login_repository.dart';
import 'package:Cocoverde/entities/detalhes_entrada_financeira/bloc/detalhes_entrada_financeira_bloc.dart';
import 'package:Cocoverde/entities/detalhes_entrada_financeira/detalhes_entrada_financeira_model.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:Cocoverde/shared/widgets/drawer/drawer_widget.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';
import 'detalhes_entrada_financeira_route.dart';

class DetalhesEntradaFinanceiraListScreen extends StatelessWidget {
    DetalhesEntradaFinanceiraListScreen({Key? key, this.scaffoldMode = true}) : super(key: DetalhesEntradaFinanceiraRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
      final scaffoldMode;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<DetalhesEntradaFinanceiraBloc, DetalhesEntradaFinanceiraState>(
      listener: (context, state) {
        if(state.deleteStatus == DetalhesEntradaFinanceiraDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('DetalhesEntradaFinanceira deleted successfuly')
          ));
        }
      },
      child: scaffoldMode ? Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('DetalhesEntradaFinanceiras List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<DetalhesEntradaFinanceiraBloc, DetalhesEntradaFinanceiraState>(
              buildWhen: (previous, current) => previous.detalhesEntradaFinanceiras != current.detalhesEntradaFinanceiras,
              builder: (context, state) {
                return Visibility(
                  visible: state.detalhesEntradaFinanceiraStatusUI == DetalhesEntradaFinanceiraStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (DetalhesEntradaFinanceira detalhesEntradaFinanceira in state.detalhesEntradaFinanceiras) detalhesEntradaFinanceiraCard(detalhesEntradaFinanceira, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: CocoverdeDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, DetalhesEntradaFinanceiraRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      )
      : Column(
        children: [
          Row(
            children: [
              Text("Liste de DetalhesEntradaFinanceira", style: Theme.of(context).textTheme.headlineSmall),
              ElevatedButton(onPressed: () => Navigator.pushNamed(context, DetalhesEntradaFinanceiraRoutes.create), child: Icon(Icons.add))
            ],
          ),
          SingleChildScrollView(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<DetalhesEntradaFinanceiraBloc, DetalhesEntradaFinanceiraState>(
            buildWhen: (previous, current) => previous.detalhesEntradaFinanceiras != current.detalhesEntradaFinanceiras,
            builder: (context, state) {
              return Visibility(
                visible: state.detalhesEntradaFinanceiraStatusUI == DetalhesEntradaFinanceiraStatusUI.done,
                replacement: LoadingIndicator(),
                child: Column(children: <Widget>[
                  for (DetalhesEntradaFinanceira detalhesEntradaFinanceira in state.detalhesEntradaFinanceiras) detalhesEntradaFinanceiraCard(detalhesEntradaFinanceira, context)
                ]),
              );
            }
                  ),
                ),
        ],
      ),
    );
  }

  Widget detalhesEntradaFinanceiraCard(DetalhesEntradaFinanceira detalhesEntradaFinanceira, BuildContext context) {
    DetalhesEntradaFinanceiraBloc detalhesEntradaFinanceiraBloc = BlocProvider.of<DetalhesEntradaFinanceiraBloc>(context);
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
                    title: Text('Quantidade Item : ${detalhesEntradaFinanceira.quantidadeItem.toString()}'),
                    subtitle: Text('Valor : ${detalhesEntradaFinanceira.valor.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, DetalhesEntradaFinanceiraRoutes.edit,
                            arguments: EntityArguments(detalhesEntradaFinanceira.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              detalhesEntradaFinanceiraBloc, context, detalhesEntradaFinanceira.id);
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
                  context, DetalhesEntradaFinanceiraRoutes.view,
                  arguments: EntityArguments(detalhesEntradaFinanceira.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(DetalhesEntradaFinanceiraBloc detalhesEntradaFinanceiraBloc, BuildContext context, int? id) {
    return BlocProvider<DetalhesEntradaFinanceiraBloc>.value(
      value: detalhesEntradaFinanceiraBloc,
      child: AlertDialog(
        title: new Text('Delete DetalhesEntradaFinanceiras'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              detalhesEntradaFinanceiraBloc.add(DeleteDetalhesEntradaFinanceiraById(id: id));
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
