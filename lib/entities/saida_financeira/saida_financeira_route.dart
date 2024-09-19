
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/shared/models/entity_arguments.dart';

import 'bloc/saida_financeira_bloc.dart';
import 'saida_financeira_list_screen.dart';
import 'saida_financeira_repository.dart';
import 'saida_financeira_update_screen.dart';
import 'saida_financeira_view_screen.dart';

class SaidaFinanceiraRoutes {
  static final list = '/entities/saidaFinanceira-list';
  static final create = '/entities/saidaFinanceira-create';
  static final edit = '/entities/saidaFinanceira-edit';
  static final view = '/entities/saidaFinanceira-view';

  static const listScreenKey = Key('__saidaFinanceiraListScreen__');
  static const createScreenKey = Key('__saidaFinanceiraCreateScreen__');
  static const editScreenKey = Key('__saidaFinanceiraEditScreen__');
  static const viewScreenKey = Key('__saidaFinanceiraViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<SaidaFinanceiraBloc>(
          create: (context) => SaidaFinanceiraBloc(saidaFinanceiraRepository: SaidaFinanceiraRepository())
            ..add(InitSaidaFinanceiraList()),
          child: SaidaFinanceiraListScreen());
    },
    create: (context) {
      return BlocProvider<SaidaFinanceiraBloc>(
          create: (context) => SaidaFinanceiraBloc(saidaFinanceiraRepository: SaidaFinanceiraRepository()),
          child: SaidaFinanceiraUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<SaidaFinanceiraBloc>(
          create: (context) => SaidaFinanceiraBloc(saidaFinanceiraRepository: SaidaFinanceiraRepository())
            ..add(LoadSaidaFinanceiraByIdForEdit(id: arguments.id)),
          child: SaidaFinanceiraUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<SaidaFinanceiraBloc>(
          create: (context) => SaidaFinanceiraBloc(saidaFinanceiraRepository: SaidaFinanceiraRepository())
            ..add(LoadSaidaFinanceiraByIdForView(id: arguments.id)),
          child: SaidaFinanceiraViewScreen());
    },
  };
}
