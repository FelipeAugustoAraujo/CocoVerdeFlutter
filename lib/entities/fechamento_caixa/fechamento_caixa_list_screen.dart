import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/account/login/login_repository.dart';
import 'package:Cocoverde/entities/fechamento_caixa/bloc/fechamento_caixa_bloc.dart';
import 'package:Cocoverde/entities/fechamento_caixa/fechamento_caixa_model.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:Cocoverde/shared/widgets/drawer/drawer_widget.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';
import 'package:intl/intl.dart';
import 'fechamento_caixa_route.dart';

class FechamentoCaixaListScreen extends StatelessWidget {
    FechamentoCaixaListScreen({Key? key, this.scaffoldMode = true}) : super(key: FechamentoCaixaRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
      final scaffoldMode;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<FechamentoCaixaBloc, FechamentoCaixaState>(
      listener: (context, state) {
        if(state.deleteStatus == FechamentoCaixaDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('FechamentoCaixa deleted successfuly')
          ));
        }
      },
      child: scaffoldMode ? Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('FechamentoCaixas List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<FechamentoCaixaBloc, FechamentoCaixaState>(
              buildWhen: (previous, current) => previous.fechamentoCaixas != current.fechamentoCaixas,
              builder: (context, state) {
                return Visibility(
                  visible: state.fechamentoCaixaStatusUI == FechamentoCaixaStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (FechamentoCaixa fechamentoCaixa in state.fechamentoCaixas) fechamentoCaixaCard(fechamentoCaixa, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: CocoverdeDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, FechamentoCaixaRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      )
      : Column(
        children: [
          Row(
            children: [
              Text("Liste de FechamentoCaixa", style: Theme.of(context).textTheme.headlineSmall),
              ElevatedButton(onPressed: () => Navigator.pushNamed(context, FechamentoCaixaRoutes.create), child: Icon(Icons.add))
            ],
          ),
          SingleChildScrollView(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<FechamentoCaixaBloc, FechamentoCaixaState>(
            buildWhen: (previous, current) => previous.fechamentoCaixas != current.fechamentoCaixas,
            builder: (context, state) {
              return Visibility(
                visible: state.fechamentoCaixaStatusUI == FechamentoCaixaStatusUI.done,
                replacement: LoadingIndicator(),
                child: Column(children: <Widget>[
                  for (FechamentoCaixa fechamentoCaixa in state.fechamentoCaixas) fechamentoCaixaCard(fechamentoCaixa, context)
                ]),
              );
            }
                  ),
                ),
        ],
      ),
    );
  }

  Widget fechamentoCaixaCard(FechamentoCaixa fechamentoCaixa, BuildContext context) {
    FechamentoCaixaBloc fechamentoCaixaBloc = BlocProvider.of<FechamentoCaixaBloc>(context);
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
                    title: Text('Data Inicial : ${fechamentoCaixa.dataInicial != null ? DateFormat.yMMMMd('en').format(fechamentoCaixa.dataInicial!.toDateTimeLocal()) : ''}'),
                    subtitle: Text('Data Final : ${fechamentoCaixa.dataFinal != null ? DateFormat.yMMMMd('en').format(fechamentoCaixa.dataFinal!.toDateTimeLocal()) : ''}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, FechamentoCaixaRoutes.edit,
                            arguments: EntityArguments(fechamentoCaixa.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              fechamentoCaixaBloc, context, fechamentoCaixa.id);
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
                  context, FechamentoCaixaRoutes.view,
                  arguments: EntityArguments(fechamentoCaixa.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(FechamentoCaixaBloc fechamentoCaixaBloc, BuildContext context, int? id) {
    return BlocProvider<FechamentoCaixaBloc>.value(
      value: fechamentoCaixaBloc,
      child: AlertDialog(
        title: new Text('Delete FechamentoCaixas'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              fechamentoCaixaBloc.add(DeleteFechamentoCaixaById(id: id));
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
