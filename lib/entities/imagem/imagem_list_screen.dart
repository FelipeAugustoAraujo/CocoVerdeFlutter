import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/account/login/login_repository.dart';
import 'package:Cocoverde/entities/imagem/bloc/imagem_bloc.dart';
import 'package:Cocoverde/entities/imagem/imagem_model.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:Cocoverde/shared/widgets/drawer/drawer_widget.dart';
import 'package:Cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';
import 'imagem_route.dart';

class ImagemListScreen extends StatelessWidget {
    ImagemListScreen({Key? key, this.scaffoldMode = true}) : super(key: ImagemRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
      final scaffoldMode;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<ImagemBloc, ImagemState>(
      listener: (context, state) {
        if(state.deleteStatus == ImagemDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('Imagem deleted successfuly')
          ));
        }
      },
      child: scaffoldMode ? Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('Imagems List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<ImagemBloc, ImagemState>(
              buildWhen: (previous, current) => previous.imagems != current.imagems,
              builder: (context, state) {
                return Visibility(
                  visible: state.imagemStatusUI == ImagemStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (Imagem imagem in state.imagems) imagemCard(imagem, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: CocoverdeDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, ImagemRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      )
      : Column(
        children: [
          Row(
            children: [
              Text("Liste de Imagem", style: Theme.of(context).textTheme.headlineSmall),
              ElevatedButton(onPressed: () => Navigator.pushNamed(context, ImagemRoutes.create), child: Icon(Icons.add))
            ],
          ),
          SingleChildScrollView(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<ImagemBloc, ImagemState>(
            buildWhen: (previous, current) => previous.imagems != current.imagems,
            builder: (context, state) {
              return Visibility(
                visible: state.imagemStatusUI == ImagemStatusUI.done,
                replacement: LoadingIndicator(),
                child: Column(children: <Widget>[
                  for (Imagem imagem in state.imagems) imagemCard(imagem, context)
                ]),
              );
            }
                  ),
                ),
        ],
      ),
    );
  }

  Widget imagemCard(Imagem imagem, BuildContext context) {
    ImagemBloc imagemBloc = BlocProvider.of<ImagemBloc>(context);
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
                    title: Text('Name : ${imagem.name.toString()}'),
                    subtitle: Text('Content Type : ${imagem.contentType.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, ImagemRoutes.edit,
                            arguments: EntityArguments(imagem.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              imagemBloc, context, imagem.id);
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
                  context, ImagemRoutes.view,
                  arguments: EntityArguments(imagem.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(ImagemBloc imagemBloc, BuildContext context, int? id) {
    return BlocProvider<ImagemBloc>.value(
      value: imagemBloc,
      child: AlertDialog(
        title: new Text('Delete Imagems'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              imagemBloc.add(DeleteImagemById(id: id));
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
