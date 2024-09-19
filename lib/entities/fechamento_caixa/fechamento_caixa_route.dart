
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoverde/shared/models/entity_arguments.dart';

import 'bloc/fechamento_caixa_bloc.dart';
import 'fechamento_caixa_list_screen.dart';
import 'fechamento_caixa_repository.dart';
import 'fechamento_caixa_update_screen.dart';
import 'fechamento_caixa_view_screen.dart';

class FechamentoCaixaRoutes {
  static final list = '/entities/fechamentoCaixa-list';
  static final create = '/entities/fechamentoCaixa-create';
  static final edit = '/entities/fechamentoCaixa-edit';
  static final view = '/entities/fechamentoCaixa-view';

  static const listScreenKey = Key('__fechamentoCaixaListScreen__');
  static const createScreenKey = Key('__fechamentoCaixaCreateScreen__');
  static const editScreenKey = Key('__fechamentoCaixaEditScreen__');
  static const viewScreenKey = Key('__fechamentoCaixaViewScreen__');

  static final map = <String, WidgetBuilder>{
    list: (context) {
      return BlocProvider<FechamentoCaixaBloc>(
          create: (context) => FechamentoCaixaBloc(fechamentoCaixaRepository: FechamentoCaixaRepository())
            ..add(InitFechamentoCaixaList()),
          child: FechamentoCaixaListScreen());
    },
    create: (context) {
      return BlocProvider<FechamentoCaixaBloc>(
          create: (context) => FechamentoCaixaBloc(fechamentoCaixaRepository: FechamentoCaixaRepository()),
          child: FechamentoCaixaUpdateScreen());
    },
    edit: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<FechamentoCaixaBloc>(
          create: (context) => FechamentoCaixaBloc(fechamentoCaixaRepository: FechamentoCaixaRepository())
            ..add(LoadFechamentoCaixaByIdForEdit(id: arguments.id)),
          child: FechamentoCaixaUpdateScreen());
    },
    view: (context) {
      EntityArguments? arguments = ModalRoute.of(context)?.settings.arguments as EntityArguments;
      return BlocProvider<FechamentoCaixaBloc>(
          create: (context) => FechamentoCaixaBloc(fechamentoCaixaRepository: FechamentoCaixaRepository())
            ..add(LoadFechamentoCaixaByIdForView(id: arguments.id)),
          child: FechamentoCaixaViewScreen());
    },
  };
}
