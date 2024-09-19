
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/shared/models/entity_arguments.dart';

import 'bloc/produto_bloc.dart';
import 'produto_list_screen.dart';
import 'produto_repository.dart';
import 'produto_update_screen.dart';
import 'produto_view_screen.dart';

class ProdutoRoutes {
  static final list = '/entities/produto-list';
  static final create = '/entities/produto-create';
  static final edit = '/entities/produto-edit';
  static final view = '/entities/produto-view';

  static const listScreenKey = Key('__produtoListScreen__');
  static const createScreenKey = Key('__produtoCreateScreen__');
  static const editScreenKey = Key('__produtoEditScreen__');
  static const viewScreenKey = Key('__produtoViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<ProdutoBloc>(
          create: (context) => ProdutoBloc(produtoRepository: ProdutoRepository())
            ..add(InitProdutoList()),
          child: ProdutoListScreen());
    },
    create: (context) {
      return BlocProvider<ProdutoBloc>(
          create: (context) => ProdutoBloc(produtoRepository: ProdutoRepository()),
          child: ProdutoUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<ProdutoBloc>(
          create: (context) => ProdutoBloc(produtoRepository: ProdutoRepository())
            ..add(LoadProdutoByIdForEdit(id: arguments.id)),
          child: ProdutoUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<ProdutoBloc>(
          create: (context) => ProdutoBloc(produtoRepository: ProdutoRepository())
            ..add(LoadProdutoByIdForView(id: arguments.id)),
          child: ProdutoViewScreen());
    },
  };
}
