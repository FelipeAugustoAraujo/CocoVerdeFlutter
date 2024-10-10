
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';

import 'bloc/entrada_financeira_bloc.dart';
import 'entrada_financeira_list_screen.dart';
import 'entrada_financeira_repository.dart';
import 'entrada_financeira_update_screen.dart';
import 'entrada_financeira_view_screen.dart';

class EntradaFinanceiraRoutes {
  static final list = '/entities/entradaFinanceira-list';
  static final create = '/entities/entradaFinanceira-create';
  static final edit = '/entities/entradaFinanceira-edit';
  static final view = '/entities/entradaFinanceira-view';

  static const listScreenKey = Key('__entradaFinanceiraListScreen__');
  static const createScreenKey = Key('__entradaFinanceiraCreateScreen__');
  static const editScreenKey = Key('__entradaFinanceiraEditScreen__');
  static const viewScreenKey = Key('__entradaFinanceiraViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<EntradaFinanceiraBloc>(
          create: (context) => EntradaFinanceiraBloc(entradaFinanceiraRepository: EntradaFinanceiraRepository())
            ..add(InitEntradaFinanceiraList()),
          child: EntradaFinanceiraListScreen());
    },
    create: (context) {
      return BlocProvider<EntradaFinanceiraBloc>(
          create: (context) => EntradaFinanceiraBloc(entradaFinanceiraRepository: EntradaFinanceiraRepository()),
          child: EntradaFinanceiraUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<EntradaFinanceiraBloc>(
          create: (context) => EntradaFinanceiraBloc(entradaFinanceiraRepository: EntradaFinanceiraRepository())
            ..add(LoadEntradaFinanceiraByIdForEdit(id: arguments.id)),
          child: EntradaFinanceiraUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<EntradaFinanceiraBloc>(
          create: (context) => EntradaFinanceiraBloc(entradaFinanceiraRepository: EntradaFinanceiraRepository())
            ..add(LoadEntradaFinanceiraByIdForView(id: arguments.id)),
          child: EntradaFinanceiraViewScreen());
    },
  };
}
