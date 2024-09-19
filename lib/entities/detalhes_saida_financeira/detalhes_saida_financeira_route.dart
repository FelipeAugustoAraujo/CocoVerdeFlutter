
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/shared/models/entity_arguments.dart';

import 'bloc/detalhes_saida_financeira_bloc.dart';
import 'detalhes_saida_financeira_list_screen.dart';
import 'detalhes_saida_financeira_repository.dart';
import 'detalhes_saida_financeira_update_screen.dart';
import 'detalhes_saida_financeira_view_screen.dart';

class DetalhesSaidaFinanceiraRoutes {
  static final list = '/entities/detalhesSaidaFinanceira-list';
  static final create = '/entities/detalhesSaidaFinanceira-create';
  static final edit = '/entities/detalhesSaidaFinanceira-edit';
  static final view = '/entities/detalhesSaidaFinanceira-view';

  static const listScreenKey = Key('__detalhesSaidaFinanceiraListScreen__');
  static const createScreenKey = Key('__detalhesSaidaFinanceiraCreateScreen__');
  static const editScreenKey = Key('__detalhesSaidaFinanceiraEditScreen__');
  static const viewScreenKey = Key('__detalhesSaidaFinanceiraViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<DetalhesSaidaFinanceiraBloc>(
          create: (context) => DetalhesSaidaFinanceiraBloc(detalhesSaidaFinanceiraRepository: DetalhesSaidaFinanceiraRepository())
            ..add(InitDetalhesSaidaFinanceiraList()),
          child: DetalhesSaidaFinanceiraListScreen());
    },
    create: (context) {
      return BlocProvider<DetalhesSaidaFinanceiraBloc>(
          create: (context) => DetalhesSaidaFinanceiraBloc(detalhesSaidaFinanceiraRepository: DetalhesSaidaFinanceiraRepository()),
          child: DetalhesSaidaFinanceiraUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<DetalhesSaidaFinanceiraBloc>(
          create: (context) => DetalhesSaidaFinanceiraBloc(detalhesSaidaFinanceiraRepository: DetalhesSaidaFinanceiraRepository())
            ..add(LoadDetalhesSaidaFinanceiraByIdForEdit(id: arguments.id)),
          child: DetalhesSaidaFinanceiraUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<DetalhesSaidaFinanceiraBloc>(
          create: (context) => DetalhesSaidaFinanceiraBloc(detalhesSaidaFinanceiraRepository: DetalhesSaidaFinanceiraRepository())
            ..add(LoadDetalhesSaidaFinanceiraByIdForView(id: arguments.id)),
          child: DetalhesSaidaFinanceiraViewScreen());
    },
  };
}
