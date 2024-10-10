
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';

import 'bloc/frente_bloc.dart';
import 'frente_list_screen.dart';
import 'frente_repository.dart';
import 'frente_update_screen.dart';
import 'frente_view_screen.dart';

class FrenteRoutes {
  static final list = '/entities/frente-list';
  static final create = '/entities/frente-create';
  static final edit = '/entities/frente-edit';
  static final view = '/entities/frente-view';

  static const listScreenKey = Key('__frenteListScreen__');
  static const createScreenKey = Key('__frenteCreateScreen__');
  static const editScreenKey = Key('__frenteEditScreen__');
  static const viewScreenKey = Key('__frenteViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<FrenteBloc>(
          create: (context) => FrenteBloc(frenteRepository: FrenteRepository())
            ..add(InitFrenteList()),
          child: FrenteListScreen());
    },
    create: (context) {
      return BlocProvider<FrenteBloc>(
          create: (context) => FrenteBloc(frenteRepository: FrenteRepository()),
          child: FrenteUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<FrenteBloc>(
          create: (context) => FrenteBloc(frenteRepository: FrenteRepository())
            ..add(LoadFrenteByIdForEdit(id: arguments.id)),
          child: FrenteUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<FrenteBloc>(
          create: (context) => FrenteBloc(frenteRepository: FrenteRepository())
            ..add(LoadFrenteByIdForView(id: arguments.id)),
          child: FrenteViewScreen());
    },
  };
}
