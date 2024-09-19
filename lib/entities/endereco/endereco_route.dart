
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/shared/models/entity_arguments.dart';

import 'bloc/endereco_bloc.dart';
import 'endereco_list_screen.dart';
import 'endereco_repository.dart';
import 'endereco_update_screen.dart';
import 'endereco_view_screen.dart';

class EnderecoRoutes {
  static final list = '/entities/endereco-list';
  static final create = '/entities/endereco-create';
  static final edit = '/entities/endereco-edit';
  static final view = '/entities/endereco-view';

  static const listScreenKey = Key('__enderecoListScreen__');
  static const createScreenKey = Key('__enderecoCreateScreen__');
  static const editScreenKey = Key('__enderecoEditScreen__');
  static const viewScreenKey = Key('__enderecoViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<EnderecoBloc>(
          create: (context) => EnderecoBloc(enderecoRepository: EnderecoRepository())
            ..add(InitEnderecoList()),
          child: EnderecoListScreen());
    },
    create: (context) {
      return BlocProvider<EnderecoBloc>(
          create: (context) => EnderecoBloc(enderecoRepository: EnderecoRepository()),
          child: EnderecoUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<EnderecoBloc>(
          create: (context) => EnderecoBloc(enderecoRepository: EnderecoRepository())
            ..add(LoadEnderecoByIdForEdit(id: arguments.id)),
          child: EnderecoUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<EnderecoBloc>(
          create: (context) => EnderecoBloc(enderecoRepository: EnderecoRepository())
            ..add(LoadEnderecoByIdForView(id: arguments.id)),
          child: EnderecoViewScreen());
    },
  };
}
