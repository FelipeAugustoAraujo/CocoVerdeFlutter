import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/account/login/login_repository.dart';
import 'package:Cocoverde/entities/dia_trabalho/bloc/dia_trabalho_bloc.dart';
import 'package:Cocoverde/entities/dia_trabalho/dia_trabalho_model.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:Cocoverde/shared/widgets/drawer/drawer_widget.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';
import 'package:intl/intl.dart';
import 'dia_trabalho_route.dart';

class DiaTrabalhoListScreen extends StatelessWidget {
    DiaTrabalhoListScreen({Key? key, this.scaffoldMode = true}) : super(key: DiaTrabalhoRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
      final scaffoldMode;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<DiaTrabalhoBloc, DiaTrabalhoState>(
      listener: (context, state) {
        if(state.deleteStatus == DiaTrabalhoDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('DiaTrabalho deleted successfuly')
          ));
        }
      },
      child: scaffoldMode ? Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('DiaTrabalhos List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<DiaTrabalhoBloc, DiaTrabalhoState>(
              buildWhen: (previous, current) => previous.diaTrabalhos != current.diaTrabalhos,
              builder: (context, state) {
                return Visibility(
                  visible: state.diaTrabalhoStatusUI == DiaTrabalhoStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (DiaTrabalho diaTrabalho in state.diaTrabalhos) diaTrabalhoCard(diaTrabalho, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: CocoverdeDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, DiaTrabalhoRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      )
      : Column(
        children: [
          Row(
            children: [
              Text("Liste de DiaTrabalho", style: Theme.of(context).textTheme.headlineSmall),
              ElevatedButton(onPressed: () => Navigator.pushNamed(context, DiaTrabalhoRoutes.create), child: Icon(Icons.add))
            ],
          ),
          SingleChildScrollView(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<DiaTrabalhoBloc, DiaTrabalhoState>(
            buildWhen: (previous, current) => previous.diaTrabalhos != current.diaTrabalhos,
            builder: (context, state) {
              return Visibility(
                visible: state.diaTrabalhoStatusUI == DiaTrabalhoStatusUI.done,
                replacement: LoadingIndicator(),
                child: Column(children: <Widget>[
                  for (DiaTrabalho diaTrabalho in state.diaTrabalhos) diaTrabalhoCard(diaTrabalho, context)
                ]),
              );
            }
                  ),
                ),
        ],
      ),
    );
  }

  Widget diaTrabalhoCard(DiaTrabalho diaTrabalho, BuildContext context) {
    DiaTrabalhoBloc diaTrabalhoBloc = BlocProvider.of<DiaTrabalhoBloc>(context);
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
                    title: Text('Data : ${diaTrabalho.data != null ? DateFormat.yMMMMd('en').format(diaTrabalho.data!.toDateTimeLocal()) : ''}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, DiaTrabalhoRoutes.edit,
                            arguments: EntityArguments(diaTrabalho.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              diaTrabalhoBloc, context, diaTrabalho.id);
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
                  context, DiaTrabalhoRoutes.view,
                  arguments: EntityArguments(diaTrabalho.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(DiaTrabalhoBloc diaTrabalhoBloc, BuildContext context, int? id) {
    return BlocProvider<DiaTrabalhoBloc>.value(
      value: diaTrabalhoBloc,
      child: AlertDialog(
        title: new Text('Delete DiaTrabalhos'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              diaTrabalhoBloc.add(DeleteDiaTrabalhoById(id: id));
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
