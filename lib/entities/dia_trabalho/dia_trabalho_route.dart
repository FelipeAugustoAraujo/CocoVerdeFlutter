
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/shared/models/entity_arguments.dart';

import 'bloc/dia_trabalho_bloc.dart';
import 'dia_trabalho_list_screen.dart';
import 'dia_trabalho_repository.dart';
import 'dia_trabalho_update_screen.dart';
import 'dia_trabalho_view_screen.dart';

class DiaTrabalhoRoutes {
  static final list = '/entities/diaTrabalho-list';
  static final create = '/entities/diaTrabalho-create';
  static final edit = '/entities/diaTrabalho-edit';
  static final view = '/entities/diaTrabalho-view';

  static const listScreenKey = Key('__diaTrabalhoListScreen__');
  static const createScreenKey = Key('__diaTrabalhoCreateScreen__');
  static const editScreenKey = Key('__diaTrabalhoEditScreen__');
  static const viewScreenKey = Key('__diaTrabalhoViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<DiaTrabalhoBloc>(
          create: (context) => DiaTrabalhoBloc(diaTrabalhoRepository: DiaTrabalhoRepository())
            ..add(InitDiaTrabalhoList()),
          child: DiaTrabalhoListScreen());
    },
    create: (context) {
      return BlocProvider<DiaTrabalhoBloc>(
          create: (context) => DiaTrabalhoBloc(diaTrabalhoRepository: DiaTrabalhoRepository()),
          child: DiaTrabalhoUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<DiaTrabalhoBloc>(
          create: (context) => DiaTrabalhoBloc(diaTrabalhoRepository: DiaTrabalhoRepository())
            ..add(LoadDiaTrabalhoByIdForEdit(id: arguments.id)),
          child: DiaTrabalhoUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<DiaTrabalhoBloc>(
          create: (context) => DiaTrabalhoBloc(diaTrabalhoRepository: DiaTrabalhoRepository())
            ..add(LoadDiaTrabalhoByIdForView(id: arguments.id)),
          child: DiaTrabalhoViewScreen());
    },
  };
}
