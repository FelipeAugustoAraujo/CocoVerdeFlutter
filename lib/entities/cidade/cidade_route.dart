
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';

import 'bloc/cidade_bloc.dart';
import 'cidade_list_screen.dart';
import 'cidade_repository.dart';
import 'cidade_update_screen.dart';
import 'cidade_view_screen.dart';

class CidadeRoutes {
  static final list = '/entities/cidade-list';
  static final create = '/entities/cidade-create';
  static final edit = '/entities/cidade-edit';
  static final view = '/entities/cidade-view';

  static const listScreenKey = Key('__cidadeListScreen__');
  static const createScreenKey = Key('__cidadeCreateScreen__');
  static const editScreenKey = Key('__cidadeEditScreen__');
  static const viewScreenKey = Key('__cidadeViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<CidadeBloc>(
          create: (context) => CidadeBloc(cidadeRepository: CidadeRepository())
            ..add(InitCidadeList()),
          child: CidadeListScreen());
    },
    create: (context) {
      return BlocProvider<CidadeBloc>(
          create: (context) => CidadeBloc(cidadeRepository: CidadeRepository()),
          child: CidadeUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<CidadeBloc>(
          create: (context) => CidadeBloc(cidadeRepository: CidadeRepository())
            ..add(LoadCidadeByIdForEdit(id: arguments.id)),
          child: CidadeUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<CidadeBloc>(
          create: (context) => CidadeBloc(cidadeRepository: CidadeRepository())
            ..add(LoadCidadeByIdForView(id: arguments.id)),
          child: CidadeViewScreen());
    },
  };
}
