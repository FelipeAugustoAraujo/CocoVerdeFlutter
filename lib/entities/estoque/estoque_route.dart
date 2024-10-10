
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';

import 'bloc/estoque_bloc.dart';
import 'estoque_list_screen.dart';
import 'estoque_repository.dart';
import 'estoque_update_screen.dart';
import 'estoque_view_screen.dart';

class EstoqueRoutes {
  static final list = '/entities/estoque-list';
  static final create = '/entities/estoque-create';
  static final edit = '/entities/estoque-edit';
  static final view = '/entities/estoque-view';

  static const listScreenKey = Key('__estoqueListScreen__');
  static const createScreenKey = Key('__estoqueCreateScreen__');
  static const editScreenKey = Key('__estoqueEditScreen__');
  static const viewScreenKey = Key('__estoqueViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<EstoqueBloc>(
          create: (context) => EstoqueBloc(estoqueRepository: EstoqueRepository())
            ..add(InitEstoqueList()),
          child: EstoqueListScreen());
    },
    create: (context) {
      return BlocProvider<EstoqueBloc>(
          create: (context) => EstoqueBloc(estoqueRepository: EstoqueRepository()),
          child: EstoqueUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<EstoqueBloc>(
          create: (context) => EstoqueBloc(estoqueRepository: EstoqueRepository())
            ..add(LoadEstoqueByIdForEdit(id: arguments.id)),
          child: EstoqueUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<EstoqueBloc>(
          create: (context) => EstoqueBloc(estoqueRepository: EstoqueRepository())
            ..add(LoadEstoqueByIdForView(id: arguments.id)),
          child: EstoqueViewScreen());
    },
  };
}
