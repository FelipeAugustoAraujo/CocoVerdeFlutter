
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';

import 'bloc/detalhes_entrada_financeira_bloc.dart';
import 'detalhes_entrada_financeira_list_screen.dart';
import 'detalhes_entrada_financeira_repository.dart';
import 'detalhes_entrada_financeira_update_screen.dart';
import 'detalhes_entrada_financeira_view_screen.dart';

class DetalhesEntradaFinanceiraRoutes {
  static final list = '/entities/detalhesEntradaFinanceira-list';
  static final create = '/entities/detalhesEntradaFinanceira-create';
  static final edit = '/entities/detalhesEntradaFinanceira-edit';
  static final view = '/entities/detalhesEntradaFinanceira-view';

  static const listScreenKey = Key('__detalhesEntradaFinanceiraListScreen__');
  static const createScreenKey = Key('__detalhesEntradaFinanceiraCreateScreen__');
  static const editScreenKey = Key('__detalhesEntradaFinanceiraEditScreen__');
  static const viewScreenKey = Key('__detalhesEntradaFinanceiraViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<DetalhesEntradaFinanceiraBloc>(
          create: (context) => DetalhesEntradaFinanceiraBloc(detalhesEntradaFinanceiraRepository: DetalhesEntradaFinanceiraRepository())
            ..add(InitDetalhesEntradaFinanceiraList()),
          child: DetalhesEntradaFinanceiraListScreen());
    },
    create: (context) {
      return BlocProvider<DetalhesEntradaFinanceiraBloc>(
          create: (context) => DetalhesEntradaFinanceiraBloc(detalhesEntradaFinanceiraRepository: DetalhesEntradaFinanceiraRepository()),
          child: DetalhesEntradaFinanceiraUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<DetalhesEntradaFinanceiraBloc>(
          create: (context) => DetalhesEntradaFinanceiraBloc(detalhesEntradaFinanceiraRepository: DetalhesEntradaFinanceiraRepository())
            ..add(LoadDetalhesEntradaFinanceiraByIdForEdit(id: arguments.id)),
          child: DetalhesEntradaFinanceiraUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<DetalhesEntradaFinanceiraBloc>(
          create: (context) => DetalhesEntradaFinanceiraBloc(detalhesEntradaFinanceiraRepository: DetalhesEntradaFinanceiraRepository())
            ..add(LoadDetalhesEntradaFinanceiraByIdForView(id: arguments.id)),
          child: DetalhesEntradaFinanceiraViewScreen());
    },
  };
}
