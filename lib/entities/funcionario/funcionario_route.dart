
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/shared/models/entity_arguments.dart';

import 'bloc/funcionario_bloc.dart';
import 'funcionario_list_screen.dart';
import 'funcionario_repository.dart';
import 'funcionario_update_screen.dart';
import 'funcionario_view_screen.dart';

class FuncionarioRoutes {
  static final list = '/entities/funcionario-list';
  static final create = '/entities/funcionario-create';
  static final edit = '/entities/funcionario-edit';
  static final view = '/entities/funcionario-view';

  static const listScreenKey = Key('__funcionarioListScreen__');
  static const createScreenKey = Key('__funcionarioCreateScreen__');
  static const editScreenKey = Key('__funcionarioEditScreen__');
  static const viewScreenKey = Key('__funcionarioViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<FuncionarioBloc>(
          create: (context) => FuncionarioBloc(funcionarioRepository: FuncionarioRepository())
            ..add(InitFuncionarioList()),
          child: FuncionarioListScreen());
    },
    create: (context) {
      return BlocProvider<FuncionarioBloc>(
          create: (context) => FuncionarioBloc(funcionarioRepository: FuncionarioRepository()),
          child: FuncionarioUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<FuncionarioBloc>(
          create: (context) => FuncionarioBloc(funcionarioRepository: FuncionarioRepository())
            ..add(LoadFuncionarioByIdForEdit(id: arguments.id)),
          child: FuncionarioUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<FuncionarioBloc>(
          create: (context) => FuncionarioBloc(funcionarioRepository: FuncionarioRepository())
            ..add(LoadFuncionarioByIdForView(id: arguments.id)),
          child: FuncionarioViewScreen());
    },
  };
}
