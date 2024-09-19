
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/shared/models/entity_arguments.dart';

import 'bloc/fornecedor_bloc.dart';
import 'fornecedor_list_screen.dart';
import 'fornecedor_repository.dart';
import 'fornecedor_update_screen.dart';
import 'fornecedor_view_screen.dart';

class FornecedorRoutes {
  static final list = '/entities/fornecedor-list';
  static final create = '/entities/fornecedor-create';
  static final edit = '/entities/fornecedor-edit';
  static final view = '/entities/fornecedor-view';

  static const listScreenKey = Key('__fornecedorListScreen__');
  static const createScreenKey = Key('__fornecedorCreateScreen__');
  static const editScreenKey = Key('__fornecedorEditScreen__');
  static const viewScreenKey = Key('__fornecedorViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<FornecedorBloc>(
          create: (context) => FornecedorBloc(fornecedorRepository: FornecedorRepository())
            ..add(InitFornecedorList()),
          child: FornecedorListScreen());
    },
    create: (context) {
      return BlocProvider<FornecedorBloc>(
          create: (context) => FornecedorBloc(fornecedorRepository: FornecedorRepository()),
          child: FornecedorUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<FornecedorBloc>(
          create: (context) => FornecedorBloc(fornecedorRepository: FornecedorRepository())
            ..add(LoadFornecedorByIdForEdit(id: arguments.id)),
          child: FornecedorUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<FornecedorBloc>(
          create: (context) => FornecedorBloc(fornecedorRepository: FornecedorRepository())
            ..add(LoadFornecedorByIdForView(id: arguments.id)),
          child: FornecedorViewScreen());
    },
  };
}
