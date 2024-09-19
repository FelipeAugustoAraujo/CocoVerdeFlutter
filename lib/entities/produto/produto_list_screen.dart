import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/account/login/login_repository.dart';
import 'package:cocoverde/entities/produto/bloc/produto_bloc.dart';
import 'package:cocoverde/entities/produto/produto_model.dart';
import 'package:flutter/material.dart';
import 'package:cocoverde/shared/widgets/drawer/bloc/drawer_bloc.dart';
import 'package:cocoverde/shared/widgets/drawer/drawer_widget.dart';
import 'package:cocoverde/shared/widgets/loading_indicator_widget.dart';
import 'package:cocoverde/shared/models/entity_arguments.dart';
import 'package:intl/intl.dart';
import 'produto_route.dart';

class ProdutoListScreen extends StatelessWidget {
    ProdutoListScreen({Key? key, this.scaffoldMode = true}) : super(key: ProdutoRoutes.listScreenKey);
    final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
      final scaffoldMode;

  @override
  Widget build(BuildContext context) {
    return  BlocListener<ProdutoBloc, ProdutoState>(
      listener: (context, state) {
        if(state.deleteStatus == ProdutoDeleteStatus.ok) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
              content: new Text('Produto deleted successfuly')
          ));
        }
      },
      child: scaffoldMode ? Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
    title:Text('Produtos List'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: BlocBuilder<ProdutoBloc, ProdutoState>(
              buildWhen: (previous, current) => previous.produtos != current.produtos,
              builder: (context, state) {
                return Visibility(
                  visible: state.produtoStatusUI == ProdutoStatusUI.done,
                  replacement: LoadingIndicator(),
                  child: Column(children: <Widget>[
                    for (Produto produto in state.produtos) produtoCard(produto, context)
                  ]),
                );
              }
            ),
          ),
        drawer: BlocProvider<DrawerBloc>(
            create: (context) => DrawerBloc(loginRepository: LoginRepository()),
            child: CocoverdeDrawer()),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, ProdutoRoutes.create),
          child: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
          backgroundColor: Theme.of(context).primaryColor,
        )
      )
      : Column(
        children: [
          Row(
            children: [
              Text("Liste de Produto", style: Theme.of(context).textTheme.headlineSmall),
              ElevatedButton(onPressed: () => Navigator.pushNamed(context, ProdutoRoutes.create), child: Icon(Icons.add))
            ],
          ),
          SingleChildScrollView(
                  padding: const EdgeInsets.all(15.0),
                  child: BlocBuilder<ProdutoBloc, ProdutoState>(
            buildWhen: (previous, current) => previous.produtos != current.produtos,
            builder: (context, state) {
              return Visibility(
                visible: state.produtoStatusUI == ProdutoStatusUI.done,
                replacement: LoadingIndicator(),
                child: Column(children: <Widget>[
                  for (Produto produto in state.produtos) produtoCard(produto, context)
                ]),
              );
            }
                  ),
                ),
        ],
      ),
    );
  }

  Widget produtoCard(Produto produto, BuildContext context) {
    ProdutoBloc produtoBloc = BlocProvider.of<ProdutoBloc>(context);
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
                    title: Text('Nome : ${produto.nome.toString()}'),
                    subtitle: Text('Descricao : ${produto.descricao.toString()}'),
              trailing: DropdownButton(
                  icon: Icon(Icons.more_vert),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case "Edit":
                        Navigator.pushNamed(
                            context, ProdutoRoutes.edit,
                            arguments: EntityArguments(produto.id));
                        break;
                      case "Delete":
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return deleteDialog(
                              produtoBloc, context, produto.id);
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
                  context, ProdutoRoutes.view,
                  arguments: EntityArguments(produto.id)),
            ),
          ],
        ),
      ),
    );
  }

  Widget deleteDialog(ProdutoBloc produtoBloc, BuildContext context, int? id) {
    return BlocProvider<ProdutoBloc>.value(
      value: produtoBloc,
      child: AlertDialog(
        title: new Text('Delete Produtos'),
        content: new Text('Are you sure?'),
        actions: <Widget>[
          new TextButton(
            child: new Text('Yes'),
            onPressed: () {
              produtoBloc.add(DeleteProdutoById(id: id));
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
