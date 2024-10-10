
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/shared/models/entity_arguments.dart';

import 'bloc/cliente_bloc.dart';
import 'cliente_list_screen.dart';
import 'cliente_repository.dart';
import 'cliente_update_screen.dart';
import 'cliente_view_screen.dart';

class ClienteRoutes {
  static final list = '/entities/cliente-list';
  static final create = '/entities/cliente-create';
  static final edit = '/entities/cliente-edit';
  static final view = '/entities/cliente-view';

  static const listScreenKey = Key('__clienteListScreen__');
  static const createScreenKey = Key('__clienteCreateScreen__');
  static const editScreenKey = Key('__clienteEditScreen__');
  static const viewScreenKey = Key('__clienteViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<ClienteBloc>(
          create: (context) => ClienteBloc(clienteRepository: ClienteRepository())
            ..add(InitClienteList()),
          child: ClienteListScreen());
    },
    create: (context) {
      return BlocProvider<ClienteBloc>(
          create: (context) => ClienteBloc(clienteRepository: ClienteRepository()),
          child: ClienteUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<ClienteBloc>(
          create: (context) => ClienteBloc(clienteRepository: ClienteRepository())
            ..add(LoadClienteByIdForEdit(id: arguments.id)),
          child: ClienteUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<ClienteBloc>(
          create: (context) => ClienteBloc(clienteRepository: ClienteRepository())
            ..add(LoadClienteByIdForView(id: arguments.id)),
          child: ClienteViewScreen());
    },
  };
}
